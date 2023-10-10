// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class Judgement {
  const Judgement();

  factory Judgement.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $JudgementCodec codec = $JudgementCodec();

  static const $Judgement values = $Judgement();

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

class $Judgement {
  const $Judgement();

  Unknown unknown() {
    return Unknown();
  }

  FeePaid feePaid(BigInt value0) {
    return FeePaid(value0);
  }

  Reasonable reasonable() {
    return Reasonable();
  }

  KnownGood knownGood() {
    return KnownGood();
  }

  OutOfDate outOfDate() {
    return OutOfDate();
  }

  LowQuality lowQuality() {
    return LowQuality();
  }

  Erroneous erroneous() {
    return Erroneous();
  }
}

class $JudgementCodec with _i1.Codec<Judgement> {
  const $JudgementCodec();

  @override
  Judgement decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Unknown();
      case 1:
        return FeePaid._decode(input);
      case 2:
        return const Reasonable();
      case 3:
        return const KnownGood();
      case 4:
        return const OutOfDate();
      case 5:
        return const LowQuality();
      case 6:
        return const Erroneous();
      default:
        throw Exception('Judgement: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Judgement value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Unknown:
        (value as Unknown).encodeTo(output);
        break;
      case FeePaid:
        (value as FeePaid).encodeTo(output);
        break;
      case Reasonable:
        (value as Reasonable).encodeTo(output);
        break;
      case KnownGood:
        (value as KnownGood).encodeTo(output);
        break;
      case OutOfDate:
        (value as OutOfDate).encodeTo(output);
        break;
      case LowQuality:
        (value as LowQuality).encodeTo(output);
        break;
      case Erroneous:
        (value as Erroneous).encodeTo(output);
        break;
      default:
        throw Exception(
            'Judgement: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Judgement value) {
    switch (value.runtimeType) {
      case Unknown:
        return 1;
      case FeePaid:
        return (value as FeePaid)._sizeHint();
      case Reasonable:
        return 1;
      case KnownGood:
        return 1;
      case OutOfDate:
        return 1;
      case LowQuality:
        return 1;
      case Erroneous:
        return 1;
      default:
        throw Exception(
            'Judgement: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Unknown extends Judgement {
  const Unknown();

  @override
  Map<String, dynamic> toJson() => {'Unknown': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Unknown;

  @override
  int get hashCode => runtimeType.hashCode;
}

class FeePaid extends Judgement {
  const FeePaid(this.value0);

  factory FeePaid._decode(_i1.Input input) {
    return FeePaid(_i1.U128Codec.codec.decode(input));
  }

  /// Balance
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'FeePaid': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
      other is FeePaid && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Reasonable extends Judgement {
  const Reasonable();

  @override
  Map<String, dynamic> toJson() => {'Reasonable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Reasonable;

  @override
  int get hashCode => runtimeType.hashCode;
}

class KnownGood extends Judgement {
  const KnownGood();

  @override
  Map<String, dynamic> toJson() => {'KnownGood': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is KnownGood;

  @override
  int get hashCode => runtimeType.hashCode;
}

class OutOfDate extends Judgement {
  const OutOfDate();

  @override
  Map<String, dynamic> toJson() => {'OutOfDate': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is OutOfDate;

  @override
  int get hashCode => runtimeType.hashCode;
}

class LowQuality extends Judgement {
  const LowQuality();

  @override
  Map<String, dynamic> toJson() => {'LowQuality': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is LowQuality;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Erroneous extends Judgement {
  const Erroneous();

  @override
  Map<String, dynamic> toJson() => {'Erroneous': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Erroneous;

  @override
  int get hashCode => runtimeType.hashCode;
}
