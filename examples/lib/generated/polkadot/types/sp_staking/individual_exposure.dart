// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../sp_core/crypto/account_id32.dart' as _i2;

class IndividualExposure {
  const IndividualExposure({
    required this.who,
    required this.value,
  });

  factory IndividualExposure.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 who;

  /// Balance
  final BigInt value;

  static const $IndividualExposureCodec codec = $IndividualExposureCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'who': who.toList(),
        'value': value,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is IndividualExposure &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.value == value;

  @override
  int get hashCode => Object.hash(
        who,
        value,
      );
}

class $IndividualExposureCodec with _i1.Codec<IndividualExposure> {
  const $IndividualExposureCodec();

  @override
  void encodeTo(
    IndividualExposure obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.who,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.value,
      output,
    );
  }

  @override
  IndividualExposure decode(_i1.Input input) {
    return IndividualExposure(
      who: const _i1.U8ArrayCodec(32).decode(input),
      value: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(IndividualExposure obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.who);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.value);
    return size;
  }
}
