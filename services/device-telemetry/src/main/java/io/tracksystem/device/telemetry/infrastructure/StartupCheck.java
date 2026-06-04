package io.tracksystem.device.telemetry.infrastructure;

import org.springframework.stereotype.Component;

@Component
public class StartupCheck {

    public StartupCheck(
            org.springframework.context.ApplicationContext context) {

        System.out.println(
                context.getBeansOfType(
                        org.springframework.kafka.core.KafkaTemplate.class));
    }
}