INSERT INTO devices (
    external_id,
    customer_id,
    device_name,
    device_model,
    firmware_version,
    status,
    registered_at,
    last_seen_at
) VALUES

-- Cliente AgroTech
(
    'bc86cbdf-7a45-49e9-a54e-406e7fa8455f',
    'c2c0cbe9-6b50-4819-835d-d7d2f26ba25d',
    'Greenhouse ESP32 #01',
    'ESP32-WROOM-32',
    '1.4.2',
    'ACTIVE',
    TIMESTAMP '2026-05-10 08:00:00',
    TIMESTAMP '2026-06-04 12:15:00'
),

(
    '2de55537-0337-4bc4-8397-e3d0f45e4c59',
    'c2c0cbe9-6b50-4819-835d-d7d2f26ba25d',
    'Greenhouse ESP32 #02',
    'ESP32-WROOM-32',
    '1.4.2',
    'ACTIVE',
    TIMESTAMP '2026-05-11 09:30:00',
    TIMESTAMP '2026-06-04 12:12:00'
),

(
    '9c97f579-f282-4c4a-8363-13d9dba3aedf',
    'c2c0cbe9-6b50-4819-835d-d7d2f26ba25d',
    'Weather Station ESP32',
    'ESP32-S3',
    '1.3.8',
    'INACTIVE',
    TIMESTAMP '2026-05-15 10:45:00',
    TIMESTAMP '2026-06-02 18:30:00'
),

-- Cliente ColdChain Logistics
(
    'd6f566c1-d3dd-4bf1-8cea-6842883e0634',
    '9d10a5bb-7d91-43f0-a74c-ef37d6341988',
    'Refrigerated Truck #01',
    'ESP32-S3',
    '2.0.1',
    'ACTIVE',
    TIMESTAMP '2026-05-20 07:00:00',
    TIMESTAMP '2026-06-04 12:10:00'
),

(
    '222909b1-2316-472e-8c99-74364a72e96d',
    '9d10a5bb-7d91-43f0-a74c-ef37d6341988',
    'Refrigerated Truck #02',
    'ESP32-S3',
    '2.0.1',
    'ACTIVE',
    TIMESTAMP '2026-05-21 07:15:00',
    TIMESTAMP '2026-06-04 12:09:00'
),

(
    '6c37cc09-2210-4e5e-b8d2-6dcbd0b822e4',
    '9d10a5bb-7d91-43f0-a74c-ef37d6341988',
    'Cold Storage Gateway',
    'ESP32-WROOM-32',
    '1.9.0',
    'INACTIVE',
    TIMESTAMP '2026-05-25 14:20:00',
    TIMESTAMP '2026-06-01 23:50:00'
);