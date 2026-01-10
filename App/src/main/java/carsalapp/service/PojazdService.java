package carsalapp.service;

import carsalapp.model.Pojazd;
import carsalapp.repository.PojazdRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class PojazdService {

    private final PojazdRepository pojazdRepository;

    public PojazdService(PojazdRepository pojazdRepository) {
        this.pojazdRepository = pojazdRepository;
    }

    public List<Pojazd> findAll() {
        return pojazdRepository.findByDeletedFalse();
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

    public List<Pojazd> findAvailableForClients(Long modelId,
                                                Long salonId,
                                                Integer minRok,
                                                Integer maxRok,
                                                BigDecimal minCena,
                                                BigDecimal maxCena,
                                                String stan) {
        return pojazdRepository.findByDeletedFalse().stream()
            .filter(p -> "Dostepny".equals(p.getStatus()) || "Rezerwacja".equals(p.getStatus()))
            .filter(p -> modelId == null || modelId.equals(p.getIdModelu()))
            .filter(p -> salonId == null || salonId.equals(p.getNrSalonu()))
            .filter(p -> minRok == null || p.getRokProdukcji() >= minRok)
            .filter(p -> maxRok == null || p.getRokProdukcji() <= maxRok)
            .filter(p -> minCena == null || (p.getCenaKatalogowa() != null && p.getCenaKatalogowa().compareTo(minCena) >= 0))
            .filter(p -> maxCena == null || (p.getCenaKatalogowa() != null && p.getCenaKatalogowa().compareTo(maxCena) <= 0))
            .filter(p -> stan == null || stan.isBlank() || stan.equalsIgnoreCase(p.getStan()))
            .toList();
    }

    public boolean reserveIfAvailable(String nrVin) {
        Optional<Pojazd> pojazdOpt = findById(nrVin);
        if (pojazdOpt.isPresent()) {
            Pojazd pojazd = pojazdOpt.get();
            if ("Dostepny".equals(pojazd.getStatus())) {
                pojazd.setStatus("Rezerwacja");
                pojazdRepository.save(pojazd);
                return true;
            }
        }
        return false;
    }

    public boolean cancelReservation(String nrVin) {
        Optional<Pojazd> pojazdOpt = findById(nrVin);
        if (pojazdOpt.isPresent()) {
            Pojazd pojazd = pojazdOpt.get();
            if ("Rezerwacja".equals(pojazd.getStatus())) {
                pojazd.setStatus("Dostepny");
                pojazdRepository.save(pojazd);
                return true;
            }
        }
        return false;
    }
}
