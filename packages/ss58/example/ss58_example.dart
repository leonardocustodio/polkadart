// ignore_for_file: unused_local_variable
import 'dart:typed_data' show Uint8List;
import 'package:ss58/ss58.dart' show Address, Codec;

void main() {
  // Decoding a Polkadot Address Object
  Address address = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
  print('Address: $address');

  // Encoding previous Address object
  print('Encoded address: ${address.encode()}');

  // Encoding with a custom prefix
  Address customAddress = Address(prefix: 0, pubkey: Uint8List.fromList([1, 2, 3, 4]));
  print('Custom address encoded: ${customAddress.encode()}');

  // get registry info of given `network`
  final kusamaRegistry = Codec.registry.getByNetwork('kusama');

  // get registry info of given `prefix`
  final polkadotRegistry = Codec.registry.getByPrefix(0);

  // decoding substrate address
  final String originalEncodedAddress = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
  final List<int> decodedBytes = Codec.fromNetwork('substrate').decode(originalEncodedAddress);

  // Encoding the decodedBytes to produce back encodedAddress.
  final int substrateAddressPrefix = 42;
  final encodedAddress = Codec(substrateAddressPrefix).encode(decodedBytes);
}
