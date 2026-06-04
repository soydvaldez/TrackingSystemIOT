package io.tracksystem.device.telemetry.application.out;

import java.util.Optional;

public interface DeviceRegistryPort {
    Optional<DeviceStatus> getStatus(String deviceUuid);
}
