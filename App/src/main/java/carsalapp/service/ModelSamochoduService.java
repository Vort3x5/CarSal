package carsalapp.service;

import carsalapp.model.ModelSamochodu;
import carsalapp.repository.ModelSamochoduRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ModelSamochoduService {

    private final ModelSamochoduRepository modelRepository;

    public ModelSamochoduService(ModelSamochoduRepository modelRepository) {
        this.modelRepository = modelRepository;
    }

    public List<ModelSamochodu> findAll() {
        return modelRepository.findAll();
    }

    public Optional<ModelSamochodu> findById(Long id) {
        return modelRepository.findById(id);
    }
}
