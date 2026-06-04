package io.tracksystem.device.telemetry.infrastructure.publishers.events;

import java.time.Instant;

public record TelemetryRegisteredEvent(
        String deviceUuid,
        Double temperature,
        Double humidity,
        Instant createdAt) {

}
