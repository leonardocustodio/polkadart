// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'asset_instance.dart' as _i3;

abstract class Fungibility {
  const Fungibility();

  factory Fungibility.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $FungibilityCodec codec = $FungibilityCodec();

  static const $Fungibility values = $Fungibility();

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

class $Fungibility {
  const $Fungibility();

  Fungible fungible(BigInt value0) {
    return Fungible(value0);
  }

  NonFungible nonFungible(_i3.AssetInstance value0) {
    return NonFungible(value0);
  }
}

class $FungibilityCodec with _i1.Codec<Fungibility> {
  const $FungibilityCodec();

  @override
  Fungibility decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Fungible._decode(input);
      case 1:
        return NonFungible._decode(input);
      default:
        throw Exception('Fungibility: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Fungibility value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Fungible:
        (value as Fungible).encodeTo(output);
        break;
      case NonFungible:
        (value as NonFungible).encodeTo(output);
        break;
      default:
        throw Exception(
            'Fungibility: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Fungibility value) {
    switch (value.runtimeType) {
      case Fungible:
        return (value as Fungible)._sizeHint();
      case NonFungible:
        return (value as NonFungible)._sizeHint();
      default:
        throw Exception(
            'Fungibility: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Fungible extends Fungibility {
  const Fungible(this.value0);

  factory Fungible._decode(_i1.Input input) {
    return Fungible(_i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u128
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'Fungible': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
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
      other is Fungible && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class NonFungible extends Fungibility {
  const NonFungible(this.value0);

  factory NonFungible._decode(_i1.Input input) {
    return NonFungible(_i3.AssetInstance.codec.decode(input));
  }

  /// AssetInstance
  final _i3.AssetInstance value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'NonFungible': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.AssetInstance.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.AssetInstance.codec.encodeTo(
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
      other is NonFungible && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
