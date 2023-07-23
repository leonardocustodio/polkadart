## Polkadart CLI

Dart package that generates Dart types and definitions from the chain metadata.

## Usage

Follow these steps to get started:

### Configure package

Add package configuration to your `pubspec.yaml` file. Here is a full configuration for the package:

<pre>
polkadart:
  output_dir: lib/generated # Optional. Sets the directory of generated files. Provided value should be a valid path on your system. Default: lib/generated
  <b>chains:</b> # Dictionary of chains and endpoints
      polkadot: wss://rpc.polkadot.io
      kusama: wss://kusama-rpc.polkadot.io
</pre>

### Run command

To generate boilerplate code for substrate node, run the `generate` program inside directory where your `pubspec.yaml` file is located:

    dart pub run polkadart_cli:generate -v

This will produce files inside `lib/generated` directory.
You can also change the output folder from `lib/generated` to a custom directory by adding the `output_dir` line in your `pubspec.yaml` file.
