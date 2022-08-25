import 'package:ss58/src/registry_item.dart';
import 'package:ss58/ss58.dart' as ss58;
import 'package:test/test.dart';

void main() {
  group('registry testing: -> ', () {
    // Creating a copy of registryObject so as to avoid repetative json decoding and json processing.
    final registryObject = ss58.registry;

    test('getByNetwork and getByPrefix', () {

      // check whether they are same from network name and prefix number
      expect(registryObject.getByNetwork('kusama'),
          equals(registryObject.getByPrefix(2)));

      
      // check whether the Registry Item object comes to be same are from network name and prefix number
      expect(
          registryObject.getByNetwork('kusama'),
          equals(RegistryItem.fromJson({
            "prefix": 2,
            "network": "kusama",
            "displayName": "Kusama Relay Chain",
            "symbols": ["KSM"],
            "decimals": [12],
            "standardAccount": "*25519",
            "website": "https://kusama.network"
          })));
      expect(() => registryObject.getByNetwork('polkadart'), throwsException);
      expect(() => registryObject.getByPrefix(500000), throwsException);
    });

    test('-> findByNetwork and findByPrefix', () {
      expect(registryObject.findByNetwork('kusama'),
          equals(registryObject.findByPrefix(2)));
      expect(
          registryObject.findByNetwork('kusama'),
          equals(RegistryItem.fromJson({
            "prefix": 2,
            "network": "kusama",
            "displayName": "Kusama Relay Chain",
            "symbols": ["KSM"],
            "decimals": [12],
            "standardAccount": "*25519",
            "website": "https://kusama.network"
          })));
      expect(registryObject.findByNetwork('polkadart'), equals(null));
      expect(registryObject.findByPrefix(500000), equals(null));
    });
  });
}
