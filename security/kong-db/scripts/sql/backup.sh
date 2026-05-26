function backup_dbs() {
    FECHA=$(date +"%Y%m%d_%H%M%S");
    DB="kong_db"
    echo "Respaldando db: $DB"
    docker exec -t kong-db pg_dump -U kong --create -d kong  > infraestructure/db/backup/${DB}_${FECHA}.sql
}