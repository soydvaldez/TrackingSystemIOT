package io.tracksystem.device.telemetry.infrastructure;

public interface LogPort {
    void info(String message);

    void debug(String message);

    void warn(String message);

    void error(String message);
}
