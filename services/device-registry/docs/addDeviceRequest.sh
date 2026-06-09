http POST "http://localhost:8020/devices/registry" <<EOF
{
  "name": "ESP32 Invernadero",
  "type": "iot-gateway",
  "firmwareVersion": "1.0.0",
  "customerId": "b2a911ea-5b62-45e3-a42c-197179a91c49",
  "model": "ESP32",
  "hardwareId": "a11c7203-a8cc-49ea-9ffd-f21f51660b7f"
}
EOF



http POST http://localhost:8020/devices/registry \
  name="ESP32 Invernadero" \
  type="iot-gateway" \
  firmwareVersion="1.0.0" \
  customerId="b2a911ea-5b62-45e3-a42c-197179a91c49" \
  model="ESP32" \
  hardwareId="$(uuidgen | tr '[:upper:]' '[:lower:]')"