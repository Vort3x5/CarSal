package com.twojafirma.carsalapp.service;

import com.twojafirma.carsalapp.model.Salon;
import com.twojafirma.carsalapp.repository.SalonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class SalonService {

    @Autowired
    private SalonRepository salonRepository;

    public List<Salon> findAll() {
        return salonRepository.findAll();
    }

    public Optional<Salon> findById(Long id) {
        return salonRepository.findById(id);
    }

    public Optional<Salon> findByNazwa(String nazwa) {
        return salonRepository.findByNazwa(nazwa);
    }

    public Salon save(Salon salon) {
        return salonRepository.save(salon);
    }

    public void deleteById(Long id) {
        salonRepository.deleteById(id);
    }

    public boolean existsById(Long id) {
        return salonRepository.existsById(id);
    }
}
