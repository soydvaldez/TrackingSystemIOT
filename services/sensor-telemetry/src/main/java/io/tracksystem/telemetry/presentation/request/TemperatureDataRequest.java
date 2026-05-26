package io.tracksystem.telemetry.presentation.request;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
public class TemperatureDataRequest implements Serializable {
    public String sensorId;
    public Date timestamp;
    public String metric;
    public double value;
}
