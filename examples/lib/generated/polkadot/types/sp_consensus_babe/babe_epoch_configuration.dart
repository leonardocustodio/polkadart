// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../tuples.dart' as _i2;
import 'allowed_slots.dart' as _i3;

class BabeEpochConfiguration {
  const BabeEpochConfiguration({
    required this.c,
    required this.allowedSlots,
  });

  factory BabeEpochConfiguration.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// (u64, u64)
  final _i2.Tuple2<BigInt, BigInt> c;

  /// AllowedSlots
  final _i3.AllowedSlots allowedSlots;

  static const $BabeEpochConfigurationCodec codec =
      $BabeEpochConfigurationCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'c': [
          c.value0,
          c.value1,
        ],
        'allowedSlots': allowedSlots.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BabeEpochConfiguration &&
          other.c == c &&
          other.allowedSlots == allowedSlots;

  @override
  int get hashCode => Object.hash(
        c,
        allowedSlots,
      );
}

class $BabeEpochConfigurationCodec with _i1.Codec<BabeEpochConfiguration> {
  const $BabeEpochConfigurationCodec();

  @override
  void encodeTo(
    BabeEpochConfiguration obj,
    _i1.Output output,
  ) {
    const _i2.Tuple2Codec<BigInt, BigInt>(
      _i1.U64Codec.codec,
      _i1.U64Codec.codec,
    ).encodeTo(
      obj.c,
      output,
    );
    _i3.AllowedSlots.codec.encodeTo(
      obj.allowedSlots,
      output,
    );
  }

  @override
  BabeEpochConfiguration decode(_i1.Input input) {
    return BabeEpochConfiguration(
      c: const _i2.Tuple2Codec<BigInt, BigInt>(
        _i1.U64Codec.codec,
        _i1.U64Codec.codec,
      ).decode(input),
      allowedSlots: _i3.AllowedSlots.codec.decode(input),
    );
  }

  @override
  int sizeHint(BabeEpochConfiguration obj) {
    int size = 0;
    size = size +
        const _i2.Tuple2Codec<BigInt, BigInt>(
          _i1.U64Codec.codec,
          _i1.U64Codec.codec,
        ).sizeHint(obj.c);
    size = size + _i3.AllowedSlots.codec.sizeHint(obj.allowedSlots);
    return size;
  }
}
