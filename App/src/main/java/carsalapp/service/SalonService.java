package carsalapp.service;

import carsalapp.model.Salon;
import carsalapp.repository.SalonRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class SalonService {

    private final SalonRepository salonRepository;

    public SalonService(SalonRepository salonRepository) {
        this.salonRepository = salonRepository;
    }

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
