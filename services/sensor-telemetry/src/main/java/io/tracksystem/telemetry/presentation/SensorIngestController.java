package io.tracksystem.telemetry.presentation;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.tracksystem.telemetry.application.TelemetryEventRecieved;
import io.tracksystem.telemetry.application.TelemetryIngestionService;
import io.tracksystem.telemetry.presentation.request.TemperatureDataRequest;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Slf4j
@RestController
@RequestMapping("/api/v1/telemetry")
public class SensorIngestController {

    private final TelemetryIngestionService ingestionService;

    public SensorIngestController(TelemetryIngestionService ingestionService) {
        this.ingestionService = ingestionService;
    }

    @PostMapping
    public ResponseEntity<Void> registerTelemetryData(
            @RequestBody TemperatureDataRequest temperatureDataRequest) {
        log.info("Recieved Data: {}", temperatureDataRequest);

        TelemetryEventRecieved telemetryEvent = new TelemetryEventRecieved(
                temperatureDataRequest.getSensorId(),
                temperatureDataRequest.getTimestamp(),
                "temperature",
                temperatureDataRequest.getValue());

        ingestionService.process(telemetryEvent);

        return ResponseEntity.ok().build();
    }
}
