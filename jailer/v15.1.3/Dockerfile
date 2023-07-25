FROM amazoncorretto:20.0.2-alpine

ENV JAILER_VERSION="15.1.3"

RUN apk add \
    bash \
    zip

ADD https://github.com/Wisser/Jailer/releases/download/v${JAILER_VERSION}/jailer_${JAILER_VERSION}.zip /tmp

RUN cd /tmp && \
    ls -al && \
    unzip jailer_${JAILER_VERSION}.zip -d /opt && \
    rm -f jailer_${JAILER_VERSION}.zip && \
    ls -ltr /opt && \
    /opt/jailer/jailer.sh

# Add Jailer to the PATH
ENV PATH "$PATH:/opt/jailer"



