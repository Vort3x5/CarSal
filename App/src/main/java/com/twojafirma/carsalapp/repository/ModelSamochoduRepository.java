package com.twojafirma.carsalapp.repository;

import com.twojafirma.carsalapp.model.ModelSamochodu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ModelSamochoduRepository extends JpaRepository<ModelSamochodu, Long> {
}
