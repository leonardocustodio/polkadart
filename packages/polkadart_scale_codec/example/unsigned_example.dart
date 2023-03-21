import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final input = Input.fromHex(
      '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
  final decoded = U256Codec.codec.decode(input);
  print(
      decoded); //  BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935')

  final output = HexOutput();
  U256Codec.codec.encodeTo(decoded, output);
  print(output
      .toString()); // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
}
