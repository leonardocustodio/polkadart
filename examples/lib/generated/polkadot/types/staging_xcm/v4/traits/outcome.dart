// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../sp_weights/weight_v2/weight.dart' as _i3;
import '../../../xcm/v3/traits/error.dart' as _i4;

abstract class Outcome {
  const Outcome();

  factory Outcome.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $OutcomeCodec codec = $OutcomeCodec();

  static const $Outcome values = $Outcome();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, Map<String, dynamic>>> toJson();
}

class $Outcome {
  const $Outcome();

  Complete complete({required _i3.Weight used}) {
    return Complete(used: used);
  }

  Incomplete incomplete({
    required _i3.Weight used,
    required _i4.Error error,
  }) {
    return Incomplete(
      used: used,
      error: error,
    );
  }

  Error error({required _i4.Error error}) {
    return Error(error: error);
  }
}

class $OutcomeCodec with _i1.Codec<Outcome> {
  const $OutcomeCodec();

  @override
  Outcome decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Complete._decode(input);
      case 1:
        return Incomplete._decode(input);
      case 2:
        return Error._decode(input);
      default:
        throw Exception('Outcome: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Outcome value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Complete:
        (value as Complete).encodeTo(output);
        break;
      case Incomplete:
        (value as Incomplete).encodeTo(output);
        break;
      case Error:
        (value as Error).encodeTo(output);
        break;
      default:
        throw Exception(
            'Outcome: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Outcome value) {
    switch (value.runtimeType) {
      case Complete:
        return (value as Complete)._sizeHint();
      case Incomplete:
        return (value as Incomplete)._sizeHint();
      case Error:
        return (value as Error)._sizeHint();
      default:
        throw Exception(
            'Outcome: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Complete extends Outcome {
  const Complete({required this.used});

  factory Complete._decode(_i1.Input input) {
    return Complete(used: _i3.Weight.codec.decode(input));
  }

  /// Weight
  final _i3.Weight used;

  @override
  Map<String, Map<String, Map<String, BigInt>>> toJson() => {
        'Complete': {'used': used.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(used);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Weight.codec.encodeTo(
      used,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Complete && other.used == used;

  @override
  int get hashCode => used.hashCode;
}

class Incomplete extends Outcome {
  const Incomplete({
    required this.used,
    required this.error,
  });

  factory Incomplete._decode(_i1.Input input) {
    return Incomplete(
      used: _i3.Weight.codec.decode(input),
      error: _i4.Error.codec.decode(input),
    );
  }

  /// Weight
  final _i3.Weight used;

  /// Error
  final _i4.Error error;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'Incomplete': {
          'used': used.toJson(),
          'error': error.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Weight.codec.sizeHint(used);
    size = size + _i4.Error.codec.sizeHint(error);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.Weight.codec.encodeTo(
      used,
      output,
    );
    _i4.Error.codec.encodeTo(
      error,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Incomplete && other.used == used && other.error == error;

  @override
  int get hashCode => Object.hash(
        used,
        error,
      );
}

class Error extends Outcome {
  const Error({required this.error});

  factory Error._decode(_i1.Input input) {
    return Error(error: _i4.Error.codec.decode(input));
  }

  /// Error
  final _i4.Error error;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'Error': {'error': error.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Error.codec.sizeHint(error);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i4.Error.codec.encodeTo(
      error,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Error && other.error == error;

  @override
  int get hashCode => error.hashCode;
}
