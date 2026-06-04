package io.tracksystem.device.telemetry.infrastructure.publishers;

import java.time.Instant;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Component;

import io.tracksystem.device.telemetry.application.ProcessTelemetryCommand;
import io.tracksystem.device.telemetry.infrastructure.publishers.events.TelemetryRegisteredEvent;
import tools.jackson.databind.ObjectMapper;

// @Component
public class KafkaTelemetryEventPublisher implements TelemetryEventPublisher {
    private final ObjectMapper mapper;
    @Value("${telemetry.topic.sensor-data}")
    private String topic;

    private final KafkaTemplate<String, Object> kafkaTemplate;

    public KafkaTelemetryEventPublisher(
            KafkaTemplate<String, Object> kafkaTemplate,
            ObjectMapper mapper) {
        this.kafkaTemplate = kafkaTemplate;
        this.mapper = mapper;
    }

    @Override
    public void publish(ProcessTelemetryCommand command) {

        var event = new TelemetryRegisteredEvent(
                command.deviceUuid(),
                20.0,
                60.0,
                Instant.now());
        try {
            String payload = mapper.writeValueAsString(event);

            kafkaTemplate.send(
                    topic,
                    command.deviceUuid(),
                    payload);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
