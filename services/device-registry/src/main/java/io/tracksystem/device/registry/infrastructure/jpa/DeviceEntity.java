package io.tracksystem.device.registry.infrastructure.jpa;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "devices")
public class DeviceEntity {

    @Id
    @Column(name = "device_uuid", nullable = false)
    private UUID deviceUuid;

    @Column(name = "customer_uuid", nullable = false)
    private UUID customerUuid;

    @Column(name = "device_name", nullable = false, length = 100)
    private String deviceName;

    @Column(name = "device_model", nullable = false, length = 100)
    private String deviceModel;

    @Column(name = "firmware_version", nullable = false, length = 30)
    private String firmwareVersion;

    @Column(name = "status", nullable = false, length = 20)
    private String status;

    @Column(name = "registered_at", nullable = false)
    private LocalDateTime registeredAt;

    @Column(name = "last_seen_at")
    private LocalDateTime lastSeenAt;

    protected DeviceEntity() {
        // JPA
    }

    public DeviceEntity(
            UUID deviceUuid,
            UUID customerUuid,
            String deviceName,
            String deviceModel,
            String firmwareVersion,
            String status,
            LocalDateTime registeredAt,
            LocalDateTime lastSeenAt) {

        this.deviceUuid = deviceUuid;
        this.customerUuid = customerUuid;
        this.deviceName = deviceName;
        this.deviceModel = deviceModel;
        this.firmwareVersion = firmwareVersion;
        this.status = status;
        this.registeredAt = registeredAt;
        this.lastSeenAt = lastSeenAt;
    }

    public UUID getDeviceUuid() {
        return deviceUuid;
    }

    public UUID getCustomerUuid() {
        return customerUuid;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public String getDeviceModel() {
        return deviceModel;
    }

    public String getFirmwareVersion() {
        return firmwareVersion;
    }

    public String getStatus() {
        return status;
    }

    public LocalDateTime getRegisteredAt() {
        return registeredAt;
    }

    public LocalDateTime getLastSeenAt() {
        return lastSeenAt;
    }
}