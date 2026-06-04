package io.tracksystem.device.telemetry.application;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import org.springframework.stereotype.Service;

import io.tracksystem.device.telemetry.application.out.DeviceRegistryPort;
import io.tracksystem.device.telemetry.domain.model.Coordinates;
import io.tracksystem.device.telemetry.domain.EnvironmentalPolicyService;
import io.tracksystem.device.telemetry.domain.TelemetryMeasurement.GpsMeasurement;
import io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement.TelemetryMeasurement;
import io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement.TemperatureMeasurement;
import io.tracksystem.device.telemetry.domain.model.HumidityMeasurement;
import io.tracksystem.device.telemetry.domain.model.DeviceTelemetry;
import io.tracksystem.device.telemetry.infrastructure.publishers.TelemetryEventPublisher;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TelemetryIngestionUseCase {

    private final TelemetryEventPublisher publisher;
    private final DeviceRegistryPort deviceRegistryPort;
    private final EnvironmentalPolicyService policy;

    public TelemetryIngestionUseCase(TelemetryEventPublisher publisher,
            DeviceRegistryPort deviceRegistryPort,
            EnvironmentalPolicyService policy) {
        this.publisher = publisher;
        this.deviceRegistryPort = deviceRegistryPort;
        this.policy = policy;
    }

    private TelemetryMeasurement toMeasurement(TelemetryMeasurementCommand measurement) {
        Instant timestamp = Instant.now();

        if (measurement.type().equalsIgnoreCase("TEMPERATURE")) {
            return new TemperatureMeasurement(timestamp, BigDecimal.valueOf(14.5));
        }

        if (measurement.type().equalsIgnoreCase("HUMIDITY")) {
            return new HumidityMeasurement(timestamp, BigDecimal.valueOf(65.0));
        }

        if (measurement.type().equalsIgnoreCase("GPS")) {
            return new GpsMeasurement(timestamp, new Coordinates(19.432608, -99.133209));
        }

        return null;
        // return switch (request.getType()) {
        // case TEMPERATURE -> new TemperatureMeasurement(
        // request.getTimestamp(),
        // ((NumericTelemetryDataRequest) request).getValue());
        // case HUMIDITY -> new HumidityMeasurement(
        // request.getTimestamp(),
        // ((NumericTelemetryDataRequest) request).getValue());
        // case GPS -> new GpsMeasurement(
        // request.getTimestamp(),
        // new Coordinates(
        // ((GpsTelemetryDataRequest) request).getLatitude(),
        // ((GpsTelemetryDataRequest) request).getLongitude()));
        // default -> throw new IllegalArgumentException("Unknown measurement type: " +
        // request.getType());
        // };
    }

    public void process(ProcessTelemetryCommand command) {

        String deviceUuid = UUID.randomUUID().toString();

        List<TelemetryMeasurement> measurements = command.measurements().stream()
                .map(this::toMeasurement)
                .filter(Objects::nonNull)
                .toList();

        if (measurements.isEmpty()) {
            log.error("No measurements for device {}", deviceUuid);
            return;
        }

        DeviceTelemetry telemetry = new DeviceTelemetry(
                deviceUuid,
                measurements);
        policy.evaluatePolicy("policy-1", telemetry);
        publisher.publish(command);

        // 1. Verificar si el dispositivo existe
        // Optional<DeviceStatus> deviceStatus =
        // deviceRegistryPort.getStatus(deviceUuid);

        // 2. Si no existe, emitir alerta
        // if (deviceStatus.isEmpty()) {
        // publisher.publishDeviceOfflineEvent(deviceUuid);
        // }

        // Publicar evento
        // policy.evaluatePolicy("policy-1", command);

    }
}
