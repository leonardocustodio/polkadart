// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'v2/multilocation/multi_location.dart' as _i3;
import 'v3/multilocation/multi_location.dart' as _i4;

abstract class VersionedMultiLocation {
  const VersionedMultiLocation();

  factory VersionedMultiLocation.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VersionedMultiLocationCodec codec =
      $VersionedMultiLocationCodec();

  static const $VersionedMultiLocation values = $VersionedMultiLocation();

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

class $VersionedMultiLocation {
  const $VersionedMultiLocation();

  V2 v2(_i3.MultiLocation value0) {
    return V2(value0);
  }

  V3 v3(_i4.MultiLocation value0) {
    return V3(value0);
  }
}

class $VersionedMultiLocationCodec with _i1.Codec<VersionedMultiLocation> {
  const $VersionedMultiLocationCodec();

  @override
  VersionedMultiLocation decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return V2._decode(input);
      case 3:
        return V3._decode(input);
      default:
        throw Exception(
            'VersionedMultiLocation: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    VersionedMultiLocation value,
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
            'VersionedMultiLocation: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(VersionedMultiLocation value) {
    switch (value.runtimeType) {
      case V2:
        return (value as V2)._sizeHint();
      case V3:
        return (value as V3)._sizeHint();
      default:
        throw Exception(
            'VersionedMultiLocation: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class V2 extends VersionedMultiLocation {
  const V2(this.value0);

  factory V2._decode(_i1.Input input) {
    return V2(_i3.MultiLocation.codec.decode(input));
  }

  /// v2::MultiLocation
  final _i3.MultiLocation value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'V2': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiLocation.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.MultiLocation.codec.encodeTo(
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

class V3 extends VersionedMultiLocation {
  const V3(this.value0);

  factory V3._decode(_i1.Input input) {
    return V3(_i4.MultiLocation.codec.decode(input));
  }

  /// v3::MultiLocation
  final _i4.MultiLocation value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'V3': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiLocation.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i4.MultiLocation.codec.encodeTo(
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
