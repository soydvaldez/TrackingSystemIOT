package io.tracksystem.device.registry.application.command;

import java.time.LocalDateTime;
import java.util.UUID;

public record DeviceInfo(
        UUID deviceUuid,
        String deviceName,
        String deviceModel,
        String firmwareVersion,
        String status,
        LocalDateTime registeredAt,
        LocalDateTime lastSeenAt) {

}
