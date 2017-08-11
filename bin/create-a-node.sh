BASEDIR=$(dirname "$0")
source $BASEDIR/env.sh

docker build  $APPDIR -t phoenix:latest
docker run --name $APP_CONTAINER_NAME -d -it --link $DATABASE_CONTAINER_NAME -v  $APPDIR:/root/apps -p 4000:4000 phoenix:latest bash /root/apps/bin/start-prod.sh
