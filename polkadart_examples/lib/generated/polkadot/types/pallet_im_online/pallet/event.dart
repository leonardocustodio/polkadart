// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../pallet_staking/exposure.dart' as _i6;
import '../../sp_core/crypto/account_id32.dart' as _i5;
import '../../tuples.dart' as _i4;
import '../sr25519/app_sr25519/public.dart' as _i3;

///
///			The [event](https://docs.substrate.io/main-docs/build/events-errors/) emitted
///			by this pallet.
///
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

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  HeartbeatReceived heartbeatReceived({required _i3.Public authorityId}) {
    return HeartbeatReceived(authorityId: authorityId);
  }

  AllGood allGood() {
    return AllGood();
  }

  SomeOffline someOffline(
      {required List<_i4.Tuple2<_i5.AccountId32, _i6.Exposure>> offline}) {
    return SomeOffline(offline: offline);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return HeartbeatReceived._decode(input);
      case 1:
        return const AllGood();
      case 2:
        return SomeOffline._decode(input);
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
      case HeartbeatReceived:
        (value as HeartbeatReceived).encodeTo(output);
        break;
      case AllGood:
        (value as AllGood).encodeTo(output);
        break;
      case SomeOffline:
        (value as SomeOffline).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case HeartbeatReceived:
        return (value as HeartbeatReceived)._sizeHint();
      case AllGood:
        return 1;
      case SomeOffline:
        return (value as SomeOffline)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A new heartbeat was received from `AuthorityId`.
class HeartbeatReceived extends Event {
  const HeartbeatReceived({required this.authorityId});

  factory HeartbeatReceived._decode(_i1.Input input) {
    return HeartbeatReceived(
        authorityId: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AuthorityId
  final _i3.Public authorityId;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'HeartbeatReceived': {'authorityId': authorityId.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.PublicCodec().sizeHint(authorityId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      authorityId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HeartbeatReceived && other.authorityId == authorityId;

  @override
  int get hashCode => authorityId.hashCode;
}

/// At the end of the session, no offence was committed.
class AllGood extends Event {
  const AllGood();

  @override
  Map<String, dynamic> toJson() => {'AllGood': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is AllGood;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// At the end of the session, at least one validator was found to be offline.
class SomeOffline extends Event {
  const SomeOffline({required this.offline});

  factory SomeOffline._decode(_i1.Input input) {
    return SomeOffline(
        offline:
            const _i1.SequenceCodec<_i4.Tuple2<_i5.AccountId32, _i6.Exposure>>(
                _i4.Tuple2Codec<_i5.AccountId32, _i6.Exposure>(
      _i5.AccountId32Codec(),
      _i6.Exposure.codec,
    )).decode(input));
  }

  /// Vec<IdentificationTuple<T>>
  final List<_i4.Tuple2<_i5.AccountId32, _i6.Exposure>> offline;

  @override
  Map<String, Map<String, List<List<dynamic>>>> toJson() => {
        'SomeOffline': {
          'offline': offline
              .map((value) => [
                    value.value0.toList(),
                    value.value1.toJson(),
                  ])
              .toList()
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i4.Tuple2<_i5.AccountId32, _i6.Exposure>>(
            _i4.Tuple2Codec<_i5.AccountId32, _i6.Exposure>(
          _i5.AccountId32Codec(),
          _i6.Exposure.codec,
        )).sizeHint(offline);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<_i4.Tuple2<_i5.AccountId32, _i6.Exposure>>(
        _i4.Tuple2Codec<_i5.AccountId32, _i6.Exposure>(
      _i5.AccountId32Codec(),
      _i6.Exposure.codec,
    )).encodeTo(
      offline,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SomeOffline &&
          _i7.listsEqual(
            other.offline,
            offline,
          );

  @override
  int get hashCode => offline.hashCode;
}
