part of metadata_types;

class EventCodec with Codec<List<Map<String, dynamic>>> {
  final ChainInfo chainInfo;

  const EventCodec({required this.chainInfo});

  @override
  List<Map<String, dynamic>> decode(Input input) {
    final result =
        SequenceCodec(EventRecord(chainInfo: chainInfo)).decode(input);
    return result;
  }

  @override
  void encodeTo(List<Map<String, dynamic>> value, Output output) {
    SequenceCodec(EventRecord(chainInfo: chainInfo)).encodeTo(value, output);
  }
}
