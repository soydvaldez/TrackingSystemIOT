package io.tracksystem.telemetry.infrastructure;

import io.tracksystem.telemetry.application.TelemetryEventRecieved;

public interface TelemetryEventPublisher {
    void publish(TelemetryEventRecieved event);
}