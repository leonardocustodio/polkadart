// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_weights/weight_v2/weight.dart' as _i3;

abstract class WeightLimit {
  const WeightLimit();

  factory WeightLimit.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $WeightLimitCodec codec = $WeightLimitCodec();

  static const $WeightLimit values = $WeightLimit();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $WeightLimit {
  const $WeightLimit();

  Unlimited unlimited() {
    return Unlimited();
  }

  Limited limited(_i3.Weight value0) {
    return Limited(value0);
  }
}

class $WeightLimitCodec with _i1.Codec<WeightLimit> {
  const $WeightLimitCodec();

  @override
  WeightLimit decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Unlimited();
      case 1:
        return Limited._decode(input);
      default:
        throw Exception('WeightLimit: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    WeightLimit value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Unlimited:
        (value as Unlimited).encodeTo(output);
        break;
      case Limited:
        (value as Limited).encodeTo(output);
        break;
      default:
        throw Exception(
            'WeightLimit: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(WeightLimit value) {
    switch (value.runtimeType) {
      case Unlimited:
        return 1;
      case Limited:
        return (value as Limited)._sizeHint();
      default:
        throw Exception(
            'WeightLimit: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Unlimited extends WeightLimit {
  const Unlimited();

  @override
  Map<String, dynamic> toJson() => {'Unlimited': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Unlimited;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Limited extends WeightLimit {
  const Limited(this.value0);

  factory Limited._decode(_i1.Input input) {
    return Limited(_i3.Weight.codec.decode(input));
  }

  /// Weight
  final _i3.Weight value0;

  @override
  Map<String, Map<String, BigInt>> toJson() => {'Limited': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.Weight.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Limited && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
