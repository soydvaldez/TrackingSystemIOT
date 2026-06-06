package io.tracksystem.device.registry.presentation;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.tracksystem.device.registry.application.command.GetAllDevicesCommand;
import io.tracksystem.device.registry.application.port.in.GetAllDevicesUseCase;
import lombok.Getter;

@Getter
class Device {
    private String id;
    private String name;
    private String type;
    private String status;

    public Device(String id) {
        this.id = id;
    }

}

@RestController
@RequestMapping(path = "/devices/registry")
public class DeviceRegistryController {

    private final GetAllDevicesUseCase getAllDevicesUseCase;

    public DeviceRegistryController(GetAllDevicesUseCase getAllDevicesUseCase) {
        this.getAllDevicesUseCase = getAllDevicesUseCase;
    }

    @GetMapping
    public ResponseEntity<?> getAll() {
        return ResponseEntity.ok(getAllDevicesUseCase.getAll(new GetAllDevicesCommand()));
    }

    @GetMapping(path = "/{uuid}")
    public ResponseEntity<Device> getDevice(@PathVariable String uuid) {
        return ResponseEntity.ok(new Device(uuid));
    }

    @PostMapping
    public ResponseEntity<Device> saveDevice() {
        return ResponseEntity.ok(new Device("1234567890"));
    }
}
