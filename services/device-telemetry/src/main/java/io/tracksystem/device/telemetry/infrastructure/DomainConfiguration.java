package io.tracksystem.device.telemetry.infrastructure;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.tracksystem.device.telemetry.domain.EnvironmentalPolicyService;
import io.tracksystem.device.telemetry.domain.port.AlertPublisherPort;

@Configuration
public class DomainConfiguration {

    @Bean
    EnvironmentalPolicyService environmentalPolicyService(AlertPublisherPort alertPublisherPort) {
        return new EnvironmentalPolicyService(alertPublisherPort);
    }
}