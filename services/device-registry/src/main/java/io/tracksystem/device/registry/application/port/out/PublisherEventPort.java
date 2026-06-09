package io.tracksystem.device.registry.application.port.out;

import io.tracksystem.device.registry.domain.event.DomainEvent;

public interface PublisherEventPort {
    void publish(String topic, DomainEvent message);
}
