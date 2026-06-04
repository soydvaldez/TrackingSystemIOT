package io.tracksystem.device.telemetry.application;

import java.time.Instant;
import java.util.List;

import lombok.Builder;

@Builder
public record ProcessTelemetryCommand(
                String deviceUuid,
                Instant deviceTimestamp,
                List<TelemetryMeasurementCommand> measurements) {
}
