package io.tracksystem.device.telemetry.infrastructure.rest;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {
    @Bean
    public WebClient deviceRegistryWebClient() {

        return WebClient.builder()
                .baseUrl("http://localhost:8020")
                .defaultHeader("apiKey", "123456")
                .build();
    }
}
