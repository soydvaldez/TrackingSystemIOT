INSERT INTO sensors (id, name, model, location, created_at, updated_at, status)
VALUES 
(1, 'DHT22', 'DHT22_A','Warehouse A','2024-01-15 00:00:00', '2024-01-15 00:00:00','Active'),
(2, 'DS18B20', 'DS18B20_B','Warehouse B','2024-02-10 00:00:00', '2024-02-10 00:00:00','Active'),
(3, 'BME280', 'BME280_C','Production Floor','2024-03-05 00:00:00', '2024-03-05 00:00:00','Inactive'),
(4, 'LM35', 'LM35_D','Office','2024-04-20 00:00:00', '2024-04-20 00:00:00','Active'),
(5, 'Si7021', 'Si7021_E','Data Center','2024-05-25 00:00:00', '2024-05-25 00:00:00','Active');

-- Actualiza el id
ALTER TABLE sensors ALTER COLUMN id RESTART WITH (
    SELECT COALESCE(MAX(id), 0) + 1 FROM sensors
);