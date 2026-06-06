package io.tracksystem.device.registry.application.mapper;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Component;

import io.tracksystem.device.registry.application.command.DeviceInfo;
import io.tracksystem.device.registry.application.command.DeviceSummary;

@Component
public class DeviceMapper {
    public DeviceInfo toDeviceInfo(UUID deviceUuid,
            String deviceName,
            String deviceModel,
            String firmwareVersion,
            String status,
            LocalDateTime registeredAt,
            LocalDateTime lastSeenAt) {
        return new DeviceInfo(
                deviceUuid,
                deviceName,
                deviceModel,
                firmwareVersion,
                status,
                registeredAt,
                lastSeenAt);
    }

    public DeviceSummary toDeviceSummary(List<DeviceInfo> devices) {
        return new DeviceSummary(devices);
    }
}
