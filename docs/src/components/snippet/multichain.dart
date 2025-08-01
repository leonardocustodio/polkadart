import 'package:polkadart/provider.dart';
import './generated/assethub/assethub.dart';
import './generated/people/people.dart';
import './generated/polkadot/polkadot.dart';

Future<void> main(List<String> arguments) async {
  final polkadot =
      Polkadot(Provider.fromUri(Uri.parse('wss://rpc.polkadot.io')));
  final people = People(
      Provider.fromUri(Uri.parse('wss://polkadot-people-rpc.polkadot.io')));
  final assetHub = Assethub(
      Provider.fromUri(Uri.parse('wss://polkadot-asset-hub-rpc.polkadot.io')));

  print('${await polkadot.query.session.validators()}');
  print('${await people.query.identity.registrars()}');
  print('${await assetHub.query.assets.nextAssetId()}');
}
