package com.twojafirma.carsalapp.repository;

import com.twojafirma.carsalapp.model.Salon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SalonRepository extends JpaRepository<Salon, Long> {
    Optional<Salon> findByNazwa(String nazwa);
}
