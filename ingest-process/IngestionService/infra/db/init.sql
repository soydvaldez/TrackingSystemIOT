CREATE DATABASE lectures;

\c lectures;

 CREATE TABLE sensor_raw_data (
    id SERIAL PRIMARY KEY,
    sensorId VARCHAR(100),
    LocalDateTime TIMESTAMP DEFAULT NOW(),
    temperature DECIMAL(10,2),
    humidity DECIMAL(10,2)
 );