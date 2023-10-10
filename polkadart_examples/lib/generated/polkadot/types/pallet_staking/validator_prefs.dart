// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class ValidatorPrefs {
  const ValidatorPrefs({
    required this.commission,
    required this.blocked,
  });

  factory ValidatorPrefs.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Perbill
  final BigInt commission;

  /// bool
  final bool blocked;

  static const $ValidatorPrefsCodec codec = $ValidatorPrefsCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'commission': commission,
        'blocked': blocked,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ValidatorPrefs &&
          other.commission == commission &&
          other.blocked == blocked;

  @override
  int get hashCode => Object.hash(
        commission,
        blocked,
      );
}

class $ValidatorPrefsCodec with _i1.Codec<ValidatorPrefs> {
  const $ValidatorPrefsCodec();

  @override
  void encodeTo(
    ValidatorPrefs obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.commission,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.blocked,
      output,
    );
  }

  @override
  ValidatorPrefs decode(_i1.Input input) {
    return ValidatorPrefs(
      commission: _i1.CompactBigIntCodec.codec.decode(input),
      blocked: _i1.BoolCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ValidatorPrefs obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.commission);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.blocked);
    return size;
  }
}
