package com.twojafirma.carsalapp.service;

import com.twojafirma.carsalapp.model.Pojazd;
import com.twojafirma.carsalapp.repository.PojazdRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class PojazdService {

    @Autowired
    private PojazdRepository pojazdRepository;

    public List<Pojazd> findAll() {
        return pojazdRepository.findByDeletedFalse();
    }

    public Optional<Pojazd> findById(String nrVin) {
        return pojazdRepository.findById(nrVin).filter(p -> p.getDeleted() == null || !p.getDeleted());
    }

    public List<Pojazd> findByStatus(String status) {
        return pojazdRepository.findByStatusAndDeletedFalse(status);
    }

    public List<Pojazd> findByIdModelu(Long idModelu) {
        return pojazdRepository.findByIdModeluAndDeletedFalse(idModelu);
    }

    public Pojazd save(Pojazd pojazd) {
        if (pojazd.getDeleted() == null) {
            pojazd.setDeleted(false);
        }
        return pojazdRepository.save(pojazd);
    }

    public void deleteById(String nrVin) {
        Optional<Pojazd> opt = pojazdRepository.findById(nrVin);
        if (opt.isPresent()) {
            Pojazd p = opt.get();
            p.setDeleted(true);
            p.setStatus("Wycofany");
            pojazdRepository.save(p);
        }
    }

    public boolean existsById(String nrVin) {
        return pojazdRepository.existsById(nrVin) && findById(nrVin).isPresent();
    }
}
