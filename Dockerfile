FROM dart:stable

RUN apt-get update
RUN apt-get clean
RUN apt-get install -y curl git wget unzip libglu1-mesa

RUN dart pub global activate melos

COPY . .

ENV PATH="$PATH":"/root/.pub-cache/bin"

RUN melos fetch_dependencies
RUN melos test
