// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'curve.dart' as _i2;

class TrackInfo {
  const TrackInfo({
    required this.name,
    required this.maxDeciding,
    required this.decisionDeposit,
    required this.preparePeriod,
    required this.decisionPeriod,
    required this.confirmPeriod,
    required this.minEnactmentPeriod,
    required this.minApproval,
    required this.minSupport,
  });

  factory TrackInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// &'static str
  final String name;

  /// u32
  final int maxDeciding;

  /// Balance
  final BigInt decisionDeposit;

  /// Moment
  final int preparePeriod;

  /// Moment
  final int decisionPeriod;

  /// Moment
  final int confirmPeriod;

  /// Moment
  final int minEnactmentPeriod;

  /// Curve
  final _i2.Curve minApproval;

  /// Curve
  final _i2.Curve minSupport;

  static const $TrackInfoCodec codec = $TrackInfoCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'maxDeciding': maxDeciding,
        'decisionDeposit': decisionDeposit,
        'preparePeriod': preparePeriod,
        'decisionPeriod': decisionPeriod,
        'confirmPeriod': confirmPeriod,
        'minEnactmentPeriod': minEnactmentPeriod,
        'minApproval': minApproval.toJson(),
        'minSupport': minSupport.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TrackInfo &&
          other.name == name &&
          other.maxDeciding == maxDeciding &&
          other.decisionDeposit == decisionDeposit &&
          other.preparePeriod == preparePeriod &&
          other.decisionPeriod == decisionPeriod &&
          other.confirmPeriod == confirmPeriod &&
          other.minEnactmentPeriod == minEnactmentPeriod &&
          other.minApproval == minApproval &&
          other.minSupport == minSupport;

  @override
  int get hashCode => Object.hash(
        name,
        maxDeciding,
        decisionDeposit,
        preparePeriod,
        decisionPeriod,
        confirmPeriod,
        minEnactmentPeriod,
        minApproval,
        minSupport,
      );
}

class $TrackInfoCodec with _i1.Codec<TrackInfo> {
  const $TrackInfoCodec();

  @override
  void encodeTo(
    TrackInfo obj,
    _i1.Output output,
  ) {
    _i1.StrCodec.codec.encodeTo(
      obj.name,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxDeciding,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.decisionDeposit,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.preparePeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.decisionPeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.confirmPeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.minEnactmentPeriod,
      output,
    );
    _i2.Curve.codec.encodeTo(
      obj.minApproval,
      output,
    );
    _i2.Curve.codec.encodeTo(
      obj.minSupport,
      output,
    );
  }

  @override
  TrackInfo decode(_i1.Input input) {
    return TrackInfo(
      name: _i1.StrCodec.codec.decode(input),
      maxDeciding: _i1.U32Codec.codec.decode(input),
      decisionDeposit: _i1.U128Codec.codec.decode(input),
      preparePeriod: _i1.U32Codec.codec.decode(input),
      decisionPeriod: _i1.U32Codec.codec.decode(input),
      confirmPeriod: _i1.U32Codec.codec.decode(input),
      minEnactmentPeriod: _i1.U32Codec.codec.decode(input),
      minApproval: _i2.Curve.codec.decode(input),
      minSupport: _i2.Curve.codec.decode(input),
    );
  }

  @override
  int sizeHint(TrackInfo obj) {
    int size = 0;
    size = size + _i1.StrCodec.codec.sizeHint(obj.name);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxDeciding);
    size = size + _i1.U128Codec.codec.sizeHint(obj.decisionDeposit);
    size = size + _i1.U32Codec.codec.sizeHint(obj.preparePeriod);
    size = size + _i1.U32Codec.codec.sizeHint(obj.decisionPeriod);
    size = size + _i1.U32Codec.codec.sizeHint(obj.confirmPeriod);
    size = size + _i1.U32Codec.codec.sizeHint(obj.minEnactmentPeriod);
    size = size + _i2.Curve.codec.sizeHint(obj.minApproval);
    size = size + _i2.Curve.codec.sizeHint(obj.minSupport);
    return size;
  }
}
