// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum OriginKind {
  native('Native', 0),
  sovereignAccount('SovereignAccount', 1),
  superuser('Superuser', 2),
  xcm('Xcm', 3);

  const OriginKind(
    this.variantName,
    this.codecIndex,
  );

  factory OriginKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $OriginKindCodec codec = $OriginKindCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $OriginKindCodec with _i1.Codec<OriginKind> {
  const $OriginKindCodec();

  @override
  OriginKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return OriginKind.native;
      case 1:
        return OriginKind.sovereignAccount;
      case 2:
        return OriginKind.superuser;
      case 3:
        return OriginKind.xcm;
      default:
        throw Exception('OriginKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    OriginKind value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
