## database load

Initialize postgresql database with default schema. We use this image as the base for a kubernetes job.

```bash
podman build -t quay.io/eformat/curriki-database-load -f Dockerfile
podman push quay.io/eformat/curriki-database-load:latest
```