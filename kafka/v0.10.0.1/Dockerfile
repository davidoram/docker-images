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


COPY config/server.properties.template /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/
COPY config/zookeeper.properties.template /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}/config/

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

# Ports
EXPOSE 2081
EXPOSE 9092
EXPOSE 9875


CMD ["/tmp/start.sh"]