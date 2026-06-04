package io.tracksystem.device.telemetry.infrastructure;

import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LombokLogAdapter implements LogPort {

    @Override
    public void info(String message) {
        log.info("ℹ️ {} ", message);
    }

    @Override
    public void debug(String message) {
        log.debug("⚙️ {} ", message);
    }

    @Override
    public void warn(String message) {
        log.warn("⚠️ {} ", message);
    }

    @Override
    public void error(String message) {
        log.error("❌ {} ", message);
    }

}
