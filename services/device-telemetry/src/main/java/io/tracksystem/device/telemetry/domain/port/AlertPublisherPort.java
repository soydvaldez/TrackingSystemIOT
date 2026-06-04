package io.tracksystem.device.telemetry.domain.port;

import io.tracksystem.device.telemetry.domain.event.AlertRaisedEvent;

public interface AlertPublisherPort {
    void publish(AlertRaisedEvent alert);
}
