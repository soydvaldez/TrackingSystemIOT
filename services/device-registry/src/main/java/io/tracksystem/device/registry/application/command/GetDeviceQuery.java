package io.tracksystem.device.registry.application.command;

public record GetDeviceQuery(String uuid, String status) {
}