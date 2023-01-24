part of codec_types;

///
/// Dummy Uint class to be extended by all Uint classes
class Uint<T> extends Codec<T> {
  Uint._() : super(registry: Registry());

  ///
  /// [static] Create a new instance of Uint
  @override
  Uint copyWith(Codec codec) {
    return copyProperties(codec, Uint._()) as Uint;
  }
}
