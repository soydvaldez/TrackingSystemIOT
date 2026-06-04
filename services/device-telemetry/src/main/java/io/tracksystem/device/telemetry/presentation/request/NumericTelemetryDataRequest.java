package io.tracksystem.device.telemetry.presentation.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NumericTelemetryDataRequest extends TelemetryDataRequest {

    @NotNull
    private Double value;
}