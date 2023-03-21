import 'package:polkadart/polkadart.dart' show Provider, StateApi;

void main() async {
  final polkadart = Provider(Uri.parse('wss://kusama-rpc.polkadot.io'));
  final api = StateApi(polkadart);
  final runtimeVersion = await api.getRuntimeVersion();
  print(runtimeVersion.toJson());
  await polkadart.disconnect();
}
