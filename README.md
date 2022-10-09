# postgres-ha-docker-vm

Deploy HA Postgres Cluster on VM with Docker and Docker Compose

## Overral Deployment Architecture

![deployment-architecture.png](./images/deployment-architecture.png)

## Environemt

- OS VM: Ubuntu 20.04 Server
- Docker + Docker Compose
- PostgreSQL 13.3
- Patroni 2.1.4
- PgBackrest 2.41
- S3 Compatible Object Storage Solution -  Ceph Rados Gateway

## Deploy

Prepare 4 VMs, 3 VMs for Postgres Cluster, 1 VM for PGBackrest Backup Repostory.

For example in this document:

Postgres Cluster VMs:

- 192.168.150.201 pg-srv1
- 192.168.150.202 pg-srv2
- 192.168.150.203 pg-srv3

PGBackrest Backup Repostory VM:

- 192.168.150.211 pg-backup-repo1

## Prepare

### Prepare Container Image

Build Container Image:

```bash
docker-compose build postgres
```

Then push your container image to your container registry repository

### Prepare Host Environment

### Initial New Cluster

Jump to first host `pg-srv1`.

Create user `postgres` with `UID 1001`. Grant user `postgres` `docker` and
`docker-compose` permission

Clone this GitHub Repo to working directory.

```bash

```

### Perform Full Backup

### Create new Postgres Secondary VM

### Rollback or Recreate Cluster from PGBackrest Backup Data

### Handle when PGBackrest Repository Down and can not recover

## References

- https://pgstef.github.io/2022/02/21/pgbackrest_tls_server.html
- https://pgstef.github.io/2022/07/12/patroni_and_pgbackrest_combined.html
- https://github.com/zalando/patroni/blob/v2.1.4/kubernetes/Dockerfile