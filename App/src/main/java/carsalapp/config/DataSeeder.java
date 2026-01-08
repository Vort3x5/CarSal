package carsalapp.config;

import carsalapp.model.Klient;
import carsalapp.repository.KlientRepository;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
public class DataSeeder {

    private final KlientRepository klientRepository;
    private final PasswordEncoder passwordEncoder;

    public DataSeeder(KlientRepository klientRepository, PasswordEncoder passwordEncoder) {
        this.klientRepository = klientRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @EventListener(ApplicationReadyEvent.class)
    public void seedUsers() {
        seedUser(
            "admin", "admin123", "ADMIN",
            "Firma", null, null, "System Admin Sp. z o.o.",
            null, "9999999990",
            "600000000", "admin@demo.local"
        );
        seedUser(
            "klient1", "klient123", "USER",
            "Indywidualny", "Jan", "Kowalski", null,
            "85010112345", null,
            "501234567", "klient1@demo.local"
        );
        seedUser(
            "klient2", "klient123", "USER",
            "Indywidualny", "Anna", "Nowak", null,
            "90020223456", null,
            "602345678", "klient2@demo.local"
        );
    }

    private void seedUser(String username,
                          String rawPassword,
                          String role,
                          String typKlienta,
                          String imie,
                          String nazwisko,
                          String nazwaFirmy,
                          String pesel,
                          String nip,
                          String telefon,
                          String email) {

        klientRepository.findByUsername(username).ifPresentOrElse(existing -> {
            if (existing.getPasswordHash() == null || existing.getPasswordHash().isEmpty()) {
                existing.setPasswordHash(passwordEncoder.encode(rawPassword));
            }
            if (existing.getRola() == null) {
                existing.setRola(role);
            }
            existing.setEnabled(true);
            if (existing.getTypKlienta() == null) {
                existing.setTypKlienta(typKlienta);
            }
            if ("Indywidualny".equals(existing.getTypKlienta()) && existing.getPesel() == null) {
                existing.setPesel(pesel);
                existing.setImie(imie);
                existing.setNazwisko(nazwisko);
            }
            if ("Firma".equals(existing.getTypKlienta()) && existing.getNip() == null) {
                existing.setNip(nip);
                existing.setNazwaFirmy(nazwaFirmy);
            }
            if (existing.getTelefon() == null) {
                existing.setTelefon(telefon);
            }
            if (existing.getEmail() == null) {
                existing.setEmail(email);
            }
            if (existing.getDataRejestracji() == null) {
                existing.setDataRejestracji(LocalDate.now());
            }
            klientRepository.save(existing);
        }, () -> {
            Klient klient = new Klient();
            klient.setUsername(username);
            klient.setPasswordHash(passwordEncoder.encode(rawPassword));
            klient.setRola(role);
            klient.setEnabled(true);
            klient.setTypKlienta(typKlienta);
            klient.setImie(imie);
            klient.setNazwisko(nazwisko);
            klient.setNazwaFirmy(nazwaFirmy);
            klient.setPesel(pesel);
            klient.setNip(nip);
            klient.setTelefon(telefon);
            klient.setEmail(email);
            klient.setDataRejestracji(LocalDate.now());
            klientRepository.save(klient);
        });
    }
}
