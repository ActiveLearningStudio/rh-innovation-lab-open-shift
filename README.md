# Deploy CurrikiStudio using Red Hat OpenShift
<img src="https://www.curriki.org/wp-content/uploads/2020/11/red-hat-curriki.png">
<p />

This repository provides all of the OpenShift Configurations and resources needed to deploy Currikistudio.

## Middleware

The following middleware is required to support the CurrikiStudion deployment:

[`yugabyte`](yugabyte) - yugabyte database operator

[`minio`](minio) - minimal minio (s3 server) setup with perssitent volumes on openshift

[`elastic`](elastic) - elastic search cluster and kibana operator

[`redis`](redis) - redis cluster operator

[`mysql`](ysql) - mysql database instance

[`postgres`](postgres) - postgresql  master, read-replica cluster

## CurrikiStudio Applications

[`curriki-api`](curriki-api) - The CurrikiStudio API Service

[`curriki-ui`](react-ui) - The CurrikiStudio User Interface