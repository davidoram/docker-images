# docker-images

Useful docker images, that run on `amd64` and `arm64` architectures:

- [`Kafka v0.10.0.1`](kafka/v0.10.0.1/Dockerfile)
- [`Postgres v13.5`](postgres/v13.5/Dockerfile)
  - Constructed by running `docker run -i --rm postgres:13.5 cat /usr/share/postgresql/postgresql.conf.sample > postgres.conf`, updating that file and copying it into the custom Dockerfile
- [`Timescale v2.5.1`]()
  - Constructed by running `docker run -i --rm timescale/timescaledb:2.5.1-pg14 cat /usr/local/share/postgresql/postgresql.conf.sample > postgres.conf`, updating that file and copying it into the custom Dockerfile

