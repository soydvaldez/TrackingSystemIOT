package io.tracksystem.device.registry.application.command;

public record RegisterDeviceCommand(String type, String name, String firmwareVersion, String customerId,
                String hardwareId) {

}
