// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_runtime/runtime_parameters_key.dart' as _i3;
import '../../polkadot_runtime/runtime_parameters_value.dart' as _i4;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, Map<String, Map<String, dynamic>>?>> toJson();
}

class $Event {
  const $Event();

  Updated updated({
    required _i3.RuntimeParametersKey key,
    _i4.RuntimeParametersValue? oldValue,
    _i4.RuntimeParametersValue? newValue,
  }) {
    return Updated(
      key: key,
      oldValue: oldValue,
      newValue: newValue,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Updated._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Updated:
        (value as Updated).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Updated:
        return (value as Updated)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A Parameter was set.
///
/// Is also emitted when the value was not changed.
class Updated extends Event {
  const Updated({
    required this.key,
    this.oldValue,
    this.newValue,
  });

  factory Updated._decode(_i1.Input input) {
    return Updated(
      key: _i3.RuntimeParametersKey.codec.decode(input),
      oldValue: const _i1.OptionCodec<_i4.RuntimeParametersValue>(
              _i4.RuntimeParametersValue.codec)
          .decode(input),
      newValue: const _i1.OptionCodec<_i4.RuntimeParametersValue>(
              _i4.RuntimeParametersValue.codec)
          .decode(input),
    );
  }

  /// <T::RuntimeParameters as AggregatedKeyValue>::Key
  /// The key that was updated.
  final _i3.RuntimeParametersKey key;

  /// Option<<T::RuntimeParameters as AggregatedKeyValue>::Value>
  /// The old value before this call.
  final _i4.RuntimeParametersValue? oldValue;

  /// Option<<T::RuntimeParameters as AggregatedKeyValue>::Value>
  /// The new value after this call.
  final _i4.RuntimeParametersValue? newValue;

  @override
  Map<String, Map<String, Map<String, Map<String, dynamic>>?>> toJson() => {
        'Updated': {
          'key': key.toJson(),
          'oldValue': oldValue?.toJson(),
          'newValue': newValue?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.RuntimeParametersKey.codec.sizeHint(key);
    size = size +
        const _i1.OptionCodec<_i4.RuntimeParametersValue>(
                _i4.RuntimeParametersValue.codec)
            .sizeHint(oldValue);
    size = size +
        const _i1.OptionCodec<_i4.RuntimeParametersValue>(
                _i4.RuntimeParametersValue.codec)
            .sizeHint(newValue);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.RuntimeParametersKey.codec.encodeTo(
      key,
      output,
    );
    const _i1.OptionCodec<_i4.RuntimeParametersValue>(
            _i4.RuntimeParametersValue.codec)
        .encodeTo(
      oldValue,
      output,
    );
    const _i1.OptionCodec<_i4.RuntimeParametersValue>(
            _i4.RuntimeParametersValue.codec)
        .encodeTo(
      newValue,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Updated &&
          other.key == key &&
          other.oldValue == oldValue &&
          other.newValue == newValue;

  @override
  int get hashCode => Object.hash(
        key,
        oldValue,
        newValue,
      );
}
