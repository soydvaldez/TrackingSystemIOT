package io.tracksystem.device.telemetry.presentation;

public class UnauthorizedException extends RuntimeException {
    public UnauthorizedException() {
        super("Invalid API Key");
    }
}
