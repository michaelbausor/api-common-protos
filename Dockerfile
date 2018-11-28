FROM alpine:3.8

# Install curl and unzip, which are required to add protoc.
RUN apk add --no-cache curl unzip

# Add protoc.
ENV PROTOBUF_VERSION 3.6.1
RUN mkdir -p /usr/src/protoc/ \
    && curl --location https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip > /usr/src/protoc/protoc-${PROTOBUF_VERSION}.zip \
    && cd /usr/src/protoc/ \
    && unzip protoc-${PROTOBUF_VERSION}.zip \
    && rm protoc-${PROTOBUF_VERSION}.zip \
    && ln -s /usr/src/protoc/bin/protoc /usr/local/bin/protoc

# Add the protos to the Docker image.
ADD ./google /protos/google

# Add Bazel build data to the image.
ADD ./BUILD.bazel /protos/BUILD.bazel
ADD ./WORKSPACE /protos/WORKSPACE
