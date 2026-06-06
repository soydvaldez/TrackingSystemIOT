package io.tracksystem.device.registry.infrastructure.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.tracksystem.device.registry.application.mapper.DeviceMapper;
import io.tracksystem.device.registry.application.port.in.GetAllDevicesUseCase;
import io.tracksystem.device.registry.application.port.out.LoadDevicesPort;
import io.tracksystem.device.registry.application.service.GetAllDevicesService;
import io.tracksystem.device.registry.infrastructure.LoadDevicesPortAdapter;

@Configuration
public class RegistryBeans {

    @Bean
    public DeviceMapper deviceMapper() {
        return new DeviceMapper();
    }

    @Bean
    public LoadDevicesPort loadDevicesPort() {
        return new LoadDevicesPortAdapter();
    }

    @Bean
    public GetAllDevicesUseCase getAllDevicesUseCase(LoadDevicesPort loadDevicesPort) {
        return new GetAllDevicesService(loadDevicesPort);
    }
}
