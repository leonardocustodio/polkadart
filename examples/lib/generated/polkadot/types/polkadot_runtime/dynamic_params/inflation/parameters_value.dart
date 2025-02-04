// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../sp_arithmetic/per_things/perquintill.dart' as _i3;

abstract class ParametersValue {
  const ParametersValue();

  factory ParametersValue.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ParametersValueCodec codec = $ParametersValueCodec();

  static const $ParametersValue values = $ParametersValue();

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

class $ParametersValue {
  const $ParametersValue();

  MinInflation minInflation(_i3.Perquintill value0) {
    return MinInflation(value0);
  }

  MaxInflation maxInflation(_i3.Perquintill value0) {
    return MaxInflation(value0);
  }

  IdealStake idealStake(_i3.Perquintill value0) {
    return IdealStake(value0);
  }

  Falloff falloff(_i3.Perquintill value0) {
    return Falloff(value0);
  }

  UseAuctionSlots useAuctionSlots(bool value0) {
    return UseAuctionSlots(value0);
  }
}

class $ParametersValueCodec with _i1.Codec<ParametersValue> {
  const $ParametersValueCodec();

  @override
  ParametersValue decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return MinInflation._decode(input);
      case 1:
        return MaxInflation._decode(input);
      case 2:
        return IdealStake._decode(input);
      case 3:
        return Falloff._decode(input);
      case 4:
        return UseAuctionSlots._decode(input);
      default:
        throw Exception('ParametersValue: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ParametersValue value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case MinInflation:
        (value as MinInflation).encodeTo(output);
        break;
      case MaxInflation:
        (value as MaxInflation).encodeTo(output);
        break;
      case IdealStake:
        (value as IdealStake).encodeTo(output);
        break;
      case Falloff:
        (value as Falloff).encodeTo(output);
        break;
      case UseAuctionSlots:
        (value as UseAuctionSlots).encodeTo(output);
        break;
      default:
        throw Exception(
            'ParametersValue: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ParametersValue value) {
    switch (value.runtimeType) {
      case MinInflation:
        return (value as MinInflation)._sizeHint();
      case MaxInflation:
        return (value as MaxInflation)._sizeHint();
      case IdealStake:
        return (value as IdealStake)._sizeHint();
      case Falloff:
        return (value as Falloff)._sizeHint();
      case UseAuctionSlots:
        return (value as UseAuctionSlots)._sizeHint();
      default:
        throw Exception(
            'ParametersValue: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class MinInflation extends ParametersValue {
  const MinInflation(this.value0);

  factory MinInflation._decode(_i1.Input input) {
    return MinInflation(_i1.U64Codec.codec.decode(input));
  }

  /// Perquintill
  final _i3.Perquintill value0;

  @override
  Map<String, BigInt> toJson() => {'MinInflation': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.PerquintillCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is MinInflation && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class MaxInflation extends ParametersValue {
  const MaxInflation(this.value0);

  factory MaxInflation._decode(_i1.Input input) {
    return MaxInflation(_i1.U64Codec.codec.decode(input));
  }

  /// Perquintill
  final _i3.Perquintill value0;

  @override
  Map<String, BigInt> toJson() => {'MaxInflation': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.PerquintillCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is MaxInflation && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class IdealStake extends ParametersValue {
  const IdealStake(this.value0);

  factory IdealStake._decode(_i1.Input input) {
    return IdealStake(_i1.U64Codec.codec.decode(input));
  }

  /// Perquintill
  final _i3.Perquintill value0;

  @override
  Map<String, BigInt> toJson() => {'IdealStake': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.PerquintillCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is IdealStake && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Falloff extends ParametersValue {
  const Falloff(this.value0);

  factory Falloff._decode(_i1.Input input) {
    return Falloff(_i1.U64Codec.codec.decode(input));
  }

  /// Perquintill
  final _i3.Perquintill value0;

  @override
  Map<String, BigInt> toJson() => {'Falloff': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.PerquintillCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is Falloff && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class UseAuctionSlots extends ParametersValue {
  const UseAuctionSlots(this.value0);

  factory UseAuctionSlots._decode(_i1.Input input) {
    return UseAuctionSlots(_i1.BoolCodec.codec.decode(input));
  }

  /// bool
  final bool value0;

  @override
  Map<String, bool> toJson() => {'UseAuctionSlots': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.BoolCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
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
      other is UseAuctionSlots && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
