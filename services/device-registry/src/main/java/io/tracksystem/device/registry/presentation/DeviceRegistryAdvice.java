package io.tracksystem.device.registry.presentation;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import io.tracksystem.device.registry.application.service.CustomerNotActiveException;

record ErrorResponse(
                String code,
                String message) {
}

@RestControllerAdvice
public class DeviceRegistryAdvice {

        @ExceptionHandler(CustomerNotActiveException.class)
        @ResponseStatus(HttpStatus.BAD_REQUEST)
        public ResponseEntity<ErrorResponse> handleCustomerNotActiveException(CustomerNotActiveException e) {

                return ResponseEntity.badRequest()
                                .body(new ErrorResponse(
                                                "CUSTOMER_NOT_ACTIVE",
                                                e.getMessage()));
        }

        @ExceptionHandler(MethodArgumentNotValidException.class)
        public ResponseEntity<Map<String, List<String>>> handleValidationException(
                        MethodArgumentNotValidException exception) {

                List<String> errors = exception
                                .getBindingResult()
                                .getFieldErrors()
                                .stream()
                                .map(error -> error.getDefaultMessage())
                                .toList();

                Map<String, List<String>> body = Map.of(
                                "errors", errors);

                return ResponseEntity.badRequest().body(body);
        }
}
