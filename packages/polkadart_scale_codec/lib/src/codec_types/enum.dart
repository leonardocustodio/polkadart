part of codec_types;

///
/// Enum to encode/decode map/list of values
class Enum extends Codec<dynamic> {
  ///
  /// conEnumor
  Enum._() : super(registry: Registry());

  ///
  /// [static] returns a new instance of Enum
  @override
  Enum freshInstance() => Enum._();

  ///
  /// Decodes the value from the Codec's input
  @override
  dynamic decode(Input input) {
    return '';
  }

  ///
  /// Encodes Enum of value
  @override
  void encode(Encoder encoder, dynamic value) {}
}
