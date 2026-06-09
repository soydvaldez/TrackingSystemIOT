package io.tracksystem.device.registry.infrastructure;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Component;

import io.tracksystem.device.registry.application.command.DeviceInfo;
import io.tracksystem.device.registry.application.command.GetDeviceQuery;
import io.tracksystem.device.registry.application.port.out.LoadDevicesPort;
import io.tracksystem.device.registry.domain.DeviceStatus;

@Component
public class LoadDevicesPortAdapter implements LoadDevicesPort {

    public LoadDevicesPortAdapter() {
    }

    @Override
    public List<GetDeviceQuery> loadAll() {

        List<GetDeviceQuery> devices = List.of(
                new GetDeviceQuery("aad9536d-4f8f-438e-a1b5-4341d9d0f831", DeviceStatus.ONLINE.toString()),
                new GetDeviceQuery("aa3b4b1b-7de4-4e56-ad11-8a7661a0ddf3", DeviceStatus.OFFLINE.toString()),
                new GetDeviceQuery("a885a227-bb35-40ca-b6cf-242c13516700", DeviceStatus.ONLINE.toString()),
                new GetDeviceQuery("6276b2d9-e0b2-4281-825c-4d36aea7ca97", DeviceStatus.ONLINE.toString()));

        return devices;
    }

    @Override
    public Optional<DeviceInfo> loadByUuid(UUID uuid) {
        return Optional.of(null);
    }

}
