package io.tracksystem.device.telemetry.domain;

import io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement.TelemetryMeasurement;
import io.tracksystem.device.telemetry.domain.TelemetryMeasurement.NumericMeasurement.TemperatureMeasurement;
import io.tracksystem.device.telemetry.domain.event.AlertRaisedEvent;
import io.tracksystem.device.telemetry.domain.model.DeviceTelemetry;
import io.tracksystem.device.telemetry.domain.model.NumericMeasurement;
import io.tracksystem.device.telemetry.domain.port.AlertPublisherPort;

public class EnvironmentalPolicyService {
    private final AlertPublisherPort alertPublisherPort;

    // private final EnvironmentalPolicyRepository environmentalPolicyRepository;

    public EnvironmentalPolicyService(AlertPublisherPort alertPublisherPort) {
        this.alertPublisherPort = alertPublisherPort;
    }

    public void evaluatePolicy(String policyId, DeviceTelemetry data) {
        // data.getDeviceUuid());

        double maxTemp = 35;
        double minTemp = 15;

        double maxHum = 75;
        double minHum = 50;

        for (TelemetryMeasurement measurement : data.getMeasurements()) {

            if (measurement instanceof TemperatureMeasurement) {
                NumericMeasurement temperatureMeasurement = (NumericMeasurement) measurement;
                if (temperatureMeasurement.getValue().doubleValue() < minTemp) {
                    raiseViolation(data, "Temperature too low " + temperatureMeasurement.getValue());
                }

                if (temperatureMeasurement.getValue().doubleValue() > maxTemp) {
                    raiseViolation(data, "Temperature too high " + temperatureMeasurement.getValue());
                }

            }
        }

        // if(measurement.getType().equals("humidity"))

        // {
        // if (measurement.getValue() > maxHum) {
        // raiseViolation(command, "Humidity too high " + measurement.getValue());
        // }
        // if (measurement.getValue() < minHum) {
        // raiseViolation(command, "Humidity too low " + measurement.getValue());
        // }
        // }
        // }

    }

    private void raiseViolation(
            DeviceTelemetry data,
            String message) {
        alertPublisherPort.publish(
                new AlertRaisedEvent(
                        data.getDeviceUuid(),
                        message));
    }
}
