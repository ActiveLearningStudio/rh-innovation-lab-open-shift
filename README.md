# Deploy CurrikiStudio using Red Hat OpenShift
<img src="https://www.curriki.org/wp-content/uploads/2020/11/red-hat-curriki.png">
<p />

This repository provides all of the OpenShift Configurations and resources needed to deploy CurrikiStudio.

## GitOps

[`ubiquitous-journey`](ubiquitous-journey) - GitOps Bootstrap all of our CI/CD

## Middleware

The following middleware is required to support the CurrikiStudion deployment:

[`minio`](minio) - minimal minio (s3 server) setup with perssitent volumes on openshift

[`elastic`](elastic) - elastic search cluster and kibana operator

[`redis`](redis) - redis cluster operator

[`mysql`](mysql) - mysql database instance

[`postgres`](postgres) - postgresql  master, read-replica cluster

## CurrikiStudio Applications

[`curriki-api`](curriki-api) - The CurrikiStudio API Service

[`curriki-ui`](curriki-ui) - The CurrikiStudio User Interface

[`curriki-admin`](curriki-admin) - The CurrikiStudio Admin Application

[`curriki-tsugi`](curriki-tsugi) - The CurrikiStudio Tsugi LMS Integration

## Experimental

[`yugabyte`](yugabyte) - yugabyte database operator
