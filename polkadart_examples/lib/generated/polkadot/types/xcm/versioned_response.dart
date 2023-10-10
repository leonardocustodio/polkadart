// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'v2/response.dart' as _i3;
import 'v3/response.dart' as _i4;

abstract class VersionedResponse {
  const VersionedResponse();

  factory VersionedResponse.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VersionedResponseCodec codec = $VersionedResponseCodec();

  static const $VersionedResponse values = $VersionedResponse();

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

class $VersionedResponse {
  const $VersionedResponse();

  V2 v2(_i3.Response value0) {
    return V2(value0);
  }

  V3 v3(_i4.Response value0) {
    return V3(value0);
  }
}

class $VersionedResponseCodec with _i1.Codec<VersionedResponse> {
  const $VersionedResponseCodec();

  @override
  VersionedResponse decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 2:
        return V2._decode(input);
      case 3:
        return V3._decode(input);
      default:
        throw Exception('VersionedResponse: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    VersionedResponse value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case V2:
        (value as V2).encodeTo(output);
        break;
      case V3:
        (value as V3).encodeTo(output);
        break;
      default:
        throw Exception(
            'VersionedResponse: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(VersionedResponse value) {
    switch (value.runtimeType) {
      case V2:
        return (value as V2)._sizeHint();
      case V3:
        return (value as V3)._sizeHint();
      default:
        throw Exception(
            'VersionedResponse: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class V2 extends VersionedResponse {
  const V2(this.value0);

  factory V2._decode(_i1.Input input) {
    return V2(_i3.Response.codec.decode(input));
  }

  /// v2::Response
  final _i3.Response value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'V2': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Response.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.Response.codec.encodeTo(
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
      other is V2 && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class V3 extends VersionedResponse {
  const V3(this.value0);

  factory V3._decode(_i1.Input input) {
    return V3(_i4.Response.codec.decode(input));
  }

  /// v3::Response
  final _i4.Response value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'V3': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Response.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i4.Response.codec.encodeTo(
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
      other is V3 && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
