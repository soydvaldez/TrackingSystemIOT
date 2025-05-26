package io.tracksystem.ingest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import io.tracksystem.ingest.payload.request.TemperatureDataRequest;

@Service
@Profile("rabbit")
public class TemperatureDataService {
    @Autowired
    Producer producer;

    public TemperatureDataRequest save(TemperatureDataRequest temperatureDataRequest) {
        producer.send(temperatureDataRequest);
        return temperatureDataRequest;
    }
}
