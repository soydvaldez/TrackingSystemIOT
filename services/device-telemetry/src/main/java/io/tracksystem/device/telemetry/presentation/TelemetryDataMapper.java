package io.tracksystem.device.telemetry.presentation;

import java.math.BigDecimal;

import io.tracksystem.device.telemetry.application.TelemetryMeasurementCommand;
import io.tracksystem.device.telemetry.presentation.request.GpsTelemetryDataRequest;
import io.tracksystem.device.telemetry.presentation.request.NumericTelemetryDataRequest;
import io.tracksystem.device.telemetry.presentation.request.TelemetryDataRequest;

public class TelemetryDataMapper {

    public static TelemetryMeasurementCommand toCommand(TelemetryDataRequest request) {
        if (request.getType().equalsIgnoreCase("TEMPERATURE")) {
            NumericTelemetryDataRequest numericTelemetryDataRequest = (NumericTelemetryDataRequest) request;
            return TelemetryMeasurementCommand.builder()
                    .type(request.getType())
                    .value(BigDecimal.valueOf(numericTelemetryDataRequest.getValue()))
                    .build();
        }

        if (request.getType().equalsIgnoreCase("HUMIDITY")) {
            NumericTelemetryDataRequest numericTelemetryDataRequest = (NumericTelemetryDataRequest) request;
            return TelemetryMeasurementCommand.builder()
                    .type(request.getType())
                    .value(BigDecimal.valueOf(numericTelemetryDataRequest.getValue()))
                    .build();
        }

        if (request.getType().equalsIgnoreCase("GPS")) {
            GpsTelemetryDataRequest gpsData = (GpsTelemetryDataRequest) request;
            return TelemetryMeasurementCommand.builder()
                    .type(request.getType())
                    .value(BigDecimal.valueOf(gpsData.getValue().getLatitude()))
                    .value(BigDecimal.valueOf(gpsData.getValue().getLongitude()))
                    .build();
        }

        System.out.println("Telemetry type not supported: " + request.getType());

        return null;
    }

}
