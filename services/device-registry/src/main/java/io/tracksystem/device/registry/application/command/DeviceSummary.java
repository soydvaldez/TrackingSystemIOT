package io.tracksystem.device.registry.application.command;

import java.util.List;

public record DeviceSummary(List<DeviceInfo> deviceInfo) {
}
