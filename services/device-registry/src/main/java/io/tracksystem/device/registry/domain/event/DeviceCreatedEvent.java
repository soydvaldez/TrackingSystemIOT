package io.tracksystem.device.registry.domain.event;

import java.time.Instant;

import io.tracksystem.device.registry.domain.model.Device;

public record DeviceCreatedEvent(
        String uuid,
        String name,
        String type,
        String firmwareVersion,
        String customerId,
        Instant createdAt,
        Instant updatedAt) implements DomainEvent {

    public static DeviceCreatedEvent from(Device device) {
        return new DeviceCreatedEvent(
                device.getId(),
                device.getName(),
                device.getType(),
                device.getFirmwareVersion(),
                device.getCustomerId(),
                Instant.now(),
                Instant.now());
    }

}
