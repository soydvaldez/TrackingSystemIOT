package io.tracksystem.device.registry.application.port.out;

import java.util.Optional;
import java.util.UUID;

import io.tracksystem.device.registry.application.command.DeviceInfo;
import io.tracksystem.device.registry.application.command.DeviceSummary;

public interface LoadDevicesPort {
    Optional<DeviceSummary> loadAll();

    Optional<DeviceInfo> loadByUuid(UUID uuid);
}
