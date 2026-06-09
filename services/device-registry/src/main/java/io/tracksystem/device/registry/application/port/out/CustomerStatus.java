package io.tracksystem.device.registry.application.port.out;

public record CustomerStatus(
        boolean exists,
        boolean active,
        boolean deviceLinkToCustomer) {

    public boolean canRegisterDevice() {
        return exists && active && deviceLinkToCustomer;
    }
}