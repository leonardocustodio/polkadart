import 'package:ss58/ss58.dart';
import 'package:test/test.dart';
import 'package:convert/convert.dart';

void main() {
  group('registry testing: -> ', () {
    // Creating a copy of registryObject so as to avoid repetative json decoding and json processing.
    final registryObject = registry;

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

  group('decode: ', () {
    test('decoded address produce ', () {
      final String address = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';

      // Decoding the address to produce desired bytes
      final List<int> decodedBytes = Codec(42).decode(address).toList();

      final List<int> expectedBytes = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');

      expect(decodedBytes, equals(expectedBytes));
    });
  });

  group('encode: ', () {
    test('encoded bytes produce correct address', () {
      final String address = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';

      final List<int> bytes = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');

      // encoding the bytes to produce exact address
      final encodedAddress = Codec(42).encode(bytes);

      expect(encodedAddress, equals(address));
    });
  });

  group('throw exception: ', () {
    test('on decode', () {
      // throw exception on decode
      expect(
          () => Codec(2)
              .decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY'),
          throwsException);
    });
  });
}
