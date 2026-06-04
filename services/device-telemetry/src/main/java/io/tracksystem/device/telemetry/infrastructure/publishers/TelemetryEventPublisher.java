package io.tracksystem.device.telemetry.infrastructure.publishers;

import io.tracksystem.device.telemetry.application.ProcessTelemetryCommand;

public interface TelemetryEventPublisher {
    void publish(ProcessTelemetryCommand command);
}