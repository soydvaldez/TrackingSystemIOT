package io.tracksystem.device.registry.application.service;

import java.util.Optional;

import io.tracksystem.device.registry.application.command.DeviceSummary;
import io.tracksystem.device.registry.application.command.GetAllDevicesCommand;
import io.tracksystem.device.registry.application.port.in.GetAllDevicesUseCase;
import io.tracksystem.device.registry.application.port.out.LoadDevicesPort;

public class GetAllDevicesService implements GetAllDevicesUseCase {
    private final LoadDevicesPort loadDevicesPort;

    public GetAllDevicesService(LoadDevicesPort loadDevicesPort) {
        this.loadDevicesPort = loadDevicesPort;
    }

    @Override
    public GetAllDevicesUseCase getAll(GetAllDevicesCommand command) {
        Optional<DeviceSummary> devices = loadDevicesPort.loadAll();

        if (devices.isPresent()) {

        }

        return null;
    }

}
