package io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement;

import java.time.Instant;

import io.tracksystem.device.telemetry.domain.model.MeasurementType;

public abstract class TelemetryMeasurement {

    private final Instant timestamp;

    protected TelemetryMeasurement(Instant timestamp) {
        this.timestamp = timestamp;
    }

    public Instant getTimestamp() {
        return timestamp;
    }

    public abstract MeasurementType getType();
}