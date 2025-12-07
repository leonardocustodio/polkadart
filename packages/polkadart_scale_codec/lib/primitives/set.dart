part of primitives;

class SetCodec with Codec<List<String>> {
  final int bitLength;
  final List<String> values;

  const SetCodec(this.bitLength, this.values);

  @override
  List<String> decode(Input input) {
    assertion(bitLength % 8 == 0, 'bitLength should be multiple of 8.');
    assertion(bitLength > 0, 'bitLength should be greater than 0.');
    assertion(bitLength <= 256, 'bitLength should be less than 256.');

    final codec = PrimitivesEnum.fromString('U$bitLength');
    final setIndex = codec.decode(input);
    final value = <String>[];

    /// Simplify above code with dart's bit operation
    if (setIndex > 0) {
      for (var index = 0; index < values.length; index++) {
        final item = values[index];
        if ((setIndex & (1 << index)) > 0) {
          value.add(item);
        }
      }
    }

    return value;
  }

  @override
  void encodeTo(List<String> value, Output output) {
    assertion(bitLength % 2 == 0, 'bitLength should be multiple of 2.');
    assertion(bitLength > 0, 'bitLength should be greater than 0.');
    assertion(bitLength <= 256, 'bitLength should be less than 256.');

    final codec = PrimitivesEnum.fromString('U$bitLength');
    var setIndex = 0;
    for (var index = 0; index < values.length; index++) {
      final item = values[index];
      if (value.contains(item)) {
        setIndex += 1 << index;
      }
    }
    codec.encodeTo(setIndex, output);
  }

  @override
  bool isSizeZero() {
    // SetCodec always encodes to a fixed size UX integer based on bitLength
    return false;
  }
}
