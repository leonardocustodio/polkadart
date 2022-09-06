import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ss58_codec/ss58_codec.dart';

void main() {
  // Decoding an Polkadot Address Object
  Address decodedAddress =
      SS58Codec.decode('1zugcag7cJVBtVRnFxv5Qftn7xKAnR6YJ9x4x3XLgGgmNnS');
  print('Decoding Polkadot Address');
  print('$decodedAddress\n');

  // Encoding an Address Object
  Address addressObject = Address(
      prefix: 42,
      bytes: Uint8List.fromList(hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d')));
  String encodedAddress = SS58Codec.encode(addressObject);

  // expected: 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY
  print('Encode Address Object: $encodedAddress');
}
