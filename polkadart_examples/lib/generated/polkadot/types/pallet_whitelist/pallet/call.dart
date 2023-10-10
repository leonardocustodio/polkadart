// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../polkadot_runtime/runtime_call.dart' as _i5;
import '../../primitive_types/h256.dart' as _i3;
import '../../sp_weights/weight_v2/weight.dart' as _i4;

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

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  WhitelistCall whitelistCall({required _i3.H256 callHash}) {
    return WhitelistCall(callHash: callHash);
  }

  RemoveWhitelistedCall removeWhitelistedCall({required _i3.H256 callHash}) {
    return RemoveWhitelistedCall(callHash: callHash);
  }

  DispatchWhitelistedCall dispatchWhitelistedCall({
    required _i3.H256 callHash,
    required int callEncodedLen,
    required _i4.Weight callWeightWitness,
  }) {
    return DispatchWhitelistedCall(
      callHash: callHash,
      callEncodedLen: callEncodedLen,
      callWeightWitness: callWeightWitness,
    );
  }

  DispatchWhitelistedCallWithPreimage dispatchWhitelistedCallWithPreimage(
      {required _i5.RuntimeCall call}) {
    return DispatchWhitelistedCallWithPreimage(call: call);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return WhitelistCall._decode(input);
      case 1:
        return RemoveWhitelistedCall._decode(input);
      case 2:
        return DispatchWhitelistedCall._decode(input);
      case 3:
        return DispatchWhitelistedCallWithPreimage._decode(input);
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
      case WhitelistCall:
        (value as WhitelistCall).encodeTo(output);
        break;
      case RemoveWhitelistedCall:
        (value as RemoveWhitelistedCall).encodeTo(output);
        break;
      case DispatchWhitelistedCall:
        (value as DispatchWhitelistedCall).encodeTo(output);
        break;
      case DispatchWhitelistedCallWithPreimage:
        (value as DispatchWhitelistedCallWithPreimage).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case WhitelistCall:
        return (value as WhitelistCall)._sizeHint();
      case RemoveWhitelistedCall:
        return (value as RemoveWhitelistedCall)._sizeHint();
      case DispatchWhitelistedCall:
        return (value as DispatchWhitelistedCall)._sizeHint();
      case DispatchWhitelistedCallWithPreimage:
        return (value as DispatchWhitelistedCallWithPreimage)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class WhitelistCall extends Call {
  const WhitelistCall({required this.callHash});

  factory WhitelistCall._decode(_i1.Input input) {
    return WhitelistCall(callHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// PreimageHash
  final _i3.H256 callHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'whitelist_call': {'callHash': callHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WhitelistCall &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => callHash.hashCode;
}

class RemoveWhitelistedCall extends Call {
  const RemoveWhitelistedCall({required this.callHash});

  factory RemoveWhitelistedCall._decode(_i1.Input input) {
    return RemoveWhitelistedCall(
        callHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// PreimageHash
  final _i3.H256 callHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'remove_whitelisted_call': {'callHash': callHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveWhitelistedCall &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => callHash.hashCode;
}

class DispatchWhitelistedCall extends Call {
  const DispatchWhitelistedCall({
    required this.callHash,
    required this.callEncodedLen,
    required this.callWeightWitness,
  });

  factory DispatchWhitelistedCall._decode(_i1.Input input) {
    return DispatchWhitelistedCall(
      callHash: const _i1.U8ArrayCodec(32).decode(input),
      callEncodedLen: _i1.U32Codec.codec.decode(input),
      callWeightWitness: _i4.Weight.codec.decode(input),
    );
  }

  /// PreimageHash
  final _i3.H256 callHash;

  /// u32
  final int callEncodedLen;

  /// Weight
  final _i4.Weight callWeightWitness;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'dispatch_whitelisted_call': {
          'callHash': callHash.toList(),
          'callEncodedLen': callEncodedLen,
          'callWeightWitness': callWeightWitness.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(callHash);
    size = size + _i1.U32Codec.codec.sizeHint(callEncodedLen);
    size = size + _i4.Weight.codec.sizeHint(callWeightWitness);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      callEncodedLen,
      output,
    );
    _i4.Weight.codec.encodeTo(
      callWeightWitness,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DispatchWhitelistedCall &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          ) &&
          other.callEncodedLen == callEncodedLen &&
          other.callWeightWitness == callWeightWitness;

  @override
  int get hashCode => Object.hash(
        callHash,
        callEncodedLen,
        callWeightWitness,
      );
}

class DispatchWhitelistedCallWithPreimage extends Call {
  const DispatchWhitelistedCallWithPreimage({required this.call});

  factory DispatchWhitelistedCallWithPreimage._decode(_i1.Input input) {
    return DispatchWhitelistedCallWithPreimage(
        call: _i5.RuntimeCall.codec.decode(input));
  }

  /// Box<<T as Config>::RuntimeCall>
  final _i5.RuntimeCall call;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'dispatch_whitelisted_call_with_preimage': {'call': call.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i5.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i5.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DispatchWhitelistedCallWithPreimage && other.call == call;

  @override
  int get hashCode => call.hashCode;
}
