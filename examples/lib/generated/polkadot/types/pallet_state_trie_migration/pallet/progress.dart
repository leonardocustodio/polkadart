// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

abstract class Progress {
  const Progress();

  factory Progress.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ProgressCodec codec = $ProgressCodec();

  static const $Progress values = $Progress();

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

class $Progress {
  const $Progress();

  ToStart toStart() {
    return ToStart();
  }

  LastKey lastKey(List<int> value0) {
    return LastKey(value0);
  }

  Complete complete() {
    return Complete();
  }
}

class $ProgressCodec with _i1.Codec<Progress> {
  const $ProgressCodec();

  @override
  Progress decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const ToStart();
      case 1:
        return LastKey._decode(input);
      case 2:
        return const Complete();
      default:
        throw Exception('Progress: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Progress value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case ToStart:
        (value as ToStart).encodeTo(output);
        break;
      case LastKey:
        (value as LastKey).encodeTo(output);
        break;
      case Complete:
        (value as Complete).encodeTo(output);
        break;
      default:
        throw Exception(
            'Progress: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Progress value) {
    switch (value.runtimeType) {
      case ToStart:
        return 1;
      case LastKey:
        return (value as LastKey)._sizeHint();
      case Complete:
        return 1;
      default:
        throw Exception(
            'Progress: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class ToStart extends Progress {
  const ToStart();

  @override
  Map<String, dynamic> toJson() => {'ToStart': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ToStart;

  @override
  int get hashCode => runtimeType.hashCode;
}

class LastKey extends Progress {
  const LastKey(this.value0);

  factory LastKey._decode(_i1.Input input) {
    return LastKey(_i1.U8SequenceCodec.codec.decode(input));
  }

  /// BoundedVec<u8, MaxKeyLen>
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'LastKey': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
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
      other is LastKey &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Complete extends Progress {
  const Complete();

  @override
  Map<String, dynamic> toJson() => {'Complete': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Complete;

  @override
  int get hashCode => runtimeType.hashCode;
}
