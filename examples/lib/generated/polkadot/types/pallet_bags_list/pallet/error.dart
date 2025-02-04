// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../list/list_error.dart' as _i3;

/// The `Error` enum of this pallet.
abstract class Error {
  const Error();

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ErrorCodec codec = $ErrorCodec();

  static const $Error values = $Error();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, String> toJson();
}

class $Error {
  const $Error();

  ListVariant listVariant(_i3.ListError value0) {
    return ListVariant(value0);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ListVariant._decode(input);
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case ListVariant:
        (value as ListVariant).encodeTo(output);
        break;
      default:
        throw Exception(
            'Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Error value) {
    switch (value.runtimeType) {
      case ListVariant:
        return (value as ListVariant)._sizeHint();
      default:
        throw Exception(
            'Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A error in the list interface implementation.
class ListVariant extends Error {
  const ListVariant(this.value0);

  factory ListVariant._decode(_i1.Input input) {
    return ListVariant(_i3.ListError.codec.decode(input));
  }

  /// ListError
  final _i3.ListError value0;

  @override
  Map<String, String> toJson() => {'List': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ListError.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ListError.codec.encodeTo(
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
      other is ListVariant && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
