part of ink_abi;

typedef SelectorsMap = Map<String, int>;

class SelectorByteInput extends ByteInput {
  int? index;
  SelectorByteInput._(final Uint8List buffer) : super(buffer);

  static SelectorByteInput fromHex(
      final String hex, final SelectorsMap selectors) {
    final Uint8List buffer = decodeHex(hex);
    final String key = encodeHex(buffer.sublist(0, 4));
    final int? index = selectors['0x$key'];
    if (index == null) {
      throw Exception('Unknown selector: $key');
    }
    final SelectorByteInput selectorByteInput =
        SelectorByteInput._(buffer.sublist(4));
    selectorByteInput.index = index;
    return selectorByteInput;
  }

  @override
  int read() {
    if (index == null) {
      return super.read();
    } else {
      final int idx = index!;
      index = null;
      return idx;
    }
  }
}
