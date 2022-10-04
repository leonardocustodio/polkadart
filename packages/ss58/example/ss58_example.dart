import 'package:ss58/ss58.dart';

void main() {
  // get registry info of given `network`
  final kusamaRegistry = Codec.registry.getByNetwork('kusama');
  print('kusama registry: $kusamaRegistry');

  // get registry info of given `prefix`
  final polkadotRegistry = Codec.registry.getByPrefix(0);
  print('polkadot registry: $polkadotRegistry');

  // decoding substrate address
  final String originalEncodedAddress =
      '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
  final List<int> decodedBytes =
      Codec.fromNetwork('substrate').decode(originalEncodedAddress);
  print('Substrate address bytes: $decodedBytes');

  // Encoding the decodedBytes to produce back encodedAddress.
  final int substrateAddressPrefix = 42;
  final encodedAddress = Codec(substrateAddressPrefix).encode(decodedBytes);
  print(encodedAddress);
}
