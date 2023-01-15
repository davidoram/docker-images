# Would prefer to target a specific version, but tagged versions don't support
# mult-architectures, so we'll have to target latest and hope for the best.
# This is a temporary workaround until we can target a specific version.
# As as 15/1/2023, the latest version is 7.3.1.
FROM confluentinc/cp-kafka-connect-base:latest
USER root
RUN yum install -y jq unzip
COPY kafka-connect-install.sh /kafka-connect-install.sh
RUN /kafka-connect-install.sh
COPY files /etc/confluent/docker