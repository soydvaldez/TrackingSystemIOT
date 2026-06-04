package io.tracksystem.device.telemetry.domain;

import java.time.Instant;
import java.util.List;

import io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement.TelemetryMeasurement;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TelemetryData {

    @NotBlank
    private String deviceUuid;

    @NotNull
    private Instant deviceTimestamp;

    @NotEmpty
    private List<TelemetryMeasurement> measurements;
}