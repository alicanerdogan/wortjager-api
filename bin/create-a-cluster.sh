BASEDIR=$(dirname "$0")
source $BASEDIR/env.sh

docker run --name $DATABASE_CONTAINER_NAME -e POSTGRES_PASSWORD=$DATABASE_PASSWORD -d postgres
$BASEDIR/create-a-node.sh
