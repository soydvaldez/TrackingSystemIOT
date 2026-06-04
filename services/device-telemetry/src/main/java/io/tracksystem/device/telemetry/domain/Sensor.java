package io.tracksystem.device.telemetry.domain;

public class Sensor {
    private SensorStatus status;

    enum SensorStatus {
        ACTIVE,
        DISABLED,
        MAINTENANCE
    }

    public boolean isDisabled() {
        return this.status == SensorStatus.DISABLED;
    }
}
