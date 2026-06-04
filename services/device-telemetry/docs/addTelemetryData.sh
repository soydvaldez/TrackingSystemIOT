http POST "http://localhost:8010/api/v1/telemetry" \
  "X-API-KEY":super-secret-key <<EOF
{
    "deviceUuid": "123e4567-e89b-12d3-a456-426614174000",
    "deviceTimestamp": "2026-06-01T16:43:11.999Z",
    "measurements": [
        {
            "type": "temperature",
            "value": 40.5
        },
        {
            "type": "humidity",
            "value": 55.2
        },
        {
            "type": "gps",
            "value": 1337.0
        }
    ]
}
EOF

