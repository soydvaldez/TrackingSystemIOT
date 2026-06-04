package io.tracksystem.device.telemetry.domain.model;

import java.math.BigDecimal;
import java.time.Instant;

public class HumidityMeasurement extends NumericMeasurement {

    public HumidityMeasurement(Instant timestamp, BigDecimal value) {
        super(timestamp, value);
    }

    @Override
    public MeasurementType getType() {
        return MeasurementType.HUMIDITY;
    }
}