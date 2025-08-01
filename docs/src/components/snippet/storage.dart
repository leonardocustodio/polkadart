import 'package:demo/generated/polkadot/polkadot.dart';
import 'package:polkadart/polkadart.dart' show Provider;

Future<void> main(List<String> arguments) async {
  final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
  final polkadot = Polkadot(provider);
  final runtime = await polkadot.rpc.state.getRuntimeVersion();

  print(runtime.toJson());
}
