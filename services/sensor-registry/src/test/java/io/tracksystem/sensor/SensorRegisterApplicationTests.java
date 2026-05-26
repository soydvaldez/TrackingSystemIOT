package io.tracksystem.sensor;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import javax.sql.DataSource;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ScriptUtils;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ActiveProfiles;

import io.tracksystem.sensor.infrastructure.SensorEntity;
import io.tracksystem.sensor.infrastructure.SensorIoTRepository;
import io.tracksystem.sensor.presentation.request.SensorRequest;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import io.tracksystem.sensor.utils.DateUtils;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
// @ContextConfiguration(classes = { NewSensorAddedConfig.class })
class SensorRegisterApplicationTests {

	@Autowired
	private SensorIoTRepository sensorRepository;

	@Value("${persistence.unit.name}")
	private String persistenceUnitName;

	@PersistenceUnit(unitName = "H2EntityManagerFactory")
	private EntityManagerFactory entityManagerFactory;

	@Autowired
	private DataSource dataSource;

	@BeforeEach
	void initDatabase() {
		String scriptSchema = "schema-test.sql";
		String scriptData = "data-test.sql";

		log.info("Inicializando la base de datos: {}", persistenceUnitName);

		try (Connection conn = dataSource.getConnection()) {
			log.info("Execute script: {}", scriptSchema);
			ScriptUtils.executeSqlScript(conn, new ClassPathResource(scriptSchema));
			log.info("Execute script: {}", scriptData);
			ScriptUtils.executeSqlScript(conn, new ClassPathResource(scriptData));
			conn.close();
		} catch (SQLException e) {
			log.error("SQLException: {}", e.getMessage());
			throw new RuntimeException("Error resetting database", e);
		}
	}

	@Test
	void shouldReturnASensorListAndObjectsShouldNotBeEmpty() {
		log.info("Running Test: {}", "shouldReturnASensorListAndObjectsShouldNotBeEmpty");
		List<SensorEntity> sensors = sensorRepository.findAll();

		for (SensorEntity sensorEntity : sensors) {
			log.info("{}", sensorEntity);
		}
	}

	@Test
	@DirtiesContext
	void shouldReturnAListOfSensorsWhenItIsListed() {
		log.info("Running Test: {}", "shouldReturnAListOfSensorsWhenItIsListed");
		List<SensorEntity> sensorList = sensorRepository.findAll();

		long total = sensorList.size();
		assertThat(total).isEqualTo(5L);

		// 'SENSOR001', 'DHT22', 'Warehouse A','2024-01-15 00:00:00', 'Active'

		assertNotNull(sensorList.get(0).getId());
		assertThat(sensorList.get(0).getId()).isEqualTo(1);
		assertThat(sensorList.get(0).getName()).isEqualTo("DHT22");
		assertThat(sensorList.get(0).getLocation()).isEqualTo("Warehouse A");
		assertThat(sensorList.get(0).getCreatedAt())
				.isEqualTo(DateUtils.convertStringToLocalDateTime("2024-01-15 00:00:00"));
		assertThat(sensorList.get(0).getStatus()).isEqualTo("Active");

		// Otras pruebas podrias hacer casos de uso y casos de uso especiales para
		// realizar pruebas
	}

	@Test
	void shouldReturnASensorWhenSensorIdIsProvided() {
		log.info("Running Test: {}", "shouldReturnASensorWhenSensorIdIsProvided");
		Optional<SensorEntity> sensorFinded = sensorRepository.findById(5L);

		Assertions.assertTrue(sensorFinded.isPresent());
		SensorEntity sensorFromDB = sensorFinded.get();

		assertThat(sensorFromDB.getId()).isEqualTo(5);
	}

	@Test
	void shouldNotReturnASensorWhenIdDoesNotExist() {
		log.info("Running Test: {}", "shouldNotReturnASensorWhenIdDoesNotExist");
		Optional<SensorEntity> sensorOptional = sensorRepository.findById(10L);
		Assertions.assertTrue(sensorOptional.isEmpty());
	}

	@Test
	void shouldReturnASensorWhenItIsSaved() {
		log.info("Running Test: {}", "shouldReturnASensorWhenItIsSaved");
		LocalDateTime currentLocalDateTime = DateUtils.getCurrentLocalDateTime();

		SensorRequest newSensor = new SensorRequest();
		newSensor.setSensorId("SENSOR006");
		newSensor.setSensorName("DHT22");
		newSensor.setLocation("Warehouse A");
		newSensor.setInstallationDate(currentLocalDateTime);
		newSensor.setStatus("Active");

		// Mapeo de DTO a Entity
		SensorEntity sensorEntity = mapperSensorRequestDTOtoEntity(newSensor);

		// Respuesta del servidor
		SensorEntity sensorSaved = sensorRepository.saveAndFlush(sensorEntity);

		assertNotNull(sensorSaved.getId());
		assertThat(sensorEntity.getName()).isEqualTo("DHT22");
		assertThat(sensorEntity.getLocation()).isEqualTo("Warehouse A");
		assertThat(sensorEntity.getCreatedAt()).isEqualTo(currentLocalDateTime);
		assertThat(sensorEntity.getStatus()).isEqualTo("Active");
	}

	public SensorEntity mapperSensorRequestDTOtoEntity(SensorRequest sensorRequestDTO) {
		SensorEntity entity = new SensorEntity();
		// sensorRequestDTO.getSensorId();
		entity.setId(10L);
		entity.setName(sensorRequestDTO.getSensorName());
		entity.setLocation(sensorRequestDTO.getLocation());
		entity.setCreatedAt(sensorRequestDTO.getInstallationDate());
		entity.setUpdatedAt(sensorRequestDTO.getInstallationDate());
		entity.setStatus(sensorRequestDTO.getStatus());

		return entity;
	}
}
