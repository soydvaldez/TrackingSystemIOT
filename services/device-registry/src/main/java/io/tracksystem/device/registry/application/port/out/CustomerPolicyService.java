package io.tracksystem.device.registry.application.port.out;

public interface CustomerPolicyService {
    CustomerStatus canRegisterDevice(String customerId);
}
