package io.tracksystem.device.telemetry.presentation.request;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;

@Getter
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.EXISTING_PROPERTY, property = "type", visible = true)
@JsonSubTypes({
                @JsonSubTypes.Type(value = NumericTelemetryDataRequest.class, names = {
                                "temperature",
                                "humidity"
                }),
                @JsonSubTypes.Type(value = GpsTelemetryDataRequest.class, name = "gps")
})
public abstract class TelemetryDataRequest {

        @NotBlank
        protected String type;
}