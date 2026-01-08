package carsalapp.service;

import carsalapp.model.Pojazd;
import carsalapp.repository.PojazdRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
}
