package io.tracksystem.device.telemetry.presentation;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.tracksystem.device.telemetry.application.ProcessTelemetryCommand;
import io.tracksystem.device.telemetry.application.TelemetryIngestionUseCase;
import io.tracksystem.device.telemetry.application.TelemetryMeasurementCommand;
import io.tracksystem.device.telemetry.presentation.request.DeviceTelemetryData;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

@Slf4j
@RestController
@RequestMapping("/api/v1/devices/telemetry")
public class DeviceIngestController {

    private final TelemetryIngestionUseCase telemetryIngestionUseCase;

    public DeviceIngestController(TelemetryIngestionUseCase telemetryIngestionUseCase) {
        this.telemetryIngestionUseCase = telemetryIngestionUseCase;
    }

    @PostMapping
    public ResponseEntity<@Valid DeviceTelemetryData> registerTelemetryData(
            @RequestHeader("X-API-KEY") String apiKey,
            @Valid @RequestBody DeviceTelemetryData request) {
        log.info("Recieved Data: {}", request.getDeviceTimestamp());

        if (apiKey == null || !"super-secret-key".equals(apiKey)) {
            throw new UnauthorizedException();
        }

        List<TelemetryMeasurementCommand> commandMeasurements = request.getMeasurements().stream()
                .map(TelemetryDataMapper::toCommand)
                .toList();

        ProcessTelemetryCommand telemetryEvent = ProcessTelemetryCommand.builder()
                .deviceUuid(request.getDeviceUuid())
                .deviceTimestamp(request.getDeviceTimestamp())
                .measurements(commandMeasurements)
                .build();

        telemetryIngestionUseCase.process(telemetryEvent);

        // return ResponseEntity.ok().build();
        return ResponseEntity.ok(request);
    }
}
