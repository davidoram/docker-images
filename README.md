# docker-images

Useful docker images, that run on `amd64` and `arm64` architectures:

- `go-kafka-client`
  - [`go-kafka-client v1.4.4`](go-kafka-client/v1.4.4/Dockerfile), is a `golang` image that contains preinstalled with the [librdkafka](https://github.com/confluentinc/librdkafka) library `v1.4.4` which works with Kafka `v0.10.0.1`. Note - this is **not** a multi-architecture build because thats not posible with this old version of librdkafka, but it will run fine on am M1 Mac.
  - [`go-kafka-client v2.3.0`](go-kafka-client/v2.3.0/Dockerfile), is a `golang` image that contains preinstalled with the [librdkafka](https://github.com/confluentinc/librdkafka) library `v2.3.0` which works with Kafka `v3.6.0`.
- [`Jailer v15.1.3`](jailer/v15.1.3/Dockerfile) See [Jailer](https://github.com/Wisser/Jailer) for more details.  This image is built from the `Jailer` source code, and is not available on Docker Hub. It is built for `amd64` and `arm64` architectures. Jailer is installed in `/opt/jailer`, which is added to the `PATH` environment variable.
- [`Kafka v0.10.0.1`](kafka/v0.10.0.1/Dockerfile)
- [`Postgres v13.5`](postgres/v13.5/Dockerfile)
  - Postgres `v13.5` made suitable for unit testing, by making the following configuration changes:

        fsync=off
        full_page_writes=off
        synchronous_commit=off
        max_connections=1000
        shared_buffers=200MB

  - Constructed by:
    - running `docker run -e POSTGRES_PASSWORD='password' postgres:13.5`
    - Copying out the config by running `docker cp <image>:/usr/share/postgresql/postgresql.conf.sample postgresql.conf.sample`
    - Editing the `postgresql.conf.sample` which is copied into the new image via the custom Dockerfile
  - To test it run `docker run --name dev-postgres  -e POSTGRES_PASSWORD='password' --rm -p 5432:5432 --network=bridge davidoram/postgres:13.5` and then connect to it and execute `SHOW max_connections;` which should be `1000`
- [`Postgres v13.5-pglogical`](postgres/v13.5-pglogical/Dockerfile). Is a standard postgres 13.5 image with the pglogical extension installed, and enabled. Suitable for testing.
  - To test it run `docker run --name dev-postgres  -e POSTGRES_PASSWORD='password' --rm -p 5432:5432 --network=bridge davidoram/postgres-pglogical:13.5`
- [`Timescale v2.5.1`]()
  - Timescaledb `v2.5.1` made suitable for unit testing, by making the following configuration changes:

        fsync=off
        full_page_writes=off
        synchronous_commit=off
        max_connections=1000
        shared_buffers=200MB

  - Constructed by:
    - running `docker run -e POSTGRES_PASSWORD='password' timescale/timescaledb:2.5.1-pg14`
    - Copying out the config by running `docker cp <image>:/usr/local/share/postgresql/postgresql.conf.sample postgresql.conf.sample`
    - Editing the `postgresql.conf.sample` which is copied into the new image via the custom Dockerfile
  - To test it run `docker run --name dev-postgres  -e POSTGRES_PASSWORD='password' --rm -p 5432:5432 --network=bridge timescale/timescaledb:2.5.1-pg14` and then connect to it and execute `SHOW max_connections;` which should be `1000`
