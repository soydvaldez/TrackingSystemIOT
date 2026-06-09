package io.tracksystem.device.registry.application.port.out;

import io.tracksystem.device.registry.domain.model.Device;

public interface SaveDevicePort {
    Device save(Device device);
}