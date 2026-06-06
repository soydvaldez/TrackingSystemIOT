CREATE TABLE devices (
    device_uuid UUID PRIMARY KEY,
    customer_uuid UUID NOT NULL,
    device_name VARCHAR(100) NOT NULL,
    device_model VARCHAR(100) NOT NULL,
    firmware_version VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL,
    registered_at TIMESTAMP NOT NULL,
    last_seen_at TIMESTAMP
);