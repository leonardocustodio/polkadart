import 'dart:typed_data';

import 'package:ss58_codec/ss58_codec.dart';

void main() {
  // Decoding a Polkadot Address Object
  Address address =
      SS58Codec.decode('1zugcag7cJVBtVRnFxv5Qftn7xKAnR6YJ9x4x3XLgGgmNnS');
  print('Address: $address');

  // Encoding previous Address object
  String encodedAddress = SS58Codec.encode(address);
  print('Encoded address: $encodedAddress');

  // Encoding with a custom prefix
  Address customAddress =
      Address(prefix: 0, bytes: Uint8List.fromList([1, 2, 3, 4]));
  String encodedCustomAddress = SS58Codec.encode(customAddress);
  print('Custom address encoded: $encodedCustomAddress');
}
