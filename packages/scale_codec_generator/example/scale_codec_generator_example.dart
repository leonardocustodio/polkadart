import 'package:frame_primitives/frame_primitives.dart' show Provider, StateApi;

void main() async {
  final polkadart = Provider('wss://kusama-rpc.polkadot.io');
  final api = StateApi(polkadart);
  final runtimeVersion = await api.getRuntimeVersion();
  print(runtimeVersion.toJson());
  await polkadart.disconnect();
}
