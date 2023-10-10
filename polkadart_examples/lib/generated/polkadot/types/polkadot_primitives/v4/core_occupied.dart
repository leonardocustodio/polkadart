// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'parathread_entry.dart' as _i3;

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

  Parathread parathread(_i3.ParathreadEntry value0) {
    return Parathread(value0);
  }

  Parachain parachain() {
    return Parachain();
  }
}

class $CoreOccupiedCodec with _i1.Codec<CoreOccupied> {
  const $CoreOccupiedCodec();

  @override
  CoreOccupied decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Parathread._decode(input);
      case 1:
        return const Parachain();
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
      case Parathread:
        (value as Parathread).encodeTo(output);
        break;
      case Parachain:
        (value as Parachain).encodeTo(output);
        break;
      default:
        throw Exception(
            'CoreOccupied: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(CoreOccupied value) {
    switch (value.runtimeType) {
      case Parathread:
        return (value as Parathread)._sizeHint();
      case Parachain:
        return 1;
      default:
        throw Exception(
            'CoreOccupied: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Parathread extends CoreOccupied {
  const Parathread(this.value0);

  factory Parathread._decode(_i1.Input input) {
    return Parathread(_i3.ParathreadEntry.codec.decode(input));
  }

  /// ParathreadEntry
  final _i3.ParathreadEntry value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Parathread': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ParathreadEntry.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ParathreadEntry.codec.encodeTo(
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
      other is Parathread && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Parachain extends CoreOccupied {
  const Parachain();

  @override
  Map<String, dynamic> toJson() => {'Parachain': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Parachain;

  @override
  int get hashCode => runtimeType.hashCode;
}
