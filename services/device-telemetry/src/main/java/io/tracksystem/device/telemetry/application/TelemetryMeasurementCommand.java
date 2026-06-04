package io.tracksystem.device.telemetry.application;

import java.math.BigDecimal;
import lombok.Builder;

@Builder
public record TelemetryMeasurementCommand(
        String type,
        BigDecimal value) {

}
