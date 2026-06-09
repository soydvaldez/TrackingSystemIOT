package io.tracksystem.device.registry.application.service;

public class CustomerNotActiveException extends RuntimeException {
    public CustomerNotActiveException(String message) {
        super(message);
    }

}
