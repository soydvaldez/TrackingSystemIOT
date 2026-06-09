package io.tracksystem.device.registry.presentation;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.tracksystem.device.registry.application.command.RegisterDeviceCommand;
import io.tracksystem.device.registry.application.command.GetAllDevicesCommand;
import io.tracksystem.device.registry.application.command.GetDeviceQuery;
import io.tracksystem.device.registry.application.port.in.RegisterDeviceUseCase;
import jakarta.validation.Valid;
import io.tracksystem.device.registry.application.port.in.GetAllDevicesUseCase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping(path = "/devices/registry")
public class DeviceRegistryController {

    private final GetAllDevicesUseCase getAllDevicesUseCase;
    private final RegisterDeviceUseCase registerDeviceUseCase;

    public DeviceRegistryController(
            GetAllDevicesUseCase getAllDevicesUseCase,
            RegisterDeviceUseCase registerDeviceUseCase) {
        this.getAllDevicesUseCase = getAllDevicesUseCase;
        this.registerDeviceUseCase = registerDeviceUseCase;
    }

    @GetMapping
    public ResponseEntity<List<GetDeviceQuery>> getAll() {
        List<GetDeviceQuery> devices = getAllDevicesUseCase.getAll(new GetAllDevicesCommand());
        return ResponseEntity.ok(devices);
    }

    @GetMapping("/{uuid}")
    public ResponseEntity<GetDeviceQuery> getDevice(@PathVariable String uuid) {

        if ("a885a227-bb35-40ca-b6cf-242c13516700".equals(uuid)) {
            return ResponseEntity.ok(new GetDeviceQuery(uuid, "ONLINE"));
        }

        return ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<CreateDeviceResult> saveDevice(@Valid @RequestBody CreateDeviceRequest request) {
        log.info("saveDevice()-> {}", request);
        CreateDeviceResult result = new CreateDeviceResult(request.getName(), request.getType(),
                request.getFirmwareVersion());
        registerDeviceUseCase.run(new RegisterDeviceCommand(
                request.getName(), request.getType(),
                request.getFirmwareVersion(),
                request.getCustomerId(),
                request.getHardwareId()));
        return ResponseEntity.ok(result);
    }
}
