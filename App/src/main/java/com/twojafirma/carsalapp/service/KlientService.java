package com.twojafirma.carsalapp.service;

import com.twojafirma.carsalapp.model.Klient;
import com.twojafirma.carsalapp.repository.KlientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class KlientService {

    @Autowired
    private KlientRepository klientRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public List<Klient> findAll() {
        return klientRepository.findAll();
    }

    public Optional<Klient> findById(Long id) {
        return klientRepository.findById(id);
    }

    public Optional<Klient> findByEmail(String email) {
        return klientRepository.findByEmail(email);
    }

    public Klient save(Klient klient) {
        if (klient.getDataRejestracji() == null) {
            klient.setDataRejestracji(LocalDate.now());
        }
        if (klient.getHaslo() != null && !klient.getHaslo().startsWith("$2a$")) {
            klient.setHaslo(passwordEncoder.encode(klient.getHaslo()));
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
