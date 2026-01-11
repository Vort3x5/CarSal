package carsalapp.service;

import carsalapp.model.Pojazd;
import carsalapp.repository.PojazdRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional
public class PojazdService {

    private final PojazdRepository pojazdRepository;

    public PojazdService(PojazdRepository pojazdRepository) {
        this.pojazdRepository = pojazdRepository;
    }

    public enum ReservationResult {
        SUCCESS,
        VEHICLE_NOT_FOUND,
        ALREADY_RESERVED,
        NOT_AVAILABLE
    }

    public enum CancellationResult {
        SUCCESS,
        VEHICLE_NOT_FOUND,
        NOT_RESERVED,
        WRONG_USER
    }

    public List<Pojazd> findAll() {
        return pojazdRepository.findByDeletedFalse();
    }

    public Page<Pojazd> findAllPaginated(Pageable pageable) {
        return findAllPaginated(null, pageable);
    }

    public Page<Pojazd> findAllPaginated(String search, Pageable pageable) {
        List<Pojazd> allPojazdy = pojazdRepository.findByDeletedFalse();
        
        List<Pojazd> filtered = allPojazdy;
        if (search != null && !search.trim().isEmpty()) {
            String searchLower = search.toLowerCase().trim();
            filtered = allPojazdy.stream()
                .filter(p -> 
                    p.getNrVin().toLowerCase().contains(searchLower) ||
                    (p.getModel() != null && p.getModel().getNazwaModelu().toLowerCase().contains(searchLower)) ||
                    (p.getKolor() != null && p.getKolor().toLowerCase().contains(searchLower))
                )
                .collect(Collectors.toList());
        }

        filtered.sort((p1, p2) -> {
            if (p1.getRokProdukcji() == null && p2.getRokProdukcji() == null) return 0;
            if (p1.getRokProdukcji() == null) return 1;
            if (p2.getRokProdukcji() == null) return -1;
            return p2.getRokProdukcji().compareTo(p1.getRokProdukcji());
        });

        int start = (int) pageable.getOffset();
        int end = Math.min((start + pageable.getPageSize()), filtered.size());
        
        if (start > filtered.size()) {
            return new PageImpl<>(List.of(), pageable, filtered.size());
        }

        List<Pojazd> pageContent = filtered.subList(start, end);
        return new PageImpl<>(pageContent, pageable, filtered.size());
    }

    public Optional<Pojazd> findById(String nrVin) {
        return pojazdRepository.findById(nrVin).filter(p -> !p.isDeleted());
    }

    public List<Pojazd> findByStatus(String status) {
        return pojazdRepository.findByStatusAndDeletedFalse(status);
    }

    public Pojazd save(Pojazd pojazd) {
        return pojazdRepository.save(pojazd);
    }

    public void softDeleteById(String nrVin) {
        pojazdRepository.findById(nrVin).ifPresent(p -> {
            p.setDeleted(true);
            pojazdRepository.save(p);
        });
    }

    public boolean existsById(String nrVin) {
        return pojazdRepository.existsById(nrVin);
    }

    public Page<Pojazd> findAvailableForClients(Long modelId,
                                                Long salonId,
                                                Integer minRok,
                                                Integer maxRok,
                                                BigDecimal minCena,
                                                BigDecimal maxCena,
                                                String stan,
                                                Pageable pageable) {
        List<Pojazd> filtered = pojazdRepository.findByDeletedFalse().stream()
            .filter(p -> "Dostepny".equals(p.getStatus()) || "Rezerwacja".equals(p.getStatus()))
            .filter(p -> modelId == null || modelId.equals(p.getIdModelu()))
            .filter(p -> salonId == null || salonId.equals(p.getNrSalonu()))
            .filter(p -> minRok == null || p.getRokProdukcji() >= minRok)
            .filter(p -> maxRok == null || p.getRokProdukcji() <= maxRok)
            .filter(p -> minCena == null || (p.getCenaKatalogowa() != null && p.getCenaKatalogowa().compareTo(minCena) >= 0))
            .filter(p -> maxCena == null || (p.getCenaKatalogowa() != null && p.getCenaKatalogowa().compareTo(maxCena) <= 0))
            .filter(p -> stan == null || stan.isBlank() || stan.equalsIgnoreCase(p.getStan()))
            .sorted((p1, p2) -> {
                if (p1.getCenaKatalogowa() == null && p2.getCenaKatalogowa() == null) return 0;
                if (p1.getCenaKatalogowa() == null) return 1;
                if (p2.getCenaKatalogowa() == null) return -1;
                return p1.getCenaKatalogowa().compareTo(p2.getCenaKatalogowa());
            })
            .collect(Collectors.toList());

        int start = (int) pageable.getOffset();
        int end = Math.min((start + pageable.getPageSize()), filtered.size());
        
        if (start > filtered.size()) {
            return new PageImpl<>(List.of(), pageable, filtered.size());
        }

        List<Pojazd> pageContent = filtered.subList(start, end);
        return new PageImpl<>(pageContent, pageable, filtered.size());
    }

    public ReservationResult reserveIfAvailable(String nrVin, Long klientId) {
        Optional<Pojazd> pojazdOpt = findById(nrVin);
        
        if (pojazdOpt.isEmpty()) {
            return ReservationResult.VEHICLE_NOT_FOUND;
        }
        
        if (klientId == null) {
            return ReservationResult.NOT_AVAILABLE;
        }

        Pojazd pojazd = pojazdOpt.get();
        
        if ("Dostepny".equals(pojazd.getStatus())) {
            pojazd.setStatus("Rezerwacja");
            pojazd.setNrKlientaRezerwujacego(klientId);
            pojazdRepository.save(pojazd);
            return ReservationResult.SUCCESS;
        } else if ("Rezerwacja".equals(pojazd.getStatus())) {
            return ReservationResult.ALREADY_RESERVED;
        } else {
            return ReservationResult.NOT_AVAILABLE;
        }
    }

    public CancellationResult cancelReservation(String nrVin, Long klientId) {
        Optional<Pojazd> pojazdOpt = findById(nrVin);
        
        if (pojazdOpt.isEmpty()) {
            return CancellationResult.VEHICLE_NOT_FOUND;
        }
        
        if (klientId == null) {
            return CancellationResult.WRONG_USER;
        }

        Pojazd pojazd = pojazdOpt.get();
        
        if (!"Rezerwacja".equals(pojazd.getStatus())) {
            return CancellationResult.NOT_RESERVED;
        }
        
        if (!klientId.equals(pojazd.getNrKlientaRezerwujacego())) {
            return CancellationResult.WRONG_USER;
        }

        pojazd.setStatus("Dostepny");
        pojazd.setNrKlientaRezerwujacego(null);
        pojazdRepository.save(pojazd);
        return CancellationResult.SUCCESS;
    }
}
