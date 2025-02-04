// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../sp_arithmetic/per_things/perquintill.dart' as _i4;
import 'falloff.dart' as _i7;
import 'ideal_stake.dart' as _i6;
import 'max_inflation.dart' as _i5;
import 'min_inflation.dart' as _i3;
import 'use_auction_slots.dart' as _i8;

abstract class Parameters {
  const Parameters();

  factory Parameters.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ParametersCodec codec = $ParametersCodec();

  static const $Parameters values = $Parameters();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, List<dynamic>> toJson();
}

class $Parameters {
  const $Parameters();

  MinInflation minInflation(
    _i3.MinInflation value0,
    _i4.Perquintill? value1,
  ) {
    return MinInflation(
      value0,
      value1,
    );
  }

  MaxInflation maxInflation(
    _i5.MaxInflation value0,
    _i4.Perquintill? value1,
  ) {
    return MaxInflation(
      value0,
      value1,
    );
  }

  IdealStake idealStake(
    _i6.IdealStake value0,
    _i4.Perquintill? value1,
  ) {
    return IdealStake(
      value0,
      value1,
    );
  }

  Falloff falloff(
    _i7.Falloff value0,
    _i4.Perquintill? value1,
  ) {
    return Falloff(
      value0,
      value1,
    );
  }

  UseAuctionSlots useAuctionSlots(
    _i8.UseAuctionSlots value0,
    bool? value1,
  ) {
    return UseAuctionSlots(
      value0,
      value1,
    );
  }
}

class $ParametersCodec with _i1.Codec<Parameters> {
  const $ParametersCodec();

  @override
  Parameters decode(_i1.Input input) {
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
        throw Exception('Parameters: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Parameters value,
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
            'Parameters: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Parameters value) {
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
            'Parameters: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class MinInflation extends Parameters {
  const MinInflation(
    this.value0,
    this.value1,
  );

  factory MinInflation._decode(_i1.Input input) {
    return MinInflation(
      _i1.NullCodec.codec.decode(input),
      const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec())
          .decode(input),
    );
  }

  /// MinInflation
  final _i3.MinInflation value0;

  /// Option<Perquintill>
  final _i4.Perquintill? value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'MinInflation': [
          null,
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.MinInflationCodec().sizeHint(value0);
    size = size +
        const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec())
            .sizeHint(value1);
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
    const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec()).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MinInflation && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class MaxInflation extends Parameters {
  const MaxInflation(
    this.value0,
    this.value1,
  );

  factory MaxInflation._decode(_i1.Input input) {
    return MaxInflation(
      _i1.NullCodec.codec.decode(input),
      const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec())
          .decode(input),
    );
  }

  /// MaxInflation
  final _i5.MaxInflation value0;

  /// Option<Perquintill>
  final _i4.Perquintill? value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'MaxInflation': [
          null,
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.MaxInflationCodec().sizeHint(value0);
    size = size +
        const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec())
            .sizeHint(value1);
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
    const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec()).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MaxInflation && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class IdealStake extends Parameters {
  const IdealStake(
    this.value0,
    this.value1,
  );

  factory IdealStake._decode(_i1.Input input) {
    return IdealStake(
      _i1.NullCodec.codec.decode(input),
      const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec())
          .decode(input),
    );
  }

  /// IdealStake
  final _i6.IdealStake value0;

  /// Option<Perquintill>
  final _i4.Perquintill? value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'IdealStake': [
          null,
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.IdealStakeCodec().sizeHint(value0);
    size = size +
        const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec())
            .sizeHint(value1);
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
    const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec()).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is IdealStake && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class Falloff extends Parameters {
  const Falloff(
    this.value0,
    this.value1,
  );

  factory Falloff._decode(_i1.Input input) {
    return Falloff(
      _i1.NullCodec.codec.decode(input),
      const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec())
          .decode(input),
    );
  }

  /// Falloff
  final _i7.Falloff value0;

  /// Option<Perquintill>
  final _i4.Perquintill? value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Falloff': [
          null,
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i7.FalloffCodec().sizeHint(value0);
    size = size +
        const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec())
            .sizeHint(value1);
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
    const _i1.OptionCodec<_i4.Perquintill>(_i4.PerquintillCodec()).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Falloff && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class UseAuctionSlots extends Parameters {
  const UseAuctionSlots(
    this.value0,
    this.value1,
  );

  factory UseAuctionSlots._decode(_i1.Input input) {
    return UseAuctionSlots(
      _i1.NullCodec.codec.decode(input),
      const _i1.OptionCodec<bool>(_i1.BoolCodec.codec).decode(input),
    );
  }

  /// UseAuctionSlots
  final _i8.UseAuctionSlots value0;

  /// Option<bool>
  final bool? value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'UseAuctionSlots': [
          null,
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i8.UseAuctionSlotsCodec().sizeHint(value0);
    size = size +
        const _i1.OptionCodec<bool>(_i1.BoolCodec.codec).sizeHint(value1);
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
    const _i1.OptionCodec<bool>(_i1.BoolCodec.codec).encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UseAuctionSlots &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}
