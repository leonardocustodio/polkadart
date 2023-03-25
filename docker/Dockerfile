FROM dart:stable-sdk

RUN apt-get update
RUN apt-get clean
RUN apt-get install -y curl git wget unzip libglu1-mesa git-lfs
RUN dart pub global activate melos

COPY . .

RUN git lfs fetch
RUN git lfs checkout

ENV PATH="$PATH":"/root/.pub-cache/bin"

CMD ["melos", "test"]
