package io.tracksystem.device.telemetry.domain.model;

import java.util.List;

import io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement.TelemetryMeasurement;
import lombok.Getter;

@Getter
public class DeviceTelemetry {

    private final String deviceUuid;

    private final List<TelemetryMeasurement> measurements;

    public DeviceTelemetry(
            String deviceUuid,
            List<TelemetryMeasurement> measurements) {
        this.deviceUuid = deviceUuid;
        this.measurements = List.copyOf(measurements);
    }

    public String getDeviceUuid() {
        return deviceUuid;
    }

    public List<TelemetryMeasurement> getMeasurements() {
        return measurements;
    }
}