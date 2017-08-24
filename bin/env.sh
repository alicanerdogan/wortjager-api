BASEDIR=$(dirname "$0")
APPDIR=$(realpath "${BASEDIR}/..")
DATABASE_CONTAINER_NAME="wortjager-db"
APP_IMAGE_TAG="wortjager-api-base:latest"
APP_PORT="5000"
APP_CONTAINER_NAME="wortjager-api"
DATABASE_PASSWORD="postgres"
