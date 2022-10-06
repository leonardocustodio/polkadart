// ignore_for_file: unused_local_variable

import 'package:ss58/ss58.dart';

void main() {
  // get registry info of given `network`
  final kusamaRegistry = Codec.registry.getByNetwork('kusama');

  // get registry info of given `prefix`
  final polkadotRegistry = Codec.registry.getByPrefix(0);

  // decoding substrate address
  final String originalEncodedAddress =
      '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
  final List<int> decodedBytes =
      Codec.fromNetwork('substrate').decode(originalEncodedAddress);

  // Encoding the decodedBytes to produce back encodedAddress.
  final int substrateAddressPrefix = 42;
  final encodedAddress = Codec(substrateAddressPrefix).encode(decodedBytes);
}
