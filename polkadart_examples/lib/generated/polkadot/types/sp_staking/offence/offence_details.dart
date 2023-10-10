// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../pallet_staking/exposure.dart' as _i4;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../tuples.dart' as _i2;

class OffenceDetails {
  const OffenceDetails({
    required this.offender,
    required this.reporters,
  });

  factory OffenceDetails.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Offender
  final _i2.Tuple2<_i3.AccountId32, _i4.Exposure> offender;

  /// Vec<Reporter>
  final List<_i3.AccountId32> reporters;

  static const $OffenceDetailsCodec codec = $OffenceDetailsCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<dynamic>> toJson() => {
        'offender': [
          offender.value0.toList(),
          offender.value1.toJson(),
        ],
        'reporters': reporters.map((value) => value.toList()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OffenceDetails &&
          other.offender == offender &&
          _i6.listsEqual(
            other.reporters,
            reporters,
          );

  @override
  int get hashCode => Object.hash(
        offender,
        reporters,
      );
}

class $OffenceDetailsCodec with _i1.Codec<OffenceDetails> {
  const $OffenceDetailsCodec();

  @override
  void encodeTo(
    OffenceDetails obj,
    _i1.Output output,
  ) {
    const _i2.Tuple2Codec<_i3.AccountId32, _i4.Exposure>(
      _i3.AccountId32Codec(),
      _i4.Exposure.codec,
    ).encodeTo(
      obj.offender,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      obj.reporters,
      output,
    );
  }

  @override
  OffenceDetails decode(_i1.Input input) {
    return OffenceDetails(
      offender: const _i2.Tuple2Codec<_i3.AccountId32, _i4.Exposure>(
        _i3.AccountId32Codec(),
        _i4.Exposure.codec,
      ).decode(input),
      reporters:
          const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
              .decode(input),
    );
  }

  @override
  int sizeHint(OffenceDetails obj) {
    int size = 0;
    size = size +
        const _i2.Tuple2Codec<_i3.AccountId32, _i4.Exposure>(
          _i3.AccountId32Codec(),
          _i4.Exposure.codec,
        ).sizeHint(obj.offender);
    size = size +
        const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(obj.reporters);
    return size;
  }
}
