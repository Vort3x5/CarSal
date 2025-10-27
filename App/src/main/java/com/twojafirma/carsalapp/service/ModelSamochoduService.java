package com.twojafirma.carsalapp.service;

import com.twojafirma.carsalapp.model.ModelSamochodu;
import com.twojafirma.carsalapp.repository.ModelSamochoduRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ModelSamochoduService {

    @Autowired
    private ModelSamochoduRepository modelRepository;

    public List<ModelSamochodu> findAll() {
        return modelRepository.findAll();
    }

    public Optional<ModelSamochodu> findById(Long id) {
        return modelRepository.findById(id);
    }
}
