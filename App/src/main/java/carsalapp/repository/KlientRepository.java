package carsalapp.repository;

import carsalapp.model.Klient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface KlientRepository extends JpaRepository<Klient, Long> {
    Optional<Klient> findByUsername(String username);
    Optional<Klient> findByEmail(String email);
    Optional<Klient> findByPesel(String pesel);
}
