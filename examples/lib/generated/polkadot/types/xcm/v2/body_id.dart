// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

abstract class BodyId {
  const BodyId();

  factory BodyId.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $BodyIdCodec codec = $BodyIdCodec();

  static const $BodyId values = $BodyId();

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

class $BodyId {
  const $BodyId();

  Unit unit() {
    return Unit();
  }

  Named named(List<int> value0) {
    return Named(value0);
  }

  Index index(BigInt value0) {
    return Index(value0);
  }

  Executive executive() {
    return Executive();
  }

  Technical technical() {
    return Technical();
  }

  Legislative legislative() {
    return Legislative();
  }

  Judicial judicial() {
    return Judicial();
  }

  Defense defense() {
    return Defense();
  }

  Administration administration() {
    return Administration();
  }

  Treasury treasury() {
    return Treasury();
  }
}

class $BodyIdCodec with _i1.Codec<BodyId> {
  const $BodyIdCodec();

  @override
  BodyId decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Unit();
      case 1:
        return Named._decode(input);
      case 2:
        return Index._decode(input);
      case 3:
        return const Executive();
      case 4:
        return const Technical();
      case 5:
        return const Legislative();
      case 6:
        return const Judicial();
      case 7:
        return const Defense();
      case 8:
        return const Administration();
      case 9:
        return const Treasury();
      default:
        throw Exception('BodyId: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    BodyId value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Unit:
        (value as Unit).encodeTo(output);
        break;
      case Named:
        (value as Named).encodeTo(output);
        break;
      case Index:
        (value as Index).encodeTo(output);
        break;
      case Executive:
        (value as Executive).encodeTo(output);
        break;
      case Technical:
        (value as Technical).encodeTo(output);
        break;
      case Legislative:
        (value as Legislative).encodeTo(output);
        break;
      case Judicial:
        (value as Judicial).encodeTo(output);
        break;
      case Defense:
        (value as Defense).encodeTo(output);
        break;
      case Administration:
        (value as Administration).encodeTo(output);
        break;
      case Treasury:
        (value as Treasury).encodeTo(output);
        break;
      default:
        throw Exception(
            'BodyId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(BodyId value) {
    switch (value.runtimeType) {
      case Unit:
        return 1;
      case Named:
        return (value as Named)._sizeHint();
      case Index:
        return (value as Index)._sizeHint();
      case Executive:
        return 1;
      case Technical:
        return 1;
      case Legislative:
        return 1;
      case Judicial:
        return 1;
      case Defense:
        return 1;
      case Administration:
        return 1;
      case Treasury:
        return 1;
      default:
        throw Exception(
            'BodyId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Unit extends BodyId {
  const Unit();

  @override
  Map<String, dynamic> toJson() => {'Unit': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Unit;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Named extends BodyId {
  const Named(this.value0);

  factory Named._decode(_i1.Input input) {
    return Named(_i1.U8SequenceCodec.codec.decode(input));
  }

  /// WeakBoundedVec<u8, ConstU32<32>>
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Named': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
      other is Named &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Index extends BodyId {
  const Index(this.value0);

  factory Index._decode(_i1.Input input) {
    return Index(_i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u32
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
      2,
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

class Executive extends BodyId {
  const Executive();

  @override
  Map<String, dynamic> toJson() => {'Executive': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Executive;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Technical extends BodyId {
  const Technical();

  @override
  Map<String, dynamic> toJson() => {'Technical': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Technical;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Legislative extends BodyId {
  const Legislative();

  @override
  Map<String, dynamic> toJson() => {'Legislative': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Legislative;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Judicial extends BodyId {
  const Judicial();

  @override
  Map<String, dynamic> toJson() => {'Judicial': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Judicial;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Defense extends BodyId {
  const Defense();

  @override
  Map<String, dynamic> toJson() => {'Defense': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Defense;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Administration extends BodyId {
  const Administration();

  @override
  Map<String, dynamic> toJson() => {'Administration': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Administration;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Treasury extends BodyId {
  const Treasury();

  @override
  Map<String, dynamic> toJson() => {'Treasury': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Treasury;

  @override
  int get hashCode => runtimeType.hashCode;
}
