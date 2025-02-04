// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'dynamic_params/inflation/parameters_key.dart' as _i3;

abstract class RuntimeParametersKey {
  const RuntimeParametersKey();

  factory RuntimeParametersKey.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RuntimeParametersKeyCodec codec = $RuntimeParametersKeyCodec();

  static const $RuntimeParametersKey values = $RuntimeParametersKey();

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

class $RuntimeParametersKey {
  const $RuntimeParametersKey();

  Inflation inflation(_i3.ParametersKey value0) {
    return Inflation(value0);
  }
}

class $RuntimeParametersKeyCodec with _i1.Codec<RuntimeParametersKey> {
  const $RuntimeParametersKeyCodec();

  @override
  RuntimeParametersKey decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Inflation._decode(input);
      default:
        throw Exception(
            'RuntimeParametersKey: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RuntimeParametersKey value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Inflation:
        (value as Inflation).encodeTo(output);
        break;
      default:
        throw Exception(
            'RuntimeParametersKey: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeParametersKey value) {
    switch (value.runtimeType) {
      case Inflation:
        return (value as Inflation)._sizeHint();
      default:
        throw Exception(
            'RuntimeParametersKey: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Inflation extends RuntimeParametersKey {
  const Inflation(this.value0);

  factory Inflation._decode(_i1.Input input) {
    return Inflation(_i3.ParametersKey.codec.decode(input));
  }

  /// <dynamic_params::inflation::Parameters as frame_support::traits::
  ///dynamic_params::AggregatedKeyValue>::Key
  final _i3.ParametersKey value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Inflation': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ParametersKey.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ParametersKey.codec.encodeTo(
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
      other is Inflation && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
