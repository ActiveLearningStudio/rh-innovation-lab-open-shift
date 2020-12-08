#!/bin/bash

export PGPASSWORD=${PGPASSWORD:-password}
export USERNAME=${USERNAME:-curriki}
export DB_PORT=${DB_PORT:-5432}
export DB_NAME=${DB_NAME:-currikidb}
export DB_SERVICE=postgresql-master.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local

while true; do
  psql -U ${USERNAME}  -q -h ${DB_SERVICE} -p ${DB_PORT} -d ${DB_NAME} -qt -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'elastic_migrations');" | cut -d \| -f 1 | grep -qw t
  if [ $? -eq 1 ]; then
    echo " 🏗 no elastic_migrations table found - exiting 🏗";
    exit 0
  else
    echo " 🏗 elastic_migrations table found - creating 🏗";
    php artisan elastic:migrate:rollback --no-interaction 2>&1 > /dev/stdout
    php artisan elastic:migrate --no-interaction 2>&1 > /dev/stdout
    php artisan scout:import "App\Models\Activity" --no-interaction 2>&1 > /dev/stdout
    php artisan scout:import "App\Models\Playlist" --no-interaction 2>&1 > /dev/stdout
    php artisan scout:import "App\Models\Project" --no-interaction 2>&1 > /dev/stdout
    if [ $? -eq 0 ]; then
      exit 0
    fi
  fi
  sleep 5
done
