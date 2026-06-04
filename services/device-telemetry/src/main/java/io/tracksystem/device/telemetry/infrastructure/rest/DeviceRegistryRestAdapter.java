package io.tracksystem.device.telemetry.infrastructure.rest;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import io.tracksystem.device.telemetry.application.out.DeviceRegistryPort;
import io.tracksystem.device.telemetry.application.out.DeviceStatus;
import reactor.core.publisher.Mono;

@Component
public class DeviceRegistryRestAdapter implements DeviceRegistryPort {

    private final WebClient webClient;

    public DeviceRegistryRestAdapter(
            @Qualifier("deviceRegistryWebClient") WebClient webClient) {
        this.webClient = webClient;
    }

    @Override
    public Optional<DeviceStatus> getStatus(String deviceUuid) {

        Mono<DeviceStatus> deviceStatusMono = webClient.get()
                .uri("/devices/{uuid}", deviceUuid)
                .retrieve()
                .bodyToMono(DeviceStatus.class);

        return deviceStatusMono.blockOptional();
    }
}
