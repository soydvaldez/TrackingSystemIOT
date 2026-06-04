package io.tracksystem.device.telemetry.infrastructure.publishers;

import org.springframework.stereotype.Component;

import io.tracksystem.device.telemetry.domain.event.AlertRaisedEvent;
import io.tracksystem.device.telemetry.domain.port.AlertPublisherPort;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class MockAlertPublisher implements AlertPublisherPort {

    @Override
    public void publish(AlertRaisedEvent event) {
        log.warn(
                "⚠️ Alert | Device ID: {} | Message: {}",
                event.deviceId(),
                event.message());
    }

}
