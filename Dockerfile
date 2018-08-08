FROM alpine:latest

RUN apk add --no-cache libstdc++ protobuf && \
  apk add --no-cache --virtual .build-deps git
WORKDIR /tmp
RUN git clone https://github.com/grpc/grpc
WORKDIR /tmp/grpc
RUN git submodule update --init
RUN apk add --no-cache --virtual .build-deps build-base autoconf automake libtool
RUN make && \
  make install && \
  rm -rf /tmp/grpc &&\
  apk del .build-deps
