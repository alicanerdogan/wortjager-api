$DATABASE_CONTAINER_NAME = "wortjager-db-dev"
$APP_CONTAINER_NAME = "wortjager-api"
$DATABASE_PASSWORD = "postgres"

docker build ./ -t phoenix:latest
docker run --name $DATABASE_CONTAINER_NAME -e POSTGRES_PASSWORD=$DATABASE_PASSWORD -d postgres
docker run --name $APP_CONTAINER_NAME -d -it --link $DATABASE_CONTAINER_NAME -v /C\\Users\\Alican\\Repos\\wortjager\\wortjager-api:/root/apps -p 4000:4000 phoenix:latest bash /root/apps/bin/start-dev.sh
