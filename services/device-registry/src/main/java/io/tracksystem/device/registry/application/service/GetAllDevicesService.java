package io.tracksystem.device.registry.application.service;

import java.util.List;

import io.tracksystem.device.registry.application.command.GetAllDevicesCommand;
import io.tracksystem.device.registry.application.command.GetDeviceQuery;
import io.tracksystem.device.registry.application.port.in.GetAllDevicesUseCase;
import io.tracksystem.device.registry.application.port.out.LoadDevicesPort;

public class GetAllDevicesService implements GetAllDevicesUseCase {
    private final LoadDevicesPort loadDevicesPort;

    public GetAllDevicesService(LoadDevicesPort loadDevicesPort) {
        this.loadDevicesPort = loadDevicesPort;
    }

    @Override
    public List<GetDeviceQuery> getAll(GetAllDevicesCommand command) {
        List<GetDeviceQuery> devices = loadDevicesPort.loadAll();

        return devices;
    }

}
