package io.tracksystem.telemetry.infrastructure;

import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import io.tracksystem.telemetry.presentation.request.TemperatureDataRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
// @Component
// @EnableRabbit
public class Producer {
    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Autowired
    private Queue queue;

    public void send(TemperatureDataRequest temperatureData) {
        log.info("Event Has been Produced {}", temperatureData.toString());
        rabbitTemplate.convertAndSend(queue.getName(), temperatureData);
    }
}
