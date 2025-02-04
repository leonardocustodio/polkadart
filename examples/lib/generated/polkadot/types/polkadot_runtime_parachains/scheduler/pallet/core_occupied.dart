// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'paras_entry.dart' as _i3;

abstract class CoreOccupied {
  const CoreOccupied();

  factory CoreOccupied.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CoreOccupiedCodec codec = $CoreOccupiedCodec();

  static const $CoreOccupied values = $CoreOccupied();

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

class $CoreOccupied {
  const $CoreOccupied();

  Free free() {
    return Free();
  }

  Paras paras(_i3.ParasEntry value0) {
    return Paras(value0);
  }
}

class $CoreOccupiedCodec with _i1.Codec<CoreOccupied> {
  const $CoreOccupiedCodec();

  @override
  CoreOccupied decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Free();
      case 1:
        return Paras._decode(input);
      default:
        throw Exception('CoreOccupied: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    CoreOccupied value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Free:
        (value as Free).encodeTo(output);
        break;
      case Paras:
        (value as Paras).encodeTo(output);
        break;
      default:
        throw Exception(
            'CoreOccupied: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(CoreOccupied value) {
    switch (value.runtimeType) {
      case Free:
        return 1;
      case Paras:
        return (value as Paras)._sizeHint();
      default:
        throw Exception(
            'CoreOccupied: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Free extends CoreOccupied {
  const Free();

  @override
  Map<String, dynamic> toJson() => {'Free': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Free;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Paras extends CoreOccupied {
  const Paras(this.value0);

  factory Paras._decode(_i1.Input input) {
    return Paras(_i3.ParasEntry.codec.decode(input));
  }

  /// ParasEntry<N>
  final _i3.ParasEntry value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Paras': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ParasEntry.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.ParasEntry.codec.encodeTo(
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
      other is Paras && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
