package io.tracksystem.telemetry.application;

import java.util.Date;

public record TelemetryEventRecieved(
                String deviceId,
                Date timestamp,
                String metric,
                double value) {

}
