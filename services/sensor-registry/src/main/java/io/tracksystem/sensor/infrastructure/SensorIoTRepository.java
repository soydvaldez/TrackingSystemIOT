package io.tracksystem.sensor.infrastructure;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SensorIoTRepository extends JpaRepository<SensorEntity, Long> {
     SensorEntity findSensorNameById(String name);

     Optional<SensorEntity> findById(Long Id);
}
