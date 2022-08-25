import 'package:ss58_codec/ss58_codec.dart';

void main() {
  // polkadot address
  final Address decodedAddress =
      SS58Codec.decode('1zugcag7cJVBtVRnFxv5Qftn7xKAnR6YJ9x4x3XLgGgmNnS');
  print(decodedAddress);
}
