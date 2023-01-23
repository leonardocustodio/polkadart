part of codec_types;

///
/// Dummy Uint class to be extended by all Uint classes
class Uint<T> extends Codec<T> {
  Uint._() : super(registry: Registry());
}
