import 'package:substrate_metadata/core/chain.dart';

void main() {
  //
  // Initiate chain constructor with chain specific types-definition
  final chain = Chain();

  //
  // Populating with the metadata for block-numbers available for this chain....
  chain.initSpecVersionFromFile('../../chain/polkadot/versions.jsonl');
}
