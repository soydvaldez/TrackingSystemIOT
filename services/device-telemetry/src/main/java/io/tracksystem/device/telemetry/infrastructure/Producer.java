package io.tracksystem.device.telemetry.infrastructure;

import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import io.tracksystem.device.telemetry.application.ProcessTelemetryCommand;
import lombok.extern.slf4j.Slf4j;

@Slf4j
// @Component
// @EnableRabbit
public class Producer {
    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Autowired
    private Queue queue;

    public void send(ProcessTelemetryCommand command) {
        log.info("Event Has been Produced {}", command.toString());
        rabbitTemplate.convertAndSend(queue.getName(), command);
    }
}
