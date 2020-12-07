## schedule run

Schedule run cron job. We use this image as the base for a kubernetes job.

```bash
docker build -t quay.io/fahad_curriki/curriki-artisan-schedule-run -f Dockerfile .
docker push quay.io/fahad_curriki/curriki-artisan-schedule-run:latest
```