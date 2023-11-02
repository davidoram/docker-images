FROM golang:1.21.3-alpine AS builder

WORKDIR /usr/src/app

RUN apk add --no-cache openssh-client git gcc make bc musl-dev bash build-base openssl-dev zlib-dev sqlite
RUN wget -O /usr/local/bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /usr/local/bin/wait-for-it.sh

ARG MIGRATE_VERSION=v4.16.2
RUN go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@${MIGRATE_VERSION} && \
    mv /go/bin/migrate /usr/local/bin/
ARG LINTER_VERSION=v1.55.0
RUN wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | \
    sh -s ${LINTER_VERSION} && \
    mv bin/golangci-lint /usr/local/bin/

# Install librdkafka
# If you change the version of librdkafka, search for it globally and update everywhere
ARG LIBRDKAFKA_VER=1.4.4
ENV LIBRDKAFKA_VER ${LIBRDKAFKA_VER}
RUN wget -q -O - https://github.com/edenhill/librdkafka/archive/refs/tags/v${LIBRDKAFKA_VER}.tar.gz | tar xz
RUN cd librdkafka-${LIBRDKAFKA_VER} && \
    ./configure --install-deps && \
    make && \
    make install

# Install all the go tools used by the vscode golaang extension
RUN go install github.com/cweill/gotests/gotests@v1.6.0 \
    github.com/fatih/gomodifytags@v1.16.0 \
    github.com/josharian/impl@v1.1.0 \
    github.com/haya14busa/goplay/cmd/goplay@v1.0.0 \
    github.com/go-delve/delve/cmd/dlv@latest \
    honnef.co/go/tools/cmd/staticcheck@latest \
    golang.org/x/tools/gopls@latest



