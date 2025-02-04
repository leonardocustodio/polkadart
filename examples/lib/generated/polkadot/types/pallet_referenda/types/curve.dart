// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_arithmetic/fixed_point/fixed_i64.dart' as _i4;
import '../../sp_arithmetic/per_things/perbill.dart' as _i3;

abstract class Curve {
  const Curve();

  factory Curve.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CurveCodec codec = $CurveCodec();

  static const $Curve values = $Curve();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Curve {
  const $Curve();

  LinearDecreasing linearDecreasing({
    required _i3.Perbill length,
    required _i3.Perbill floor,
    required _i3.Perbill ceil,
  }) {
    return LinearDecreasing(
      length: length,
      floor: floor,
      ceil: ceil,
    );
  }

  SteppedDecreasing steppedDecreasing({
    required _i3.Perbill begin,
    required _i3.Perbill end,
    required _i3.Perbill step,
    required _i3.Perbill period,
  }) {
    return SteppedDecreasing(
      begin: begin,
      end: end,
      step: step,
      period: period,
    );
  }

  Reciprocal reciprocal({
    required _i4.FixedI64 factor,
    required _i4.FixedI64 xOffset,
    required _i4.FixedI64 yOffset,
  }) {
    return Reciprocal(
      factor: factor,
      xOffset: xOffset,
      yOffset: yOffset,
    );
  }
}

class $CurveCodec with _i1.Codec<Curve> {
  const $CurveCodec();

  @override
  Curve decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return LinearDecreasing._decode(input);
      case 1:
        return SteppedDecreasing._decode(input);
      case 2:
        return Reciprocal._decode(input);
      default:
        throw Exception('Curve: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Curve value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case LinearDecreasing:
        (value as LinearDecreasing).encodeTo(output);
        break;
      case SteppedDecreasing:
        (value as SteppedDecreasing).encodeTo(output);
        break;
      case Reciprocal:
        (value as Reciprocal).encodeTo(output);
        break;
      default:
        throw Exception(
            'Curve: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Curve value) {
    switch (value.runtimeType) {
      case LinearDecreasing:
        return (value as LinearDecreasing)._sizeHint();
      case SteppedDecreasing:
        return (value as SteppedDecreasing)._sizeHint();
      case Reciprocal:
        return (value as Reciprocal)._sizeHint();
      default:
        throw Exception(
            'Curve: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class LinearDecreasing extends Curve {
  const LinearDecreasing({
    required this.length,
    required this.floor,
    required this.ceil,
  });

  factory LinearDecreasing._decode(_i1.Input input) {
    return LinearDecreasing(
      length: _i1.U32Codec.codec.decode(input),
      floor: _i1.U32Codec.codec.decode(input),
      ceil: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Perbill
  final _i3.Perbill length;

  /// Perbill
  final _i3.Perbill floor;

  /// Perbill
  final _i3.Perbill ceil;

  @override
  Map<String, Map<String, int>> toJson() => {
        'LinearDecreasing': {
          'length': length,
          'floor': floor,
          'ceil': ceil,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.PerbillCodec().sizeHint(length);
    size = size + const _i3.PerbillCodec().sizeHint(floor);
    size = size + const _i3.PerbillCodec().sizeHint(ceil);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      length,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      floor,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      ceil,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LinearDecreasing &&
          other.length == length &&
          other.floor == floor &&
          other.ceil == ceil;

  @override
  int get hashCode => Object.hash(
        length,
        floor,
        ceil,
      );
}

class SteppedDecreasing extends Curve {
  const SteppedDecreasing({
    required this.begin,
    required this.end,
    required this.step,
    required this.period,
  });

  factory SteppedDecreasing._decode(_i1.Input input) {
    return SteppedDecreasing(
      begin: _i1.U32Codec.codec.decode(input),
      end: _i1.U32Codec.codec.decode(input),
      step: _i1.U32Codec.codec.decode(input),
      period: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Perbill
  final _i3.Perbill begin;

  /// Perbill
  final _i3.Perbill end;

  /// Perbill
  final _i3.Perbill step;

  /// Perbill
  final _i3.Perbill period;

  @override
  Map<String, Map<String, int>> toJson() => {
        'SteppedDecreasing': {
          'begin': begin,
          'end': end,
          'step': step,
          'period': period,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.PerbillCodec().sizeHint(begin);
    size = size + const _i3.PerbillCodec().sizeHint(end);
    size = size + const _i3.PerbillCodec().sizeHint(step);
    size = size + const _i3.PerbillCodec().sizeHint(period);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      begin,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      end,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      step,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      period,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SteppedDecreasing &&
          other.begin == begin &&
          other.end == end &&
          other.step == step &&
          other.period == period;

  @override
  int get hashCode => Object.hash(
        begin,
        end,
        step,
        period,
      );
}

class Reciprocal extends Curve {
  const Reciprocal({
    required this.factor,
    required this.xOffset,
    required this.yOffset,
  });

  factory Reciprocal._decode(_i1.Input input) {
    return Reciprocal(
      factor: _i1.I64Codec.codec.decode(input),
      xOffset: _i1.I64Codec.codec.decode(input),
      yOffset: _i1.I64Codec.codec.decode(input),
    );
  }

  /// FixedI64
  final _i4.FixedI64 factor;

  /// FixedI64
  final _i4.FixedI64 xOffset;

  /// FixedI64
  final _i4.FixedI64 yOffset;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Reciprocal': {
          'factor': factor,
          'xOffset': xOffset,
          'yOffset': yOffset,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.FixedI64Codec().sizeHint(factor);
    size = size + const _i4.FixedI64Codec().sizeHint(xOffset);
    size = size + const _i4.FixedI64Codec().sizeHint(yOffset);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.I64Codec.codec.encodeTo(
      factor,
      output,
    );
    _i1.I64Codec.codec.encodeTo(
      xOffset,
      output,
    );
    _i1.I64Codec.codec.encodeTo(
      yOffset,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Reciprocal &&
          other.factor == factor &&
          other.xOffset == xOffset &&
          other.yOffset == yOffset;

  @override
  int get hashCode => Object.hash(
        factor,
        xOffset,
        yOffset,
      );
}
