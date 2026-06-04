package io.tracksystem.device.telemetry.presentation.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class GpsTelemetryDataRequest extends TelemetryDataRequest {

    @NotNull
    private GpsCoordinates value;
}