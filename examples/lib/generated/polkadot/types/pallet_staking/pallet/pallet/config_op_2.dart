// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class ConfigOp {
  const ConfigOp();

  factory ConfigOp.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ConfigOpCodec codec = $ConfigOpCodec();

  static const $ConfigOp values = $ConfigOp();

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

class $ConfigOp {
  const $ConfigOp();

  Noop noop() {
    return Noop();
  }

  Set set(int value0) {
    return Set(value0);
  }

  Remove remove() {
    return Remove();
  }
}

class $ConfigOpCodec with _i1.Codec<ConfigOp> {
  const $ConfigOpCodec();

  @override
  ConfigOp decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Noop();
      case 1:
        return Set._decode(input);
      case 2:
        return const Remove();
      default:
        throw Exception('ConfigOp: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ConfigOp value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Noop:
        (value as Noop).encodeTo(output);
        break;
      case Set:
        (value as Set).encodeTo(output);
        break;
      case Remove:
        (value as Remove).encodeTo(output);
        break;
      default:
        throw Exception(
            'ConfigOp: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ConfigOp value) {
    switch (value.runtimeType) {
      case Noop:
        return 1;
      case Set:
        return (value as Set)._sizeHint();
      case Remove:
        return 1;
      default:
        throw Exception(
            'ConfigOp: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Noop extends ConfigOp {
  const Noop();

  @override
  Map<String, dynamic> toJson() => {'Noop': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Noop;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Set extends ConfigOp {
  const Set(this.value0);

  factory Set._decode(_i1.Input input) {
    return Set(_i1.U32Codec.codec.decode(input));
  }

  /// T
  final int value0;

  @override
  Map<String, int> toJson() => {'Set': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is Set && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Remove extends ConfigOp {
  const Remove();

  @override
  Map<String, dynamic> toJson() => {'Remove': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Remove;

  @override
  int get hashCode => runtimeType.hashCode;
}
