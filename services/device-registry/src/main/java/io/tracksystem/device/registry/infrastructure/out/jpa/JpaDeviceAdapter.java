package io.tracksystem.device.registry.infrastructure.out.jpa;

import java.util.UUID;

import org.springframework.stereotype.Component;

import io.tracksystem.device.registry.application.port.out.SaveDevicePort;
import io.tracksystem.device.registry.domain.model.Device;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class JpaDeviceAdapter implements SaveDevicePort {
    private final SpringDataJpaDeviceRepository springDataJpaDeviceRepository;

    public JpaDeviceAdapter(SpringDataJpaDeviceRepository springDataJpaDeviceRepository) {
        this.springDataJpaDeviceRepository = springDataJpaDeviceRepository;
    }

    @Override
    public Device save(Device device) {
        log.info("Guardando dispositivo {}", device);

        JpaDeviceEntity deviceEntity = new JpaDeviceEntity(
                device.getExternalId(),
                UUID.fromString(device.getCustomerId()),
                device.getName(),
                device.getType(),
                device.getFirmwareVersion(),
                device.getStatus().toString(),
                device.getRegisteredAt(),
                device.getLastSeenAt());

        springDataJpaDeviceRepository.save(deviceEntity);
        return device;
    }

}
