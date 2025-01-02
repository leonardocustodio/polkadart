part of ink_abi;

Uint8List decodeResult(final Uint8List result) {
  final ByteInput input = ByteInput(result);
  // gas consumed
  CompactCodec.codec.decode(input);
  CompactCodec.codec.decode(input);
  // gas required
  CompactCodec.codec.decode(input);
  CompactCodec.codec.decode(input);
  // storage deposit
  U8Codec.codec.decode(input);
  U128Codec.codec.decode(input);
  // debug message
  StrCodec.codec.decode(input);
  // result
  U8Codec.codec.decode(input);
  // Flags
  U32Codec.codec.decode(input);
  // data length
  final int len = CompactCodec.codec.decode(input);
  return input.readBytes(len);
}
