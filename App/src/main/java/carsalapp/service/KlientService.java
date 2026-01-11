package carsalapp.service;

import carsalapp.model.Klient;
import carsalapp.repository.KlientRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class KlientService {

    private final KlientRepository klientRepository;

    public KlientService(KlientRepository klientRepository) {
        this.klientRepository = klientRepository;
    }

    public List<Klient> findAll() {
        return klientRepository.findAll();
    }

    public Page<Klient> findAllPaginated(Pageable pageable) {
        return klientRepository.findAll(pageable);
    }

    public Optional<Klient> findById(Long id) {
        return klientRepository.findById(id);
    }

    public Optional<Klient> findByEmail(String email) {
        return klientRepository.findByEmail(email);
    }

    public Optional<Klient> findByUsername(String username) {
        return klientRepository.findByUsername(username);
    }

    public Klient save(Klient klient) {
        if (klient.getDataRejestracji() == null) {
            klient.setDataRejestracji(LocalDate.now());
        }
        return klientRepository.save(klient);
    }

    public void deleteById(Long id) {
        klientRepository.deleteById(id);
    }

    public boolean existsByEmail(String email) {
        return klientRepository.findByEmail(email).isPresent();
    }
}
