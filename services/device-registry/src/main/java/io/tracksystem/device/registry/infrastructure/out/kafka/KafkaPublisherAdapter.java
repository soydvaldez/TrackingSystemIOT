package io.tracksystem.device.registry.infrastructure.out.kafka;

import org.springframework.stereotype.Component;

import io.tracksystem.device.registry.application.port.out.PublisherEventPort;
import io.tracksystem.device.registry.domain.event.DomainEvent;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class KafkaPublisherAdapter implements PublisherEventPort {

    @Override
    public void publish(String topic, DomainEvent message) {
        log.info("Publicando mensaje en el topic :{} message: {}", topic, message);
    }

}
