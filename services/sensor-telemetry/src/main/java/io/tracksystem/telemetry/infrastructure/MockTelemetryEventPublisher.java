package io.tracksystem.telemetry.infrastructure;

import org.springframework.stereotype.Service;

import io.tracksystem.telemetry.application.TelemetryEventRecieved;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MockTelemetryEventPublisher implements TelemetryEventPublisher {

    @Override
    public void publish(TelemetryEventRecieved event) {
        log.info("publish() -> " + event);
    }
}