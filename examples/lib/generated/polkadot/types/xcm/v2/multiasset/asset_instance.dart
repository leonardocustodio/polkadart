// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

abstract class AssetInstance {
  const AssetInstance();

  factory AssetInstance.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AssetInstanceCodec codec = $AssetInstanceCodec();

  static const $AssetInstance values = $AssetInstance();

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

class $AssetInstance {
  const $AssetInstance();

  Undefined undefined() {
    return Undefined();
  }

  Index index(BigInt value0) {
    return Index(value0);
  }

  Array4 array4(List<int> value0) {
    return Array4(value0);
  }

  Array8 array8(List<int> value0) {
    return Array8(value0);
  }

  Array16 array16(List<int> value0) {
    return Array16(value0);
  }

  Array32 array32(List<int> value0) {
    return Array32(value0);
  }

  Blob blob(List<int> value0) {
    return Blob(value0);
  }
}

class $AssetInstanceCodec with _i1.Codec<AssetInstance> {
  const $AssetInstanceCodec();

  @override
  AssetInstance decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Undefined();
      case 1:
        return Index._decode(input);
      case 2:
        return Array4._decode(input);
      case 3:
        return Array8._decode(input);
      case 4:
        return Array16._decode(input);
      case 5:
        return Array32._decode(input);
      case 6:
        return Blob._decode(input);
      default:
        throw Exception('AssetInstance: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AssetInstance value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Undefined:
        (value as Undefined).encodeTo(output);
        break;
      case Index:
        (value as Index).encodeTo(output);
        break;
      case Array4:
        (value as Array4).encodeTo(output);
        break;
      case Array8:
        (value as Array8).encodeTo(output);
        break;
      case Array16:
        (value as Array16).encodeTo(output);
        break;
      case Array32:
        (value as Array32).encodeTo(output);
        break;
      case Blob:
        (value as Blob).encodeTo(output);
        break;
      default:
        throw Exception(
            'AssetInstance: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AssetInstance value) {
    switch (value.runtimeType) {
      case Undefined:
        return 1;
      case Index:
        return (value as Index)._sizeHint();
      case Array4:
        return (value as Array4)._sizeHint();
      case Array8:
        return (value as Array8)._sizeHint();
      case Array16:
        return (value as Array16)._sizeHint();
      case Array32:
        return (value as Array32)._sizeHint();
      case Blob:
        return (value as Blob)._sizeHint();
      default:
        throw Exception(
            'AssetInstance: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Undefined extends AssetInstance {
  const Undefined();

  @override
  Map<String, dynamic> toJson() => {'Undefined': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Undefined;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Index extends AssetInstance {
  const Index(this.value0);

  factory Index._decode(_i1.Input input) {
    return Index(_i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u128
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'Index': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
      other is Index && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Array4 extends AssetInstance {
  const Array4(this.value0);

  factory Array4._decode(_i1.Input input) {
    return Array4(const _i1.U8ArrayCodec(4).decode(input));
  }

  /// [u8; 4]
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Array4': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(4).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(4).encodeTo(
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
      other is Array4 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Array8 extends AssetInstance {
  const Array8(this.value0);

  factory Array8._decode(_i1.Input input) {
    return Array8(const _i1.U8ArrayCodec(8).decode(input));
  }

  /// [u8; 8]
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Array8': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(8).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(8).encodeTo(
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
      other is Array8 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Array16 extends AssetInstance {
  const Array16(this.value0);

  factory Array16._decode(_i1.Input input) {
    return Array16(const _i1.U8ArrayCodec(16).decode(input));
  }

  /// [u8; 16]
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Array16': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(16).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(16).encodeTo(
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
      other is Array16 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Array32 extends AssetInstance {
  const Array32(this.value0);

  factory Array32._decode(_i1.Input input) {
    return Array32(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// [u8; 32]
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Array32': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
      other is Array32 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Blob extends AssetInstance {
  const Blob(this.value0);

  factory Blob._decode(_i1.Input input) {
    return Blob(_i1.U8SequenceCodec.codec.decode(input));
  }

  /// Vec<u8>
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Blob': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
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
      other is Blob &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}
