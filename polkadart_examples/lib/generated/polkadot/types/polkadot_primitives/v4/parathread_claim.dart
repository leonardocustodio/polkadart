// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_parachain/primitives/id.dart' as _i2;
import 'collator_app/public.dart' as _i3;

class ParathreadClaim {
  const ParathreadClaim(
    this.value0,
    this.value1,
  );

  factory ParathreadClaim.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Id
  final _i2.Id value0;

  /// CollatorId
  final _i3.Public value1;

  static const $ParathreadClaimCodec codec = $ParathreadClaimCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  List<dynamic> toJson() => [
        value0,
        value1.toList(),
      ];

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ParathreadClaim &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class $ParathreadClaimCodec with _i1.Codec<ParathreadClaim> {
  const $ParathreadClaimCodec();

  @override
  void encodeTo(
    ParathreadClaim obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.value0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.value1,
      output,
    );
  }

  @override
  ParathreadClaim decode(_i1.Input input) {
    return ParathreadClaim(
      _i1.U32Codec.codec.decode(input),
      const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(ParathreadClaim obj) {
    int size = 0;
    size = size + const _i2.IdCodec().sizeHint(obj.value0);
    size = size + const _i3.PublicCodec().sizeHint(obj.value1);
    return size;
  }
}
