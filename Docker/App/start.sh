#!/bin/sh

# Check if database exists
[ ! -f /data/db/notejam-$APP_ENV.db ] && touch /data/db/notejam-$APP_ENV.db

# Change working directory
cd /data

# Migrate database
./artisan migrate --force --quiet

# Change working directory
cd /data/public

# Run application
php -S 0.0.0.0:8000
