package io.tracksystem.device.telemetry.domain.model;

import java.math.BigDecimal;
import java.time.Instant;

import io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement.TelemetryMeasurement;

public abstract class NumericMeasurement
        extends TelemetryMeasurement {

    private final BigDecimal value;

    protected NumericMeasurement(
            Instant timestamp,
            BigDecimal value) {
        super(timestamp);
        this.value = value;
    }

    public BigDecimal getValue() {
        return value;
    }
}