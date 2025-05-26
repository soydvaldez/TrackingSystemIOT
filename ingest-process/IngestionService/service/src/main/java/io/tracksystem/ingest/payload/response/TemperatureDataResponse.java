package io.tracksystem.ingest.payload.response;

import java.io.Serializable;

import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
public class TemperatureDataResponse implements Serializable {
    public String sensorId;
    public boolean recieved;
    public double temperature;
    public String message;

    public TemperatureDataResponse() {
    }

    public TemperatureDataResponse(String message, double temperature) {
        this.message = message;
        this.temperature = temperature;
    }

    public TemperatureDataResponse(String sensorId, boolean recieved,
            double temperature, String message) {
        this.sensorId = sensorId;
        this.recieved = recieved;
        this.temperature = temperature;
        this.message = message;
    }
}
