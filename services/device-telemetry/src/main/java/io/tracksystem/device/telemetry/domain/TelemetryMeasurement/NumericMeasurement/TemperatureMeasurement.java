package io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement;

import java.math.BigDecimal;
import java.time.Instant;

import io.tracksystem.device.telemetry.domain.model.MeasurementType;
import io.tracksystem.device.telemetry.domain.model.NumericMeasurement;

public class TemperatureMeasurement extends NumericMeasurement {

    public TemperatureMeasurement(Instant timestamp, BigDecimal value) {
        super(timestamp, value);
    }

    @Override
    public MeasurementType getType() {
        return MeasurementType.TEMPERATURE;
    }
}
