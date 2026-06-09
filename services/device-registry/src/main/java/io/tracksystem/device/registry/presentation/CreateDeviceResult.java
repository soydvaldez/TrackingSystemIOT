package io.tracksystem.device.registry.presentation;

import java.util.UUID;

import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class CreateDeviceResult {

    private String id;
    private String name;
    private String type;
    private String firmwareVersion;
    private String status;
    private String registeredAt;
    private String lastSeenAt;

    public CreateDeviceResult(String name, String type, String firmwareVersion) {
        this.id = UUID.randomUUID().toString();
        this.name = name;
        this.type = type;
        this.firmwareVersion = firmwareVersion;
        this.status = "WAITING_FOR_ACTIVATION";
        this.registeredAt = LocalDateTime.now().toString();
        this.lastSeenAt = LocalDateTime.now().toString();
    }

}
