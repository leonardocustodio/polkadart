// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../polkadot_runtime/session_keys.dart' as _i3;

/// Contains one variant per dispatchable that can be called by an extrinsic.
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

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  SetKeys setKeys({
    required _i3.SessionKeys keys,
    required List<int> proof,
  }) {
    return SetKeys(
      keys: keys,
      proof: proof,
    );
  }

  PurgeKeys purgeKeys() {
    return PurgeKeys();
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SetKeys._decode(input);
      case 1:
        return const PurgeKeys();
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
      case SetKeys:
        (value as SetKeys).encodeTo(output);
        break;
      case PurgeKeys:
        (value as PurgeKeys).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SetKeys:
        return (value as SetKeys)._sizeHint();
      case PurgeKeys:
        return 1;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Sets the session key(s) of the function caller to `keys`.
/// Allows an account to set its session key prior to becoming a validator.
/// This doesn't take effect until the next session.
///
/// The dispatch origin of this function must be signed.
///
/// ## Complexity
/// - `O(1)`. Actual cost depends on the number of length of `T::Keys::key_ids()` which is
///  fixed.
class SetKeys extends Call {
  const SetKeys({
    required this.keys,
    required this.proof,
  });

  factory SetKeys._decode(_i1.Input input) {
    return SetKeys(
      keys: _i3.SessionKeys.codec.decode(input),
      proof: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::Keys
  final _i3.SessionKeys keys;

  /// Vec<u8>
  final List<int> proof;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_keys': {
          'keys': keys.toJson(),
          'proof': proof,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.SessionKeys.codec.sizeHint(keys);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(proof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.SessionKeys.codec.encodeTo(
      keys,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      proof,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetKeys &&
          other.keys == keys &&
          _i4.listsEqual(
            other.proof,
            proof,
          );

  @override
  int get hashCode => Object.hash(
        keys,
        proof,
      );
}

/// Removes any session key(s) of the function caller.
///
/// This doesn't take effect until the next session.
///
/// The dispatch origin of this function must be Signed and the account must be either be
/// convertible to a validator ID using the chain's typical addressing system (this usually
/// means being a controller account) or directly convertible into a validator ID (which
/// usually means being a stash account).
///
/// ## Complexity
/// - `O(1)` in number of key types. Actual cost depends on the number of length of
///  `T::Keys::key_ids()` which is fixed.
class PurgeKeys extends Call {
  const PurgeKeys();

  @override
  Map<String, dynamic> toJson() => {'purge_keys': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is PurgeKeys;

  @override
  int get hashCode => runtimeType.hashCode;
}
