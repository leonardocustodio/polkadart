// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class DispatchTime {
  const DispatchTime();

  factory DispatchTime.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $DispatchTimeCodec codec = $DispatchTimeCodec();

  static const $DispatchTime values = $DispatchTime();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, int> toJson();
}

class $DispatchTime {
  const $DispatchTime();

  At at(int value0) {
    return At(value0);
  }

  After after(int value0) {
    return After(value0);
  }
}

class $DispatchTimeCodec with _i1.Codec<DispatchTime> {
  const $DispatchTimeCodec();

  @override
  DispatchTime decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return At._decode(input);
      case 1:
        return After._decode(input);
      default:
        throw Exception('DispatchTime: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    DispatchTime value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case At:
        (value as At).encodeTo(output);
        break;
      case After:
        (value as After).encodeTo(output);
        break;
      default:
        throw Exception(
            'DispatchTime: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(DispatchTime value) {
    switch (value.runtimeType) {
      case At:
        return (value as At)._sizeHint();
      case After:
        return (value as After)._sizeHint();
      default:
        throw Exception(
            'DispatchTime: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class At extends DispatchTime {
  const At(this.value0);

  factory At._decode(_i1.Input input) {
    return At(_i1.U32Codec.codec.decode(input));
  }

  /// BlockNumber
  final int value0;

  @override
  Map<String, int> toJson() => {'At': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
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
      other is At && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class After extends DispatchTime {
  const After(this.value0);

  factory After._decode(_i1.Input input) {
    return After(_i1.U32Codec.codec.decode(input));
  }

  /// BlockNumber
  final int value0;

  @override
  Map<String, int> toJson() => {'After': value0};

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
      other is After && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
