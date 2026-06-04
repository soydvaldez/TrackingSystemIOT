package io.tracksystem.device.telemetry.infrastructure.publishers;

import org.springframework.stereotype.Component;

import io.tracksystem.device.telemetry.application.ProcessTelemetryCommand;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class MockTelemetryEventPublisher implements TelemetryEventPublisher {

    @Override
    public void publish(ProcessTelemetryCommand command) {
        log.info("publish() -> " + command);
    }
}