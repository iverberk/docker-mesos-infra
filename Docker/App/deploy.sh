#!/bin/sh 

set -e

marathon="192.168.33.11"

curl -X DELETE -H "Content-Type: application/json" http://${marathon}:8080/v2/apps/app-$APP_ENV &> /dev/null

sleep 1

sed -i'.orig' "s/{{APP_VERSION}}/${APP_VERSION}/g" app.json
sed -i'.orig' "s/{{APP_ENV}}/${APP_ENV}/g" app.json

curl -X POST -H "Content-Type: application/json" http://${marathon}:8080/v2/apps?force=true -d@app.json &> /dev/null

mv -f app.json.orig app.json

exit 0
