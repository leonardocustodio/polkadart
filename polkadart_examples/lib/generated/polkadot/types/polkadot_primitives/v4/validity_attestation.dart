// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'validator_app/signature.dart' as _i3;

abstract class ValidityAttestation {
  const ValidityAttestation();

  factory ValidityAttestation.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ValidityAttestationCodec codec = $ValidityAttestationCodec();

  static const $ValidityAttestation values = $ValidityAttestation();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, List<int>> toJson();
}

class $ValidityAttestation {
  const $ValidityAttestation();

  Implicit implicit(_i3.Signature value0) {
    return Implicit(value0);
  }

  Explicit explicit(_i3.Signature value0) {
    return Explicit(value0);
  }
}

class $ValidityAttestationCodec with _i1.Codec<ValidityAttestation> {
  const $ValidityAttestationCodec();

  @override
  ValidityAttestation decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return Implicit._decode(input);
      case 2:
        return Explicit._decode(input);
      default:
        throw Exception('ValidityAttestation: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ValidityAttestation value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Implicit:
        (value as Implicit).encodeTo(output);
        break;
      case Explicit:
        (value as Explicit).encodeTo(output);
        break;
      default:
        throw Exception(
            'ValidityAttestation: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ValidityAttestation value) {
    switch (value.runtimeType) {
      case Implicit:
        return (value as Implicit)._sizeHint();
      case Explicit:
        return (value as Explicit)._sizeHint();
      default:
        throw Exception(
            'ValidityAttestation: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Implicit extends ValidityAttestation {
  const Implicit(this.value0);

  factory Implicit._decode(_i1.Input input) {
    return Implicit(const _i1.U8ArrayCodec(64).decode(input));
  }

  /// ValidatorSignature
  final _i3.Signature value0;

  @override
  Map<String, List<int>> toJson() => {'Implicit': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.SignatureCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(64).encodeTo(
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
      other is Implicit && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Explicit extends ValidityAttestation {
  const Explicit(this.value0);

  factory Explicit._decode(_i1.Input input) {
    return Explicit(const _i1.U8ArrayCodec(64).decode(input));
  }

  /// ValidatorSignature
  final _i3.Signature value0;

  @override
  Map<String, List<int>> toJson() => {'Explicit': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.SignatureCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(64).encodeTo(
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
      other is Explicit && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
