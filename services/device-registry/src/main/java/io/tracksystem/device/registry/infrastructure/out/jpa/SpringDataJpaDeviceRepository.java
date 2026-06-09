package io.tracksystem.device.registry.infrastructure.out.jpa;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SpringDataJpaDeviceRepository extends CrudRepository<JpaDeviceEntity, Long> {

}
