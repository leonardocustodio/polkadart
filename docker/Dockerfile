FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y curl git wget unzip libglu1-mesa
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor
RUN flutter channel stable
RUN flutter upgrade

RUN mkdir /app/
COPY .. /app/

WORKDIR /app/
ENTRYPOINT [ "./run_tests.sh"]
