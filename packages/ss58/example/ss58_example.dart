import 'package:ss58/ss58.dart';

void main() {
  final String originalEncodedAddress =
      '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';

  // Decoding the address to produce bytes
  final List<int> decodedBytes = Codec(42).decode(originalEncodedAddress);

  // Encoding the decodedBytes to produce back encodedAddress.
  final encodedAddress = Codec(42).encode(decodedBytes);

  if (encodedAddress == originalEncodedAddress) {
    print('decoded bytes: $decodedBytes');
    print('original address: $encodedAddress');
    print('encoded address:  $encodedAddress');
    print('decoding and encoding back and forth is awesome');
  } else {
    throw Exception('Something went wrong');
  }
}
