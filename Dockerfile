FROM alpine:latest

ARG GRPC_VERSION=v1.14.x

# Install dependencies
RUN apk add --no-cache libstdc++ && \
  apk add --no-cache --virtual .build-deps git build-base autoconf automake libtool curl make unzip

# Clone repositories
WORKDIR /tmp
RUN git clone -b $GRPC_VERSION https://github.com/grpc/grpc

# Build gRPC
WORKDIR /tmp/grpc
RUN git submodule update --init && \
  make && \
  make install && \
  ln -sf /usr/local/lib/libgrpc++.so /usr/local/lib/libgrpc++.so.1 && \
  ln -sf /usr/local/lib/libgrpc++_reflection.so /usr/local/lib/libgrpc++_reflection.so.1

# Build protobuf
ENV protobuf_BUILD_TESTS=OFF
WORKDIR /tmp/grpc/third_party/protobuf
RUN make && \
  make install

# Remove dependencies
RUN rm -rf /tmp/grpc && \
  apk del .build-deps

WORKDIR /
