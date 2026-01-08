package carsalapp.repository;

import carsalapp.model.Pojazd;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PojazdRepository extends JpaRepository<Pojazd, String> {
    List<Pojazd> findByDeletedFalse();
    List<Pojazd> findByStatusAndDeletedFalse(String status);
    List<Pojazd> findByIdModeluAndDeletedFalse(Long idModelu);
}
