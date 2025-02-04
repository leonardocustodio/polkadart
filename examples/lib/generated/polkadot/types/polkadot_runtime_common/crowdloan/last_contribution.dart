// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class LastContribution {
  const LastContribution();

  factory LastContribution.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $LastContributionCodec codec = $LastContributionCodec();

  static const $LastContribution values = $LastContribution();

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

class $LastContribution {
  const $LastContribution();

  Never never() {
    return Never();
  }

  PreEnding preEnding(int value0) {
    return PreEnding(value0);
  }

  Ending ending(int value0) {
    return Ending(value0);
  }
}

class $LastContributionCodec with _i1.Codec<LastContribution> {
  const $LastContributionCodec();

  @override
  LastContribution decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Never();
      case 1:
        return PreEnding._decode(input);
      case 2:
        return Ending._decode(input);
      default:
        throw Exception('LastContribution: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    LastContribution value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Never:
        (value as Never).encodeTo(output);
        break;
      case PreEnding:
        (value as PreEnding).encodeTo(output);
        break;
      case Ending:
        (value as Ending).encodeTo(output);
        break;
      default:
        throw Exception(
            'LastContribution: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(LastContribution value) {
    switch (value.runtimeType) {
      case Never:
        return 1;
      case PreEnding:
        return (value as PreEnding)._sizeHint();
      case Ending:
        return (value as Ending)._sizeHint();
      default:
        throw Exception(
            'LastContribution: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Never extends LastContribution {
  const Never();

  @override
  Map<String, dynamic> toJson() => {'Never': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Never;

  @override
  int get hashCode => runtimeType.hashCode;
}

class PreEnding extends LastContribution {
  const PreEnding(this.value0);

  factory PreEnding._decode(_i1.Input input) {
    return PreEnding(_i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int value0;

  @override
  Map<String, int> toJson() => {'PreEnding': value0};

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
      other is PreEnding && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Ending extends LastContribution {
  const Ending(this.value0);

  factory Ending._decode(_i1.Input input) {
    return Ending(_i1.U32Codec.codec.decode(input));
  }

  /// BlockNumber
  final int value0;

  @override
  Map<String, int> toJson() => {'Ending': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is Ending && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
