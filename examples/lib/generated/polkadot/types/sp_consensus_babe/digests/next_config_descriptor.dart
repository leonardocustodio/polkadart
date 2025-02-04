// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../tuples.dart' as _i3;
import '../allowed_slots.dart' as _i4;

abstract class NextConfigDescriptor {
  const NextConfigDescriptor();

  factory NextConfigDescriptor.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $NextConfigDescriptorCodec codec = $NextConfigDescriptorCodec();

  static const $NextConfigDescriptor values = $NextConfigDescriptor();

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

class $NextConfigDescriptor {
  const $NextConfigDescriptor();

  V1 v1({
    required _i3.Tuple2<BigInt, BigInt> c,
    required _i4.AllowedSlots allowedSlots,
  }) {
    return V1(
      c: c,
      allowedSlots: allowedSlots,
    );
  }
}

class $NextConfigDescriptorCodec with _i1.Codec<NextConfigDescriptor> {
  const $NextConfigDescriptorCodec();

  @override
  NextConfigDescriptor decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return V1._decode(input);
      default:
        throw Exception(
            'NextConfigDescriptor: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    NextConfigDescriptor value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case V1:
        (value as V1).encodeTo(output);
        break;
      default:
        throw Exception(
            'NextConfigDescriptor: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(NextConfigDescriptor value) {
    switch (value.runtimeType) {
      case V1:
        return (value as V1)._sizeHint();
      default:
        throw Exception(
            'NextConfigDescriptor: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class V1 extends NextConfigDescriptor {
  const V1({
    required this.c,
    required this.allowedSlots,
  });

  factory V1._decode(_i1.Input input) {
    return V1(
      c: const _i3.Tuple2Codec<BigInt, BigInt>(
        _i1.U64Codec.codec,
        _i1.U64Codec.codec,
      ).decode(input),
      allowedSlots: _i4.AllowedSlots.codec.decode(input),
    );
  }

  /// (u64, u64)
  final _i3.Tuple2<BigInt, BigInt> c;

  /// AllowedSlots
  final _i4.AllowedSlots allowedSlots;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'V1': {
          'c': [
            c.value0,
            c.value1,
          ],
          'allowedSlots': allowedSlots.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i3.Tuple2Codec<BigInt, BigInt>(
          _i1.U64Codec.codec,
          _i1.U64Codec.codec,
        ).sizeHint(c);
    size = size + _i4.AllowedSlots.codec.sizeHint(allowedSlots);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i3.Tuple2Codec<BigInt, BigInt>(
      _i1.U64Codec.codec,
      _i1.U64Codec.codec,
    ).encodeTo(
      c,
      output,
    );
    _i4.AllowedSlots.codec.encodeTo(
      allowedSlots,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is V1 && other.c == c && other.allowedSlots == allowedSlots;

  @override
  int get hashCode => Object.hash(
        c,
        allowedSlots,
      );
}
