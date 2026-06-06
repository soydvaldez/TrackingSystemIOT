package io.tracksystem.device.registry.infrastructure;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Component;

import io.tracksystem.device.registry.application.command.DeviceInfo;
import io.tracksystem.device.registry.application.command.DeviceSummary;
import io.tracksystem.device.registry.application.port.out.LoadDevicesPort;

@Component
public class LoadDevicesPortAdapter implements LoadDevicesPort {

    public LoadDevicesPortAdapter() {
    }

    @Override
    public Optional<DeviceSummary> loadAll() {
        List<DeviceInfo> list = new ArrayList<>();
        // list.add(new DeviceSummary());
        return Optional.of(new DeviceSummary(list));
    }

    @Override
    public Optional<DeviceInfo> loadByUuid(UUID uuid) {
        return Optional.of(null);
    }

}
