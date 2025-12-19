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
        return pojazdRepository.findAll();
    }

    public Optional<Pojazd> findById(String nrVin) {
        return pojazdRepository.findById(nrVin);
    }

    public List<Pojazd> findByStatus(String status) {
        return pojazdRepository.findByStatus(status);
    }

    public Pojazd save(Pojazd pojazd) {
        return pojazdRepository.save(pojazd);
    }

    public void deleteById(String nrVin) {
        pojazdRepository.deleteById(nrVin);
    }

    public boolean existsById(String nrVin) {
        return pojazdRepository.existsById(nrVin);
    }
}
