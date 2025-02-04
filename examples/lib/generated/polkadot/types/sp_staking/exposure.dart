// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import 'individual_exposure.dart' as _i2;

class Exposure {
  const Exposure({
    required this.total,
    required this.own,
    required this.others,
  });

  factory Exposure.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt total;

  /// Balance
  final BigInt own;

  /// Vec<IndividualExposure<AccountId, Balance>>
  final List<_i2.IndividualExposure> others;

  static const $ExposureCodec codec = $ExposureCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'own': own,
        'others': others.map((value) => value.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Exposure &&
          other.total == total &&
          other.own == own &&
          _i4.listsEqual(
            other.others,
            others,
          );

  @override
  int get hashCode => Object.hash(
        total,
        own,
        others,
      );
}

class $ExposureCodec with _i1.Codec<Exposure> {
  const $ExposureCodec();

  @override
  void encodeTo(
    Exposure obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.total,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.own,
      output,
    );
    const _i1.SequenceCodec<_i2.IndividualExposure>(
            _i2.IndividualExposure.codec)
        .encodeTo(
      obj.others,
      output,
    );
  }

  @override
  Exposure decode(_i1.Input input) {
    return Exposure(
      total: _i1.CompactBigIntCodec.codec.decode(input),
      own: _i1.CompactBigIntCodec.codec.decode(input),
      others: const _i1.SequenceCodec<_i2.IndividualExposure>(
              _i2.IndividualExposure.codec)
          .decode(input),
    );
  }

  @override
  int sizeHint(Exposure obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.total);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.own);
    size = size +
        const _i1.SequenceCodec<_i2.IndividualExposure>(
                _i2.IndividualExposure.codec)
            .sizeHint(obj.others);
    return size;
  }
}
