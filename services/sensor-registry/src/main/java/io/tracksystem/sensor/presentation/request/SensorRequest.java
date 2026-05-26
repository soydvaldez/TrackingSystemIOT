package io.tracksystem.sensor.presentation.request;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class SensorRequest implements Serializable {
    private String sensorId;
    private String sensorName;
    private String location;
    private LocalDateTime installationDate;
    private String status;

    public SensorRequest() {
    }

    public SensorRequest(String sensorName, String location, LocalDateTime installationDate, String status) {
        this.sensorName = sensorName;
        this.location = location;
        this.installationDate = installationDate;
        this.status = status;
    }

    public SensorRequest(String sensorId, String sensorName, String location, LocalDateTime installationDate,
            String status) {
        this.sensorId = sensorId;
        this.sensorName = sensorName;
        this.location = location;
        this.installationDate = installationDate;
        this.status = status;
    }

}
