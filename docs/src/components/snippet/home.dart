import 'package:polkadart/polkadart.dart';

void main() async {
    final uri = Uri.parse('wss://rpc.polkadot.io');
    final provider = Provider.fromUri(uri);

    final stateApi = StateApi(provider);
    final runtimeVersion = await stateApi.getRuntimeVersion();

    print(runtimeVersion.toJson());
}