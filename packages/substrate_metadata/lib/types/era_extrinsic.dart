part of metadata_types;

class EraExtrinsic with Codec<Map<String, int>> {
  const EraExtrinsic._();

  static const EraExtrinsic instance = EraExtrinsic._();

  @override
  Map<String, int> decode(Input input) {
    final isDataContained = input.read();

    if (isDataContained == 0) {
      return <String, int>{};
    }

    final int encoded = isDataContained + (input.read() << 8);

    final int period = 2 << (encoded % (1 << 4));
    final int phase = ((encoded >> 4) * max(period >> 12, 1)) as int;

    return <String, int>{
      'period': period,
      'phase': phase,
    };
  }

  @override
  void encodeTo(Map<String, int> value, Output output) {
    throw UnimplementedError();
  }
}
