// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'primary_pre_digest.dart' as _i3;
import 'secondary_plain_pre_digest.dart' as _i4;
import 'secondary_v_r_f_pre_digest.dart' as _i5;

abstract class PreDigest {
  const PreDigest();

  factory PreDigest.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $PreDigestCodec codec = $PreDigestCodec();

  static const $PreDigest values = $PreDigest();

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

class $PreDigest {
  const $PreDigest();

  Primary primary(_i3.PrimaryPreDigest value0) {
    return Primary(value0);
  }

  SecondaryPlain secondaryPlain(_i4.SecondaryPlainPreDigest value0) {
    return SecondaryPlain(value0);
  }

  SecondaryVRF secondaryVRF(_i5.SecondaryVRFPreDigest value0) {
    return SecondaryVRF(value0);
  }
}

class $PreDigestCodec with _i1.Codec<PreDigest> {
  const $PreDigestCodec();

  @override
  PreDigest decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return Primary._decode(input);
      case 2:
        return SecondaryPlain._decode(input);
      case 3:
        return SecondaryVRF._decode(input);
      default:
        throw Exception('PreDigest: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    PreDigest value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Primary:
        (value as Primary).encodeTo(output);
        break;
      case SecondaryPlain:
        (value as SecondaryPlain).encodeTo(output);
        break;
      case SecondaryVRF:
        (value as SecondaryVRF).encodeTo(output);
        break;
      default:
        throw Exception(
            'PreDigest: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(PreDigest value) {
    switch (value.runtimeType) {
      case Primary:
        return (value as Primary)._sizeHint();
      case SecondaryPlain:
        return (value as SecondaryPlain)._sizeHint();
      case SecondaryVRF:
        return (value as SecondaryVRF)._sizeHint();
      default:
        throw Exception(
            'PreDigest: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Primary extends PreDigest {
  const Primary(this.value0);

  factory Primary._decode(_i1.Input input) {
    return Primary(_i3.PrimaryPreDigest.codec.decode(input));
  }

  /// PrimaryPreDigest
  final _i3.PrimaryPreDigest value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Primary': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.PrimaryPreDigest.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.PrimaryPreDigest.codec.encodeTo(
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
      other is Primary && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class SecondaryPlain extends PreDigest {
  const SecondaryPlain(this.value0);

  factory SecondaryPlain._decode(_i1.Input input) {
    return SecondaryPlain(_i4.SecondaryPlainPreDigest.codec.decode(input));
  }

  /// SecondaryPlainPreDigest
  final _i4.SecondaryPlainPreDigest value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'SecondaryPlain': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.SecondaryPlainPreDigest.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i4.SecondaryPlainPreDigest.codec.encodeTo(
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
      other is SecondaryPlain && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class SecondaryVRF extends PreDigest {
  const SecondaryVRF(this.value0);

  factory SecondaryVRF._decode(_i1.Input input) {
    return SecondaryVRF(_i5.SecondaryVRFPreDigest.codec.decode(input));
  }

  /// SecondaryVRFPreDigest
  final _i5.SecondaryVRFPreDigest value0;

  @override
  Map<String, Map<String, dynamic>> toJson() =>
      {'SecondaryVRF': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.SecondaryVRFPreDigest.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i5.SecondaryVRFPreDigest.codec.encodeTo(
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
      other is SecondaryVRF && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
