FROM docker-alpine-grpc AS build-env

RUN apk add --no-cache build-base
ADD . /src
WORKDIR /src
RUN make

FROM alpine

RUN apk add --no-cache libstdc++
COPY --from=build-env /src/greeter_server /src/greeter_client /usr/bin/
COPY --from=build-env /usr/local/lib /usr/local/lib/