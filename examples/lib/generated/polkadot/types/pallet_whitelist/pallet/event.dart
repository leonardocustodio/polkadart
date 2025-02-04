// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../frame_support/dispatch/post_dispatch_info.dart' as _i4;
import '../../primitive_types/h256.dart' as _i3;
import '../../sp_runtime/dispatch_error_with_post_info.dart' as _i5;

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

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  CallWhitelisted callWhitelisted({required _i3.H256 callHash}) {
    return CallWhitelisted(callHash: callHash);
  }

  WhitelistedCallRemoved whitelistedCallRemoved({required _i3.H256 callHash}) {
    return WhitelistedCallRemoved(callHash: callHash);
  }

  WhitelistedCallDispatched whitelistedCallDispatched({
    required _i3.H256 callHash,
    required _i1.Result<_i4.PostDispatchInfo, _i5.DispatchErrorWithPostInfo>
        result,
  }) {
    return WhitelistedCallDispatched(
      callHash: callHash,
      result: result,
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
        return CallWhitelisted._decode(input);
      case 1:
        return WhitelistedCallRemoved._decode(input);
      case 2:
        return WhitelistedCallDispatched._decode(input);
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
      case CallWhitelisted:
        (value as CallWhitelisted).encodeTo(output);
        break;
      case WhitelistedCallRemoved:
        (value as WhitelistedCallRemoved).encodeTo(output);
        break;
      case WhitelistedCallDispatched:
        (value as WhitelistedCallDispatched).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case CallWhitelisted:
        return (value as CallWhitelisted)._sizeHint();
      case WhitelistedCallRemoved:
        return (value as WhitelistedCallRemoved)._sizeHint();
      case WhitelistedCallDispatched:
        return (value as WhitelistedCallDispatched)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class CallWhitelisted extends Event {
  const CallWhitelisted({required this.callHash});

  factory CallWhitelisted._decode(_i1.Input input) {
    return CallWhitelisted(callHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 callHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'CallWhitelisted': {'callHash': callHash.toList()}
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
      other is CallWhitelisted &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => callHash.hashCode;
}

class WhitelistedCallRemoved extends Event {
  const WhitelistedCallRemoved({required this.callHash});

  factory WhitelistedCallRemoved._decode(_i1.Input input) {
    return WhitelistedCallRemoved(
        callHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 callHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'WhitelistedCallRemoved': {'callHash': callHash.toList()}
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
      other is WhitelistedCallRemoved &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => callHash.hashCode;
}

class WhitelistedCallDispatched extends Event {
  const WhitelistedCallDispatched({
    required this.callHash,
    required this.result,
  });

  factory WhitelistedCallDispatched._decode(_i1.Input input) {
    return WhitelistedCallDispatched(
      callHash: const _i1.U8ArrayCodec(32).decode(input),
      result: const _i1
          .ResultCodec<_i4.PostDispatchInfo, _i5.DispatchErrorWithPostInfo>(
        _i4.PostDispatchInfo.codec,
        _i5.DispatchErrorWithPostInfo.codec,
      ).decode(input),
    );
  }

  /// T::Hash
  final _i3.H256 callHash;

  /// DispatchResultWithPostInfo
  final _i1.Result<_i4.PostDispatchInfo, _i5.DispatchErrorWithPostInfo> result;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'WhitelistedCallDispatched': {
          'callHash': callHash.toList(),
          'result': result.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(callHash);
    size = size +
        const _i1
            .ResultCodec<_i4.PostDispatchInfo, _i5.DispatchErrorWithPostInfo>(
          _i4.PostDispatchInfo.codec,
          _i5.DispatchErrorWithPostInfo.codec,
        ).sizeHint(result);
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
    const _i1.ResultCodec<_i4.PostDispatchInfo, _i5.DispatchErrorWithPostInfo>(
      _i4.PostDispatchInfo.codec,
      _i5.DispatchErrorWithPostInfo.codec,
    ).encodeTo(
      result,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WhitelistedCallDispatched &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          ) &&
          other.result == result;

  @override
  int get hashCode => Object.hash(
        callHash,
        result,
      );
}
