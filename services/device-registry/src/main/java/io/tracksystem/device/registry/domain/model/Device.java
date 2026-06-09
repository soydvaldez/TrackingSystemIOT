package io.tracksystem.device.registry.domain.model;

import java.time.Instant;
import java.util.UUID;

import io.tracksystem.device.registry.domain.DeviceStatus;
import lombok.Getter;

@Getter
public class Device {

    private String id;
    private UUID externalId;
    private String name;
    private String type;
    private String customerId;
    private String hardwareId;
    private String firmwareVersion;
    private DeviceStatus status;
    private Instant registeredAt;
    private Instant lastSeenAt;

    public Device(String name, String type) {
        this.externalId = java.util.UUID.randomUUID();
        this.name = name;
        this.type = type;
        this.firmwareVersion = "v1.0.0";
        this.status = DeviceStatus.PENDING;
        this.registeredAt = Instant.now();
        this.lastSeenAt = Instant.now();
    }

    public void linkToCustomer(String customerId) {
        this.customerId = customerId;
    }

    public static Device registerDevice(String name, String type, String customerId, String hardwareId) {
        Device device = new Device(
                name,
                type);
        device.linkToCustomer(customerId);
        device.hardwareId = hardwareId;
        return device;
    }
}