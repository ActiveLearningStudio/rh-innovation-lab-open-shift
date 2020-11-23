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