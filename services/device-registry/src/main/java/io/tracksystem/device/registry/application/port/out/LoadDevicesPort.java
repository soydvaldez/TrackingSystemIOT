package io.tracksystem.device.registry.application.port.out;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import io.tracksystem.device.registry.application.command.DeviceInfo;
import io.tracksystem.device.registry.application.command.GetDeviceQuery;

public interface LoadDevicesPort {
    List<GetDeviceQuery> loadAll();

    Optional<DeviceInfo> loadByUuid(UUID uuid);
}
