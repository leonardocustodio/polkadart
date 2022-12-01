FROM ubuntu:bionic@sha256:eb1392bbdde63147bc2b4ff1a4053dcfe6d15e4dfd3cce29e9b9f52a4f88bc74

RUN apt-get update
RUN apt-get install -y curl git wget unzip libglu1-mesa git-lfs
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor
RUN flutter channel stable
RUN flutter upgrade

RUN mkdir /app/
COPY .. /app/

WORKDIR /app/
RUN git lfs fetch
RUN git lfs checkout

WORKDIR /app/docker/polkadart_example
CMD ["dart", "test"]
