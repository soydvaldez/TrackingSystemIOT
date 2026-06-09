package io.tracksystem.device.registry.presentation;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;

@Getter
public class CreateDeviceRequest {

        @NotBlank(message = "Name is required")
        @Size(min = 2, max = 100)
        String name;

        @NotBlank(message = "Type is required")
        @Size(min = 2, max = 50)
        String type;

        @NotBlank(message = "Firmware version is required")
        @Size(max = 30)
        String firmwareVersion;

        @NotBlank(message = "Customer ID is required")
        String customerId;

        @NotNull(message = "Device model is required")
        DeviceModel model;

        @Size(max = 100)
        String hardwareId;
}