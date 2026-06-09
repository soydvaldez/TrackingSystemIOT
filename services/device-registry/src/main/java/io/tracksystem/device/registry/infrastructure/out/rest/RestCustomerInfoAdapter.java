package io.tracksystem.device.registry.infrastructure.out.rest;

import org.springframework.stereotype.Component;

import io.tracksystem.device.registry.application.port.out.CustomerPolicyService;
import io.tracksystem.device.registry.application.port.out.CustomerStatus;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class RestCustomerInfoAdapter implements CustomerPolicyService {

    @Override
    public CustomerStatus canRegisterDevice(String customerId) {

        log.info("canRegisterDevice() -> query to customer service with id: {}", customerId);
        CustomerStatusRestResponse response;

        if ("b2a911ea-5b62-45e3-a42c-197179a91c49".equals(customerId)) {
            response = new CustomerStatusRestResponse(true, true);
        } else {
            response = new CustomerStatusRestResponse(false, false);
        }

        CustomerStatus adapterOutput = new CustomerStatus(response.exists(), response.active(), true);

        return adapterOutput;
    }

}
