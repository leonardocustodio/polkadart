import 'package:polkadart/apis/apis.dart';
import 'package:polkadart/polkadart.dart' show Provider, StateApi;

void main() async {
    final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
    final stateApi = StateApi(provider);
    final runtimeVersion = await stateApi.getRuntimeVersion();

    print(runtimeVersion.toJson());
}