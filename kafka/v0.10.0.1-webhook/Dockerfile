FROM openjdk:8-jre-alpine

ENV KAFKA_VERSION="0.10.0.1" SCALA_VERSION="2.11"

RUN apk add \
    curl \
    supervisor \
    bash \
    sed

RUN url="https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" && \
    curl  "${url}" -o "/tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"

# RUN cd /tmp && curl "https://www.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" -O
RUN ls -la /tmp
RUN tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

# Install the Kafka Connectors
#
# Use the fact that bin/kafka_run.sh will load jars from $base_dir/connect/runtime/build/dependant-libs
#
# Note that 0.5.0 is not compatible with this version of Kafka.
# - java.lang.UnsupportedClassVersionError: io/aiven/kafka/connect/http/HttpSinkConnector has been compiled by a more recent version of the Java Runtime (class file version 55.0), this version of the Java Runtime only recognizes class file versions up to 52.0
#
# Also note that project name changes from 0.4.0 to 0.5.0, but the class name is the same.

ENV AIVEN_CONNECTOR_NAME="http-connector-for-apache-kafka"
#ENV AIVEN_CONNECTOR_NAME="aiven-kafka-connect-http"
ENV AIVEN_CONNECTOR_VERSION="0.6.0"
ENV AIVEN_TAR_FILE="${AIVEN_CONNECTOR_NAME}-${AIVEN_CONNECTOR_VERSION}.tar"
RUN curl -L https://github.com/aiven/http-connector-for-apache-kafka/releases/download/v${AIVEN_CONNECTOR_VERSION}/${AIVEN_TAR_FILE} > /tmp/${AIVEN_TAR_FILE} && \
    tar xf /tmp/${AIVEN_TAR_FILE} -C /tmp   && \
    mkdir -p /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/connect/runtime/build/dependant-libs && \
    mv /tmp/${AIVEN_CONNECTOR_NAME}-${AIVEN_CONNECTOR_VERSION}/* /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/connect/runtime/build/dependant-libs && \
    rm -rf /tmp/${AIVEN_TAR_FILE} /tmp/${AIVEN_CONNECTOR_NAME}-${AIVEN_CONNECTOR_VERSION}

COPY config/server.properties.template /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/
COPY config/zookeeper.properties.template /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/
COPY config/connect-standalone.properties.template /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/
COPY config/aiven-http-connector.properties.template /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/

COPY config/supervisord.conf.template /etc/
COPY config/zookeeper-wait.sh.template /opt
COPY config/test*.sh.template /opt

ADD start.sh /tmp/start.sh
RUN mkdir /tmp/zookeeper/
RUN mkdir -p /data/kafka-logs

# Can override these envars when running the docker image

#
# Zookeeper
#
ENV ZOOKEEPER_CLIENT_PORT="2081"
ENV ZOOKEEPER_SERVER_1=localhost
ENV ZOOKEEPER_CONNECTION_STRING="127.0.0.1:2081"

#
# Kafka
#
ENV KAFKA_ID="1"
ENV KAFKA_ADVERTISED_HOST_NAME="localhost"
ENV KAFKA_ADVERTISED_PORT="9092"
ENV SERVER_JMX_PORT=9875

#
# Kafka connect
#
ENV AIVEN_HTTP_URL="http://172.17.0.1:8080/kafka-webhook"

# Ports
EXPOSE 2081
EXPOSE 9092
EXPOSE 9875
EXPOSE 8083


CMD ["/tmp/start.sh"]