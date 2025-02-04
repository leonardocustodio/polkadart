// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import 'individual_exposure.dart' as _i2;

class ExposurePage {
  const ExposurePage({
    required this.pageTotal,
    required this.others,
  });

  factory ExposurePage.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt pageTotal;

  /// Vec<IndividualExposure<AccountId, Balance>>
  final List<_i2.IndividualExposure> others;

  static const $ExposurePageCodec codec = $ExposurePageCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'pageTotal': pageTotal,
        'others': others.map((value) => value.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExposurePage &&
          other.pageTotal == pageTotal &&
          _i4.listsEqual(
            other.others,
            others,
          );

  @override
  int get hashCode => Object.hash(
        pageTotal,
        others,
      );
}

class $ExposurePageCodec with _i1.Codec<ExposurePage> {
  const $ExposurePageCodec();

  @override
  void encodeTo(
    ExposurePage obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.pageTotal,
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
  ExposurePage decode(_i1.Input input) {
    return ExposurePage(
      pageTotal: _i1.CompactBigIntCodec.codec.decode(input),
      others: const _i1.SequenceCodec<_i2.IndividualExposure>(
              _i2.IndividualExposure.codec)
          .decode(input),
    );
  }

  @override
  int sizeHint(ExposurePage obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.pageTotal);
    size = size +
        const _i1.SequenceCodec<_i2.IndividualExposure>(
                _i2.IndividualExposure.codec)
            .sizeHint(obj.others);
    return size;
  }
}
