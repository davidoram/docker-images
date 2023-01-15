#!/bin/bash

echo "Installing Connector"
confluent-hub install --no-prompt confluentinc/kafka-connect-elasticsearch:14.0.3
confluent-hub install --no-prompt confluentinc/kafka-connect-s3:10.3.0
confluent-hub install --no-prompt confluentinc/kafka-connect-s3-source:2.4.3
confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.6.0
confluent-hub install --no-prompt debezium/debezium-connector-postgresql:1.9.7
confluent-hub install --no-prompt confluentinc/kafka-connect-http:1.0.3

wget https://github.com/aiven/http-connector-for-apache-kafka/releases/download/v0.6.0/http-connector-for-apache-kafka-0.6.0.zip -O /tmp/http-connector-for-apache-kafka-0.6.0.zip && \
  unzip /tmp/http-connector-for-apache-kafka-0.6.0.zip -d /usr/share/java/kafka-connect-http && \
  rm /tmp/http-connector-for-apache-kafka-0.6.0.zip