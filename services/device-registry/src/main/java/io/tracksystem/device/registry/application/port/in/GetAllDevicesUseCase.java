package io.tracksystem.device.registry.application.port.in;

import io.tracksystem.device.registry.application.command.GetAllDevicesCommand;

public interface GetAllDevicesUseCase {
        GetAllDevicesUseCase getAll(GetAllDevicesCommand command);
}
