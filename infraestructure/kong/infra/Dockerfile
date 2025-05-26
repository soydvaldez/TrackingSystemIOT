FROM postgres:17.0-alpine3.19

EXPOSE 5432
COPY ./backup/db/kong_db.sql /docker-entrypoint-initdb.d/kong.sql