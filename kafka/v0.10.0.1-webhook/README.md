# Kafka version 0.10.0.1

This docker image runs zookeeper + kafka + kafka connect from within a single docker image.

To run:

`docker run
To see it running connect to the docker image, and run:

```
/opt/test-topic.sh
/opt/test-producer.sh
/opt/test-consumer.sh
```


```
go run webhook.go
curl -X POST localhost:8080/kafka-webhook -d '{"topic": "test", "message": "hello world"}'
```

## Kafka connect

- API endpoint `http://localhost:8083`
  - [Docs](https://kafka.apache.org/0100/documentation.html#connect_rest)
- Connectors installed:
  - https://github.com/aiven/http-connector-for-apache-kafka


