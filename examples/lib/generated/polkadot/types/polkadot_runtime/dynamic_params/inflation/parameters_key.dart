// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'falloff.dart' as _i6;
import 'ideal_stake.dart' as _i5;
import 'max_inflation.dart' as _i4;
import 'min_inflation.dart' as _i3;
import 'use_auction_slots.dart' as _i7;

abstract class ParametersKey {
  const ParametersKey();

  factory ParametersKey.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ParametersKeyCodec codec = $ParametersKeyCodec();

  static const $ParametersKey values = $ParametersKey();

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

class $ParametersKey {
  const $ParametersKey();

  MinInflation minInflation(_i3.MinInflation value0) {
    return MinInflation(value0);
  }

  MaxInflation maxInflation(_i4.MaxInflation value0) {
    return MaxInflation(value0);
  }

  IdealStake idealStake(_i5.IdealStake value0) {
    return IdealStake(value0);
  }

  Falloff falloff(_i6.Falloff value0) {
    return Falloff(value0);
  }

  UseAuctionSlots useAuctionSlots(_i7.UseAuctionSlots value0) {
    return UseAuctionSlots(value0);
  }
}

class $ParametersKeyCodec with _i1.Codec<ParametersKey> {
  const $ParametersKeyCodec();

  @override
  ParametersKey decode(_i1.Input input) {
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
        throw Exception('ParametersKey: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ParametersKey value,
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
            'ParametersKey: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ParametersKey value) {
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
            'ParametersKey: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class MinInflation extends ParametersKey {
  const MinInflation(this.value0);

  factory MinInflation._decode(_i1.Input input) {
    return MinInflation(_i1.NullCodec.codec.decode(input));
  }

  /// MinInflation
  final _i3.MinInflation value0;

  @override
  Map<String, dynamic> toJson() => {'MinInflation': null};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.MinInflationCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
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

class MaxInflation extends ParametersKey {
  const MaxInflation(this.value0);

  factory MaxInflation._decode(_i1.Input input) {
    return MaxInflation(_i1.NullCodec.codec.decode(input));
  }

  /// MaxInflation
  final _i4.MaxInflation value0;

  @override
  Map<String, dynamic> toJson() => {'MaxInflation': null};

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.MaxInflationCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
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

class IdealStake extends ParametersKey {
  const IdealStake(this.value0);

  factory IdealStake._decode(_i1.Input input) {
    return IdealStake(_i1.NullCodec.codec.decode(input));
  }

  /// IdealStake
  final _i5.IdealStake value0;

  @override
  Map<String, dynamic> toJson() => {'IdealStake': null};

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.IdealStakeCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
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

class Falloff extends ParametersKey {
  const Falloff(this.value0);

  factory Falloff._decode(_i1.Input input) {
    return Falloff(_i1.NullCodec.codec.decode(input));
  }

  /// Falloff
  final _i6.Falloff value0;

  @override
  Map<String, dynamic> toJson() => {'Falloff': null};

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.FalloffCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
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

class UseAuctionSlots extends ParametersKey {
  const UseAuctionSlots(this.value0);

  factory UseAuctionSlots._decode(_i1.Input input) {
    return UseAuctionSlots(_i1.NullCodec.codec.decode(input));
  }

  /// UseAuctionSlots
  final _i7.UseAuctionSlots value0;

  @override
  Map<String, dynamic> toJson() => {'UseAuctionSlots': null};

  int _sizeHint() {
    int size = 1;
    size = size + const _i7.UseAuctionSlotsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
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
