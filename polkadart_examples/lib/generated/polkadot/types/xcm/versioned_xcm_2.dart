// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import 'v2/instruction_2.dart' as _i5;
import 'v2/xcm_2.dart' as _i3;
import 'v3/instruction_2.dart' as _i7;
import 'v3/xcm_2.dart' as _i4;

abstract class VersionedXcm {
  const VersionedXcm();

  factory VersionedXcm.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VersionedXcmCodec codec = $VersionedXcmCodec();

  static const $VersionedXcm values = $VersionedXcm();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, List<Map<String, dynamic>>> toJson();
}

class $VersionedXcm {
  const $VersionedXcm();

  V2 v2(_i3.Xcm value0) {
    return V2(value0);
  }

  V3 v3(_i4.Xcm value0) {
    return V3(value0);
  }
}

class $VersionedXcmCodec with _i1.Codec<VersionedXcm> {
  const $VersionedXcmCodec();

  @override
  VersionedXcm decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 2:
        return V2._decode(input);
      case 3:
        return V3._decode(input);
      default:
        throw Exception('VersionedXcm: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    VersionedXcm value,
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
            'VersionedXcm: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(VersionedXcm value) {
    switch (value.runtimeType) {
      case V2:
        return (value as V2)._sizeHint();
      case V3:
        return (value as V3)._sizeHint();
      default:
        throw Exception(
            'VersionedXcm: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class V2 extends VersionedXcm {
  const V2(this.value0);

  factory V2._decode(_i1.Input input) {
    return V2(const _i1.SequenceCodec<_i5.Instruction>(_i5.Instruction.codec)
        .decode(input));
  }

  /// v2::Xcm<RuntimeCall>
  final _i3.Xcm value0;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() =>
      {'V2': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.XcmCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<_i5.Instruction>(_i5.Instruction.codec).encodeTo(
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
      other is V2 &&
          _i6.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class V3 extends VersionedXcm {
  const V3(this.value0);

  factory V3._decode(_i1.Input input) {
    return V3(const _i1.SequenceCodec<_i7.Instruction>(_i7.Instruction.codec)
        .decode(input));
  }

  /// v3::Xcm<RuntimeCall>
  final _i4.Xcm value0;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() =>
      {'V3': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.XcmCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.SequenceCodec<_i7.Instruction>(_i7.Instruction.codec).encodeTo(
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
      other is V3 &&
          _i6.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}
