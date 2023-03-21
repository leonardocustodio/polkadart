# Polkadart

Provides a clean wrapper around all the methods exposed by a Polkadot/Substrate network client and defines all the types exposed by a node.

## Usage

```dart
import 'package:polkadart/polkadart.dart' show Provider, StateApi;

void main() async {
  final polkadot = Provider('wss://rpc.polkadot.io');
  final api = StateApi(polkadot);
  final runtimeVersion = await api.getRuntimeVersion();
  print(runtimeVersion.toJson());
  await polkadot.disconnect();
}
```

## Tutorials

Looking for tutorials to get started? Look at [example](./example) for guides on how to use the API to make queries and submit transactions.
