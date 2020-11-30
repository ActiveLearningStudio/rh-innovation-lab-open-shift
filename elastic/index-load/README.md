## index load

Initialize elasticsearch index with data from DB. We use this image as the base for a kubernetes job.

```bash
docker build -t quay.io/masood_faisal/curriki-es-index-load -f Dockerfile .
docker push quay.io/masood_faisal/curriki-es-index-load:latest
```