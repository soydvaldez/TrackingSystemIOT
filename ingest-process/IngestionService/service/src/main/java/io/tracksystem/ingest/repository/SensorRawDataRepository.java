package io.tracksystem.ingest.repository;

import org.springframework.stereotype.Repository;
import io.tracksystem.ingest.entity.SensorRawData;
import org.springframework.data.jpa.repository.JpaRepository;

@Repository
public interface SensorRawDataRepository extends JpaRepository<SensorRawData, String> {
}
