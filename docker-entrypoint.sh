#!/bin/sh -e

echo '> reconfigure clair'

: "${CLAIR_DB_HOST:=postgres}"
: "${CLAIR_DB_USER:=postgres}"
: "${CLAIR_DB_PASSWORD:=password}"
: "${CLAIR_DB_SSLMODE:=disable}"
: "${CLAIR_DB_UPDATE_INTERVAL:=24h}"

sed -i "s|host=localhost|host=$CLAIR_DB_HOST|" /config/config.yml
sed -i "s|user=postgres|user=$CLAIR_DB_USER password=$CLAIR_DB_PASSWORD|" /config/config.yml
sed -i "s|sslmode=disable|sslmode=$CLAIR_DB_SSLMODE|" /config/config.yml
sed -i "s|interval: 2h|interval: $CLAIR_DB_UPDATE_INTERVAL|" /config/config.yml

cat /config/config.yml
echo "> $@" && exec "$@"