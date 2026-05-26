package io.tracksystem.sensor.presentation;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import io.tracksystem.sensor.application.SensorUseCase;
import io.tracksystem.sensor.infrastructure.SensorEntity;
import io.tracksystem.sensor.presentation.request.SensorRequest;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.net.URI;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/sensors")
public class SensorController {

    private final SensorUseCase sensorUseCase;

    public SensorController(SensorUseCase sensorUseCase) {
        this.sensorUseCase = sensorUseCase;
    }

    @GetMapping
    public ResponseEntity<List<SensorEntity>> getAll() {
        return ResponseEntity.ok(sensorUseCase.getAll());
    }

    @GetMapping("/{sensorId}")
    public ResponseEntity<SensorEntity> getSensorById(@PathVariable("sensorId") Long sensorId) {
        return sensorUseCase.findBySensorId(sensorId)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<SensorEntity> newSensor(@RequestBody SensorRequest sensorRequestDTO,
            UriComponentsBuilder uriBuilder) {

        SensorEntity savedSensor = sensorUseCase.save(sensorRequestDTO);
        String locationUri = uriBuilder.path("/sensors/{id}")
                .buildAndExpand(savedSensor.getId()).toUriString();

        return ResponseEntity.created(URI.create(locationUri)).body(savedSensor);
    }

    @PutMapping("/{sensorId}")
    public ResponseEntity<SensorEntity> updateSensor(@PathVariable("sensorId") Long sensorId,
            @RequestBody SensorEntity sensorInput) {
        Optional<SensorEntity> sensor = sensorUseCase.findBySensorId(sensorId);

        if (sensor.isPresent()) {
            SensorEntity sensorToUpdate = sensor.get();

            sensorToUpdate.setName(sensorInput.getName());
            sensorToUpdate.setLocation(sensorInput.getLocation());
            sensorToUpdate.setStatus(sensorInput.getStatus());

            SensorEntity updatedsensor = sensorUseCase.save(sensorToUpdate);

            return ResponseEntity.ok(updatedsensor);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{sensorId}")
    public ResponseEntity<Void> deletesensor(@PathVariable("sensorId") Long sensorId) {
        Optional<SensorEntity> sensor = sensorUseCase.findBySensorId(sensorId);

        if (sensor.isPresent()) {
            sensorUseCase.delete(sensor.get());
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
