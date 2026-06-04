package io.tracksystem.device.telemetry.presentation.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class GpsCoordinates {

    @NotNull
    private Double latitude;

    @NotNull
    private Double longitude;
}