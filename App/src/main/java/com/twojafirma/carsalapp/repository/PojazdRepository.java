package com.twojafirma.carsalapp.repository;

import com.twojafirma.carsalapp.model.Pojazd;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PojazdRepository extends JpaRepository<Pojazd, String> {
    List<Pojazd> findByStatus(String status);
    List<Pojazd> findByIdModelu(Long idModelu);
}
