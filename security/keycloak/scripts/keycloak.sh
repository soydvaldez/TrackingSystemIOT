docker run -p 8080:8080 \
  --name=keycloak-service \
  --network=kong-net \
  --ip 172.21.0.15 \
  -v ./volumes/keycloak:/opt/keycloak/data \
  -e KEYCLOAK_ADMIN=admin \
  -e KEYCLOAK_ADMIN_PASSWORD=admin \
  --rm -d \
  keycloak/keycloak start-dev
