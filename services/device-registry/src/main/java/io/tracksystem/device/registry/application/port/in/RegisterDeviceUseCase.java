package io.tracksystem.device.registry.application.port.in;

import io.tracksystem.device.registry.application.command.RegisterDeviceCommand;

public interface RegisterDeviceUseCase {

    void run(RegisterDeviceCommand command);

}
