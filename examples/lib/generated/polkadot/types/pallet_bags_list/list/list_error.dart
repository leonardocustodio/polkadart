// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum ListError {
  duplicate('Duplicate', 0),
  notHeavier('NotHeavier', 1),
  notInSameBag('NotInSameBag', 2),
  nodeNotFound('NodeNotFound', 3);

  const ListError(
    this.variantName,
    this.codecIndex,
  );

  factory ListError.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ListErrorCodec codec = $ListErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ListErrorCodec with _i1.Codec<ListError> {
  const $ListErrorCodec();

  @override
  ListError decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ListError.duplicate;
      case 1:
        return ListError.notHeavier;
      case 2:
        return ListError.notInSameBag;
      case 3:
        return ListError.nodeNotFound;
      default:
        throw Exception('ListError: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ListError value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
