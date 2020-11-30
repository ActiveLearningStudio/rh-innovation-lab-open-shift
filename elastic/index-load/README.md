## index load

Initialize elasticsearch index with data from DB. We use this image as the base for a kubernetes job.

```bash
podman build -t quay.io/fahad_curriki/curriki-es-index-load -f Dockerfile
podman push quay.io/fahad_curriki/curriki-es-index-load:latest
```