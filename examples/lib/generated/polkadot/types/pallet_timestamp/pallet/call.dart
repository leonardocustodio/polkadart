// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

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

  Map<String, Map<String, BigInt>> toJson();
}

class $Call {
  const $Call();

  Set set({required BigInt now}) {
    return Set(now: now);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Set._decode(input);
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
      case Set:
        (value as Set).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Set:
        return (value as Set)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Set the current time.
///
/// This call should be invoked exactly once per block. It will panic at the finalization
/// phase, if this call hasn't been invoked by that time.
///
/// The timestamp should be greater than the previous one by the amount specified by
/// [`Config::MinimumPeriod`].
///
/// The dispatch origin for this call must be _None_.
///
/// This dispatch class is _Mandatory_ to ensure it gets executed in the block. Be aware
/// that changing the complexity of this call could result exhausting the resources in a
/// block to execute any other calls.
///
/// ## Complexity
/// - `O(1)` (Note that implementations of `OnTimestampSet` must also be `O(1)`)
/// - 1 storage read and 1 storage mutation (codec `O(1)` because of `DidUpdate::take` in
///  `on_finalize`)
/// - 1 event handler `on_timestamp_set`. Must be `O(1)`.
class Set extends Call {
  const Set({required this.now});

  factory Set._decode(_i1.Input input) {
    return Set(now: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// T::Moment
  final BigInt now;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set': {'now': now}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(now);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      now,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Set && other.now == now;

  @override
  int get hashCode => now.hashCode;
}
