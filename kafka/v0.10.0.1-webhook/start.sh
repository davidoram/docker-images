#!/bin/sh

# Create Kafka config file from ENV settings
cat /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/server.properties.template | sed \
    -e "s|{{KAFKA_ID}}|${KAFKA_ID}|g" \
    -e "s|{{ZOOKEEPER_CONNECTION_STRING}}|${ZOOKEEPER_CONNECTION_STRING}|g" \
    -e "s|{{KAFKA_ADVERTISED_HOST_NAME}}|${KAFKA_ADVERTISED_HOST_NAME:-$IP}|g" \
    -e "s|{{KAFKA_ADVERTISED_PORT}}|${KAFKA_ADVERTISED_PORT:-$IP}|g" \
    > /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/server.properties

# Create Zookeeper config file from ENV settings
cat /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/zookeeper.properties.template | sed \
    -e "s|{{ZOOKEEPER_SERVER_1}}|${ZOOKEEPER_SERVER_1}|g" \
    -e "s|{{ZOOKEEPER_SERVER_2}}|${ZOOKEEPER_SERVER_2}|g" \
    -e "s|{{ZOOKEEPER_SERVER_3}}|${ZOOKEEPER_SERVER_3}|g" \
    -e "s|{{ZOOKEEPER_CLIENT_PORT}}|${ZOOKEEPER_CLIENT_PORT}|g" \
    > /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/zookeeper.properties

# Create Kafka connect config file from ENV settings
cat /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/connect-standalone.properties.template | sed \
    -e "s|{{KAFKA_ADVERTISED_HOST_NAME}}|${KAFKA_ADVERTISED_HOST_NAME:-$IP}|g" \
    -e "s|{{KAFKA_ADVERTISED_PORT}}|${KAFKA_ADVERTISED_PORT:-$IP}|g" \
    > /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/connect-standalone.properties

# Create aiven/http-connector-for-apache-kafka connect config file from ENV settings
cat /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/aiven-http-connector.properties.template | sed \
    -e "s|{{AIVEN_HTTP_URL}}|${AIVEN_HTTP_URL}|g" \
    > /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/aiven-http-connector.properties

# Create supervisord config file from ENV settings
cat /etc/supervisord.conf.template | sed \
    -e "s|{{JMX_PORT}}|${SERVER_JMX_PORT}|g" \
    > /etc/supervisord.conf

# Create script that waits for zookeeper to be ready
cat /opt/zookeeper-wait.sh.template | sed \
    -e "s|{{ZOOKEEPER_SERVER_1}}|${ZOOKEEPER_SERVER_1}|g" \
    -e "s|{{ZOOKEEPER_SERVER_2}}|${ZOOKEEPER_SERVER_2}|g" \
    -e "s|{{ZOOKEEPER_SERVER_3}}|${ZOOKEEPER_SERVER_3}|g" \
    -e "s|{{ZOOKEEPER_CLIENT_PORT}}|${ZOOKEEPER_CLIENT_PORT}|g" \
    > /opt/zookeeper-wait.sh
chmod +x /opt/zookeeper-wait.sh

# .. and add that scrript into the top of the script that starts Kafka
sed -i '/^#!.*/a /opt/zookeeper-wait.sh' /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/bin/kafka-server-start.sh

# Create test-producer script
cat /opt/test-producer.sh.template | sed \
    -e "s|{{SCALA_VERSION}}|${SCALA_VERSION}|g" \
    -e "s|{{KAFKA_VERSION}}|${KAFKA_VERSION}|g" \
    -e "s|{{KAFKA_ADVERTISED_HOST_NAME}}|${KAFKA_ADVERTISED_HOST_NAME}|g" \
    -e "s|{{KAFKA_ADVERTISED_PORT}}|${KAFKA_ADVERTISED_PORT}|g" \
    > /opt/test-producer.sh
chmod +x /opt/test-producer.sh

# Create test-topic script
cat /opt/test-topic.sh.template | sed \
    -e "s|{{SCALA_VERSION}}|${SCALA_VERSION}|g" \
    -e "s|{{KAFKA_VERSION}}|${KAFKA_VERSION}|g" \
    -e "s|{{ZOOKEEPER_CONNECTION_STRING}}|${ZOOKEEPER_CONNECTION_STRING}|g" \
    > /opt/test-topic.sh
chmod +x /opt/test-topic.sh

# Create test-consumer script
cat /opt/test-consumer.sh.template | sed \
    -e "s|{{SCALA_VERSION}}|${SCALA_VERSION}|g" \
    -e "s|{{KAFKA_VERSION}}|${KAFKA_VERSION}|g" \
    -e "s|{{ZOOKEEPER_CONNECTION_STRING}}|${ZOOKEEPER_CONNECTION_STRING}|g" \
    > /opt/test-consumer.sh
chmod +x /opt/test-consumer.sh

echo $ZOOKEEPER_ID > /tmp/zookeeper/myid

exec /usr/bin/supervisord -c /etc/supervisord.conf