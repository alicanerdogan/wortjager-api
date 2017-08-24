BASEDIR=$(dirname "$0")
source $BASEDIR/env.sh

docker build  $APPDIR -t $APP_IMAGE_TAG
docker run --name $APP_CONTAINER_NAME -d -it --link $DATABASE_CONTAINER_NAME -v  $APPDIR:/root/apps -p $APP_PORT:4000 $APP_IMAGE_TAG bash /root/apps/bin/start-prod.sh
