package io.tracksystem.device.registry.application.port.in;

import java.util.List;

import io.tracksystem.device.registry.application.command.GetAllDevicesCommand;
import io.tracksystem.device.registry.application.command.GetDeviceQuery;

public interface GetAllDevicesUseCase {
        List<GetDeviceQuery> getAll(GetAllDevicesCommand command);
}
