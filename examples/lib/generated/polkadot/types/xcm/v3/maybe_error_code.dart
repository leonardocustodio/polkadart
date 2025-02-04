// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

abstract class MaybeErrorCode {
  const MaybeErrorCode();

  factory MaybeErrorCode.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $MaybeErrorCodeCodec codec = $MaybeErrorCodeCodec();

  static const $MaybeErrorCode values = $MaybeErrorCode();

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

class $MaybeErrorCode {
  const $MaybeErrorCode();

  Success success() {
    return Success();
  }

  Error error(List<int> value0) {
    return Error(value0);
  }

  TruncatedError truncatedError(List<int> value0) {
    return TruncatedError(value0);
  }
}

class $MaybeErrorCodeCodec with _i1.Codec<MaybeErrorCode> {
  const $MaybeErrorCodeCodec();

  @override
  MaybeErrorCode decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Success();
      case 1:
        return Error._decode(input);
      case 2:
        return TruncatedError._decode(input);
      default:
        throw Exception('MaybeErrorCode: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    MaybeErrorCode value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Success:
        (value as Success).encodeTo(output);
        break;
      case Error:
        (value as Error).encodeTo(output);
        break;
      case TruncatedError:
        (value as TruncatedError).encodeTo(output);
        break;
      default:
        throw Exception(
            'MaybeErrorCode: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(MaybeErrorCode value) {
    switch (value.runtimeType) {
      case Success:
        return 1;
      case Error:
        return (value as Error)._sizeHint();
      case TruncatedError:
        return (value as TruncatedError)._sizeHint();
      default:
        throw Exception(
            'MaybeErrorCode: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Success extends MaybeErrorCode {
  const Success();

  @override
  Map<String, dynamic> toJson() => {'Success': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Success;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Error extends MaybeErrorCode {
  const Error(this.value0);

  factory Error._decode(_i1.Input input) {
    return Error(_i1.U8SequenceCodec.codec.decode(input));
  }

  /// BoundedVec<u8, MaxDispatchErrorLen>
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Error': value0};

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
      other is Error &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class TruncatedError extends MaybeErrorCode {
  const TruncatedError(this.value0);

  factory TruncatedError._decode(_i1.Input input) {
    return TruncatedError(_i1.U8SequenceCodec.codec.decode(input));
  }

  /// BoundedVec<u8, MaxDispatchErrorLen>
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'TruncatedError': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is TruncatedError &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}
