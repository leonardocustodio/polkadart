import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final input = Input.fromHex(
      '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
  final decoded = I256Codec.codec.decode(input);
  print(
      decoded); // BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819967')

  final output = HexOutput();
  I256Codec.codec.encodeTo(decoded, output);
  print(output
      .toString()); // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f
}
