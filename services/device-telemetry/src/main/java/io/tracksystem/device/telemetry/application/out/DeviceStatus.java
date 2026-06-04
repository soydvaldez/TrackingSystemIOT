package io.tracksystem.device.telemetry.application.out;

public record DeviceStatus(
                String deviceUuid,
                boolean active,
                String state) {
}