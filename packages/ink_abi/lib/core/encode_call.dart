part of ink_abi;

Uint8List encodeCall(final Uint8List address, final Uint8List input,
    final Uint8List contractAddress) {
  final ByteOutput output = ByteOutput();
  // origin
  output.write(address);
  // dest
  output.write(contractAddress);
  // balance
  U128Codec.codec.encodeTo(BigInt.zero, output);
  // optional gas-limit
  U8Codec.codec.encodeTo(0, output);
  // optional storage - deposit - limit
  U8Codec.codec.encodeTo(0, output);
  // msg selector + arguments
  CompactCodec.codec.encodeTo(input.length, output);
  output.write(input);
  return output.toBytes();
}
