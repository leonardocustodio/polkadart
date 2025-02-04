// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class BodyPart {
  const BodyPart();

  factory BodyPart.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $BodyPartCodec codec = $BodyPartCodec();

  static const $BodyPart values = $BodyPart();

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

class $BodyPart {
  const $BodyPart();

  Voice voice() {
    return Voice();
  }

  Members members({required BigInt count}) {
    return Members(count: count);
  }

  Fraction fraction({
    required BigInt nom,
    required BigInt denom,
  }) {
    return Fraction(
      nom: nom,
      denom: denom,
    );
  }

  AtLeastProportion atLeastProportion({
    required BigInt nom,
    required BigInt denom,
  }) {
    return AtLeastProportion(
      nom: nom,
      denom: denom,
    );
  }

  MoreThanProportion moreThanProportion({
    required BigInt nom,
    required BigInt denom,
  }) {
    return MoreThanProportion(
      nom: nom,
      denom: denom,
    );
  }
}

class $BodyPartCodec with _i1.Codec<BodyPart> {
  const $BodyPartCodec();

  @override
  BodyPart decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Voice();
      case 1:
        return Members._decode(input);
      case 2:
        return Fraction._decode(input);
      case 3:
        return AtLeastProportion._decode(input);
      case 4:
        return MoreThanProportion._decode(input);
      default:
        throw Exception('BodyPart: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    BodyPart value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Voice:
        (value as Voice).encodeTo(output);
        break;
      case Members:
        (value as Members).encodeTo(output);
        break;
      case Fraction:
        (value as Fraction).encodeTo(output);
        break;
      case AtLeastProportion:
        (value as AtLeastProportion).encodeTo(output);
        break;
      case MoreThanProportion:
        (value as MoreThanProportion).encodeTo(output);
        break;
      default:
        throw Exception(
            'BodyPart: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(BodyPart value) {
    switch (value.runtimeType) {
      case Voice:
        return 1;
      case Members:
        return (value as Members)._sizeHint();
      case Fraction:
        return (value as Fraction)._sizeHint();
      case AtLeastProportion:
        return (value as AtLeastProportion)._sizeHint();
      case MoreThanProportion:
        return (value as MoreThanProportion)._sizeHint();
      default:
        throw Exception(
            'BodyPart: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Voice extends BodyPart {
  const Voice();

  @override
  Map<String, dynamic> toJson() => {'Voice': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Voice;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Members extends BodyPart {
  const Members({required this.count});

  factory Members._decode(_i1.Input input) {
    return Members(count: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u32
  final BigInt count;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Members': {'count': count}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(count);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      count,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Members && other.count == count;

  @override
  int get hashCode => count.hashCode;
}

class Fraction extends BodyPart {
  const Fraction({
    required this.nom,
    required this.denom,
  });

  factory Fraction._decode(_i1.Input input) {
    return Fraction(
      nom: _i1.CompactBigIntCodec.codec.decode(input),
      denom: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// u32
  final BigInt nom;

  /// u32
  final BigInt denom;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Fraction': {
          'nom': nom,
          'denom': denom,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(nom);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(denom);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      nom,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      denom,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Fraction && other.nom == nom && other.denom == denom;

  @override
  int get hashCode => Object.hash(
        nom,
        denom,
      );
}

class AtLeastProportion extends BodyPart {
  const AtLeastProportion({
    required this.nom,
    required this.denom,
  });

  factory AtLeastProportion._decode(_i1.Input input) {
    return AtLeastProportion(
      nom: _i1.CompactBigIntCodec.codec.decode(input),
      denom: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// u32
  final BigInt nom;

  /// u32
  final BigInt denom;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'AtLeastProportion': {
          'nom': nom,
          'denom': denom,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(nom);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(denom);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      nom,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      denom,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AtLeastProportion && other.nom == nom && other.denom == denom;

  @override
  int get hashCode => Object.hash(
        nom,
        denom,
      );
}

class MoreThanProportion extends BodyPart {
  const MoreThanProportion({
    required this.nom,
    required this.denom,
  });

  factory MoreThanProportion._decode(_i1.Input input) {
    return MoreThanProportion(
      nom: _i1.CompactBigIntCodec.codec.decode(input),
      denom: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// u32
  final BigInt nom;

  /// u32
  final BigInt denom;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'MoreThanProportion': {
          'nom': nom,
          'denom': denom,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(nom);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(denom);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      nom,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      denom,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MoreThanProportion && other.nom == nom && other.denom == denom;

  @override
  int get hashCode => Object.hash(
        nom,
        denom,
      );
}
