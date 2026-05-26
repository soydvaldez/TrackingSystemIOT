package io.tracksystem.sensor.application;

import java.util.List;

import org.springframework.stereotype.Service;

import io.tracksystem.sensor.infrastructure.SensorEntity;
import io.tracksystem.sensor.infrastructure.SensorIoTRepository;
import io.tracksystem.sensor.presentation.request.SensorRequest;

import java.util.Optional;

@Service
public class SensorUseCase {

    private final SensorIoTRepository sensorRepository;

    public SensorUseCase(SensorIoTRepository sensorRepository) {
        this.sensorRepository = sensorRepository;
    }

    public List<SensorEntity> getAll() {
        return sensorRepository.findAll();
    }

    public SensorEntity save(SensorRequest sensorRequestDTO) {
        SensorEntity sensorAdded = sensorRepository.save(convertRequestDTOtoEntity(sensorRequestDTO));
        return sensorAdded;
    }

    public Optional<SensorEntity> findBySensorId(Long sensorId) {
        return sensorRepository.findById(sensorId);
    }

    public SensorEntity save(SensorEntity sensorToUpdate) {
        return sensorRepository.save(sensorToUpdate);
    }

    public void delete(SensorEntity sensorEntity) {
        sensorRepository.delete(sensorEntity);
    }

    private SensorEntity convertRequestDTOtoEntity(SensorRequest sensorRequestDTO) {
        SensorEntity sensorEntity = new SensorEntity();
        sensorEntity.setName(sensorRequestDTO.getSensorName());
        sensorEntity.setLocation(sensorRequestDTO.getLocation());
        sensorEntity.setCreatedAt(sensorRequestDTO.getInstallationDate());
        sensorEntity.setUpdatedAt(sensorRequestDTO.getInstallationDate());
        sensorEntity.setStatus(sensorRequestDTO.getStatus());

        return sensorEntity;
    }

    private SensorRequest convertEntityToRequestDTO(SensorEntity sensorEntity) {
        SensorRequest sensorDTO = new SensorRequest();
        sensorDTO.setSensorName(sensorEntity.getName());
        sensorDTO.setLocation(sensorEntity.getLocation());
        sensorDTO.setInstallationDate(sensorEntity.getCreatedAt());
        sensorDTO.setStatus(sensorEntity.getStatus());

        return sensorDTO;
    }
}
