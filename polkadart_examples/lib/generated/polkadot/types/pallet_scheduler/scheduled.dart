// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../frame_support/traits/preimages/bounded.dart' as _i2;
import '../polkadot_runtime/origin_caller.dart' as _i4;
import '../tuples_1.dart' as _i3;

class Scheduled {
  const Scheduled({
    this.maybeId,
    required this.priority,
    required this.call,
    this.maybePeriodic,
    required this.origin,
  });

  factory Scheduled.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Option<Name>
  final List<int>? maybeId;

  /// schedule::Priority
  final int priority;

  /// Call
  final _i2.Bounded call;

  /// Option<schedule::Period<BlockNumber>>
  final _i3.Tuple2<int, int>? maybePeriodic;

  /// PalletsOrigin
  final _i4.OriginCaller origin;

  static const $ScheduledCodec codec = $ScheduledCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'maybeId': maybeId?.toList(),
        'priority': priority,
        'call': call.toJson(),
        'maybePeriodic': [
          maybePeriodic?.value0,
          maybePeriodic?.value1,
        ],
        'origin': origin.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Scheduled &&
          other.maybeId == maybeId &&
          other.priority == priority &&
          other.call == call &&
          other.maybePeriodic == maybePeriodic &&
          other.origin == origin;

  @override
  int get hashCode => Object.hash(
        maybeId,
        priority,
        call,
        maybePeriodic,
        origin,
      );
}

class $ScheduledCodec with _i1.Codec<Scheduled> {
  const $ScheduledCodec();

  @override
  void encodeTo(
    Scheduled obj,
    _i1.Output output,
  ) {
    const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).encodeTo(
      obj.maybeId,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      obj.priority,
      output,
    );
    _i2.Bounded.codec.encodeTo(
      obj.call,
      output,
    );
    const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
      _i1.U32Codec.codec,
      _i1.U32Codec.codec,
    )).encodeTo(
      obj.maybePeriodic,
      output,
    );
    _i4.OriginCaller.codec.encodeTo(
      obj.origin,
      output,
    );
  }

  @override
  Scheduled decode(_i1.Input input) {
    return Scheduled(
      maybeId:
          const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).decode(input),
      priority: _i1.U8Codec.codec.decode(input),
      call: _i2.Bounded.codec.decode(input),
      maybePeriodic:
          const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      )).decode(input),
      origin: _i4.OriginCaller.codec.decode(input),
    );
  }

  @override
  int sizeHint(Scheduled obj) {
    int size = 0;
    size = size +
        const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32))
            .sizeHint(obj.maybeId);
    size = size + _i1.U8Codec.codec.sizeHint(obj.priority);
    size = size + _i2.Bounded.codec.sizeHint(obj.call);
    size = size +
        const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        )).sizeHint(obj.maybePeriodic);
    size = size + _i4.OriginCaller.codec.sizeHint(obj.origin);
    return size;
  }
}
