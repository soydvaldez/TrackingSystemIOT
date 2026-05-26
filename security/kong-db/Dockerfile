FROM postgres:17.0-alpine3.19

EXPOSE 5432
COPY ./backup/kong_db_20250526_205109.sql /docker-entrypoint-initdb.d/kong.sql
