// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class BondExtra {
  const BondExtra();

  factory BondExtra.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $BondExtraCodec codec = $BondExtraCodec();

  static const $BondExtra values = $BondExtra();

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

class $BondExtra {
  const $BondExtra();

  FreeBalance freeBalance(BigInt value0) {
    return FreeBalance(value0);
  }

  Rewards rewards() {
    return Rewards();
  }
}

class $BondExtraCodec with _i1.Codec<BondExtra> {
  const $BondExtraCodec();

  @override
  BondExtra decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return FreeBalance._decode(input);
      case 1:
        return const Rewards();
      default:
        throw Exception('BondExtra: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    BondExtra value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case FreeBalance:
        (value as FreeBalance).encodeTo(output);
        break;
      case Rewards:
        (value as Rewards).encodeTo(output);
        break;
      default:
        throw Exception(
            'BondExtra: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(BondExtra value) {
    switch (value.runtimeType) {
      case FreeBalance:
        return (value as FreeBalance)._sizeHint();
      case Rewards:
        return 1;
      default:
        throw Exception(
            'BondExtra: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class FreeBalance extends BondExtra {
  const FreeBalance(this.value0);

  factory FreeBalance._decode(_i1.Input input) {
    return FreeBalance(_i1.U128Codec.codec.decode(input));
  }

  /// Balance
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'FreeBalance': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
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
      other is FreeBalance && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Rewards extends BondExtra {
  const Rewards();

  @override
  Map<String, dynamic> toJson() => {'Rewards': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Rewards;

  @override
  int get hashCode => runtimeType.hashCode;
}
