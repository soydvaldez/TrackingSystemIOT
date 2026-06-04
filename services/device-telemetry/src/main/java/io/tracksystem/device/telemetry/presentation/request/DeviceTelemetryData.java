package io.tracksystem.device.telemetry.presentation.request;

import java.time.Instant;
import java.util.List;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DeviceTelemetryData {

    @NotBlank
    private String deviceUuid;

    @NotNull
    private Instant deviceTimestamp;

    @NotEmpty
    private List<TelemetryDataRequest> measurements;
}
