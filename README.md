# docker-images

Useful docker images, that run on `amd64` and `arm64` architectures:

- [`Kafka v0.10.0.1`](kafka/v0.10.0.1/Dockerfile)
- [`Kafka-Connect v7.3.1`](kafka-connect/v7.3.1/Dockerfile)
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


## Kafka & Kafka-connect

To create a system for testing `kafka` alongside `kafka-connect` you need to run them so that you can acesss them from your local machine. To do this you need to run them on the `bridge` network, and then expose the ports to your local machine.

If you want to test a connector like [http-connector-for-apache-kafka](https://github.com/aiven/http-connector-for-apache-kafka), then the `kafka-connect` needs to be both connect to `kafka`, and also make webhook calls out to your local machine, so we can do that using the following Docker commands:

`docker compose -f docker-compose-kafka-connect.yml up`
