package io.tracksystem.device.telemetry.domain.TelemetryMeasurement;

import java.time.Instant;

import io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement.TelemetryMeasurement;
import io.tracksystem.device.telemetry.domain.model.Coordinates;
import io.tracksystem.device.telemetry.domain.model.MeasurementType;

public class GpsMeasurement extends TelemetryMeasurement {

    private final Coordinates coordinates;

    public GpsMeasurement(
            Instant timestamp,
            Coordinates coordinates) {
        super(timestamp);
        this.coordinates = coordinates;
    }

    @Override
    public MeasurementType getType() {
        return MeasurementType.GPS;
    }

    public Coordinates getCoordinates() {
        return coordinates;
    }
}