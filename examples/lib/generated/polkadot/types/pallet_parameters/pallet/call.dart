// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_runtime/runtime_parameters.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, Map<String, Map<String, List<dynamic>>>>> toJson();
}

class $Call {
  const $Call();

  SetParameter setParameter({required _i3.RuntimeParameters keyValue}) {
    return SetParameter(keyValue: keyValue);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SetParameter._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case SetParameter:
        (value as SetParameter).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SetParameter:
        return (value as SetParameter)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Set the value of a parameter.
///
/// The dispatch origin of this call must be `AdminOrigin` for the given `key`. Values be
/// deleted by setting them to `None`.
class SetParameter extends Call {
  const SetParameter({required this.keyValue});

  factory SetParameter._decode(_i1.Input input) {
    return SetParameter(keyValue: _i3.RuntimeParameters.codec.decode(input));
  }

  /// T::RuntimeParameters
  final _i3.RuntimeParameters keyValue;

  @override
  Map<String, Map<String, Map<String, Map<String, List<dynamic>>>>> toJson() =>
      {
        'set_parameter': {'keyValue': keyValue.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.RuntimeParameters.codec.sizeHint(keyValue);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.RuntimeParameters.codec.encodeTo(
      keyValue,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetParameter && other.keyValue == keyValue;

  @override
  int get hashCode => keyValue.hashCode;
}
