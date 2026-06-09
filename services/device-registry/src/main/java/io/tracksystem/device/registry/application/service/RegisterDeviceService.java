package io.tracksystem.device.registry.application.service;

import io.tracksystem.device.registry.application.command.RegisterDeviceCommand;
import io.tracksystem.device.registry.application.port.in.RegisterDeviceUseCase;
import io.tracksystem.device.registry.application.port.out.CustomerPolicyService;
import io.tracksystem.device.registry.application.port.out.CustomerStatus;
import io.tracksystem.device.registry.application.port.out.PublisherEventPort;
import io.tracksystem.device.registry.application.port.out.SaveDevicePort;

import org.springframework.stereotype.Service;

import io.tracksystem.device.registry.domain.event.DeviceCreatedEvent;
import io.tracksystem.device.registry.domain.model.Device;

@Service
public class RegisterDeviceService implements RegisterDeviceUseCase {

    // Capacidades tecnicas que necesita el servicio para realizar su trabajo
    private final SaveDevicePort saveDevicePort;
    private final CustomerPolicyService customerPolicyService;
    private final PublisherEventPort publisherEventPort;

    public RegisterDeviceService(SaveDevicePort saveDevicePort, CustomerPolicyService customerPolicyService,
            PublisherEventPort publisherEventPort) {
        this.saveDevicePort = saveDevicePort;
        this.customerPolicyService = customerPolicyService;
        this.publisherEventPort = publisherEventPort;
    }

    @Override
    public void run(RegisterDeviceCommand command) {
        CustomerStatus customerStatus = customerPolicyService.canRegisterDevice(command.customerId());

        if (!customerStatus.canRegisterDevice()) {
            throw new CustomerNotActiveException("Device Cannot Link to Customer");
        }

        Device device = Device.registerDevice(command.name(), command.type(), command.customerId(),
                command.hardwareId());
        DeviceCreatedEvent event = DeviceCreatedEvent.from(device);

        saveDevicePort.save(device);
        publisherEventPort.publish("device.created", event);
    }

}
