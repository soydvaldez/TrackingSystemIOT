package io.tracksystem.device.telemetry.domain.event;

public record AlertRaisedEvent(
        String deviceId,
        String message) {
}