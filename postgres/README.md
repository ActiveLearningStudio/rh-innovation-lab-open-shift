## postgres

Master / Read Replica postgres using OpenShift out of the box images

### Deploy

Deploy database instances as any user
```bash
kustomize build dev-cluster | oc apply -f-
```

### Test

Port forward read/write master
```bash
oc port-forward svc/postgresql-master 5432:5432
```

Connect to db create role
```bash
pgcli postgresql://postgres:password@localhost:5432/currikidb
CREATE ROLE curriki;
SELECT rolname FROM pg_roles;
\du
```

Load data
```bash
psql -h localhost -d currikidb -U pguser -f studio-initial-db.sql
```

View Tables
```bash
pgcli postgresql://pguser:password@localhost:5432/currikidb
\dt
```

Conect to Read Replica
```bash
oc port-forward svc/postgresql-slave 5432:5432
```

### Permissions

Handy one liners. If you drop and recreate the database:
```bash
export PGPASSWORD=${PGPASSWORD:-password}
export DB_PORT=${DB_PORT:-5432}
export DB_NAME=${DB_NAME:-currikidb}
export DB_SERVICE=postgresql-master.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local

psql -h ${DB_SERVICE} -p ${DB_PORT} -d postgres -c "DROP DATABASE currikidb;"
psql -h ${DB_SERVICE} -p ${DB_PORT} -d postgres -c "CREATE DATABASE currikidb;"
psql -h ${DB_SERVICE} -p ${DB_PORT} -d postgres -c "GRANT CONNECT ON DATABASE currikidb TO pguser;"

GRANT ALL PRIVILEGES ON DATABASE currikidb TO pguser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO pguser;
GRANT USAGE ON SCHEMA public TO pguser;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO pguser;
```