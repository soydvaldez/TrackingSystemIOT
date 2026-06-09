package io.tracksystem.device.registry.infrastructure.out.jpa;

import jakarta.persistence.*;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "devices")
public class JpaDeviceEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(name = "external_id", nullable = false)
    private UUID externalId;

    @Column(name = "customer_id", nullable = false)
    private UUID customerId;

    @Column(name = "device_name", nullable = false, length = 100)
    private String deviceName;

    @Column(name = "device_model", nullable = false, length = 100)
    private String deviceModel;

    @Column(name = "firmware_version", nullable = false, length = 30)
    private String firmwareVersion;

    @Column(name = "status", nullable = false, length = 20)
    private String status;

    @Column(name = "registered_at", nullable = false)
    private Instant registeredAt;

    @Column(name = "last_seen_at")
    private Instant lastSeenAt;

    protected JpaDeviceEntity() {
        this.externalId = UUID.randomUUID();

    }

    public JpaDeviceEntity(
            Long id,
            UUID externalId,
            UUID customerId,
            String deviceName,
            String deviceModel,
            String firmwareVersion,
            String status,
            Instant registeredAt,
            Instant lastSeenAt) {
        this.id = id;
        this.externalId = externalId;
        this.customerId = customerId;
        this.deviceName = deviceName;
        this.deviceModel = deviceModel;
        this.firmwareVersion = firmwareVersion;
        this.status = status;
        this.registeredAt = registeredAt;
        this.lastSeenAt = lastSeenAt;
    }

    public JpaDeviceEntity(
            UUID externalId,
            UUID customerId,
            String deviceName,
            String deviceModel,
            String firmwareVersion,
            String status,
            Instant registeredAt,
            Instant lastSeenAt) {

        this.externalId = externalId;
        this.customerId = customerId;
        this.deviceName = deviceName;
        this.deviceModel = deviceModel;
        this.firmwareVersion = firmwareVersion;
        this.status = status;
        this.registeredAt = registeredAt;
        this.lastSeenAt = lastSeenAt;
    }

    public UUID getExternalId() {
        return externalId;
    }

    public UUID getCustomerId() {
        return customerId;
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

    public Instant getRegisteredAt() {
        return registeredAt;
    }

    public Instant getLastSeenAt() {
        return lastSeenAt;
    }
}