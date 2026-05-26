package io.tracksystem.telemetry.application;

import org.springframework.stereotype.Service;

import io.tracksystem.telemetry.infrastructure.TelemetryEventPublisher;

@Service
public class TelemetryIngestionService {

    private final TelemetryEventPublisher publisher;

    public TelemetryIngestionService(TelemetryEventPublisher publisher) {
        this.publisher = publisher;
    }

    public void process(TelemetryEventRecieved event) {
        publisher.publish(event);
    }
}
