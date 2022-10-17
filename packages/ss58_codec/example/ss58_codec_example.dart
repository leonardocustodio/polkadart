import 'package:ss58_codec/ss58_codec.dart';

void main() {
  // Decoding a Polkadot Address Object
  Address address =
      SS58Codec.decode('1zugcag7cJVBtVRnFxv5Qftn7xKAnR6YJ9x4x3XLgGgmNnS');
  print('Address: $address');

  // Encoding an Address Object
  String encodedAddress = SS58Codec.encode(address);
  print('Encoded address: $encodedAddress');
}
