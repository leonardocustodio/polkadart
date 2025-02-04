// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i10;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../frame_support/traits/preimages/bounded.dart' as _i3;
import '../../frame_support/traits/schedule/dispatch_time.dart' as _i4;
import '../../pallet_conviction_voting/types/tally.dart' as _i7;
import '../../polkadot_runtime/origin_caller.dart' as _i2;
import '../../tuples.dart' as _i8;
import '../../tuples_1.dart' as _i9;
import 'deciding_status.dart' as _i6;
import 'deposit.dart' as _i5;

class ReferendumStatus {
  const ReferendumStatus({
    required this.track,
    required this.origin,
    required this.proposal,
    required this.enactment,
    required this.submitted,
    required this.submissionDeposit,
    this.decisionDeposit,
    this.deciding,
    required this.tally,
    required this.inQueue,
    this.alarm,
  });

  factory ReferendumStatus.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// TrackId
  final int track;

  /// RuntimeOrigin
  final _i2.OriginCaller origin;

  /// Call
  final _i3.Bounded proposal;

  /// DispatchTime<Moment>
  final _i4.DispatchTime enactment;

  /// Moment
  final int submitted;

  /// Deposit<AccountId, Balance>
  final _i5.Deposit submissionDeposit;

  /// Option<Deposit<AccountId, Balance>>
  final _i5.Deposit? decisionDeposit;

  /// Option<DecidingStatus<Moment>>
  final _i6.DecidingStatus? deciding;

  /// Tally
  final _i7.Tally tally;

  /// bool
  final bool inQueue;

  /// Option<(Moment, ScheduleAddress)>
  final _i8.Tuple2<int, _i9.Tuple2<int, int>>? alarm;

  static const $ReferendumStatusCodec codec = $ReferendumStatusCodec();

  _i10.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'track': track,
        'origin': origin.toJson(),
        'proposal': proposal.toJson(),
        'enactment': enactment.toJson(),
        'submitted': submitted,
        'submissionDeposit': submissionDeposit.toJson(),
        'decisionDeposit': decisionDeposit?.toJson(),
        'deciding': deciding?.toJson(),
        'tally': tally.toJson(),
        'inQueue': inQueue,
        'alarm': [
          alarm?.value0,
          [
            alarm?.value1.value0,
            alarm?.value1.value1,
          ],
        ],
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReferendumStatus &&
          other.track == track &&
          other.origin == origin &&
          other.proposal == proposal &&
          other.enactment == enactment &&
          other.submitted == submitted &&
          other.submissionDeposit == submissionDeposit &&
          other.decisionDeposit == decisionDeposit &&
          other.deciding == deciding &&
          other.tally == tally &&
          other.inQueue == inQueue &&
          other.alarm == alarm;

  @override
  int get hashCode => Object.hash(
        track,
        origin,
        proposal,
        enactment,
        submitted,
        submissionDeposit,
        decisionDeposit,
        deciding,
        tally,
        inQueue,
        alarm,
      );
}

class $ReferendumStatusCodec with _i1.Codec<ReferendumStatus> {
  const $ReferendumStatusCodec();

  @override
  void encodeTo(
    ReferendumStatus obj,
    _i1.Output output,
  ) {
    _i1.U16Codec.codec.encodeTo(
      obj.track,
      output,
    );
    _i2.OriginCaller.codec.encodeTo(
      obj.origin,
      output,
    );
    _i3.Bounded.codec.encodeTo(
      obj.proposal,
      output,
    );
    _i4.DispatchTime.codec.encodeTo(
      obj.enactment,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.submitted,
      output,
    );
    _i5.Deposit.codec.encodeTo(
      obj.submissionDeposit,
      output,
    );
    const _i1.OptionCodec<_i5.Deposit>(_i5.Deposit.codec).encodeTo(
      obj.decisionDeposit,
      output,
    );
    const _i1.OptionCodec<_i6.DecidingStatus>(_i6.DecidingStatus.codec)
        .encodeTo(
      obj.deciding,
      output,
    );
    _i7.Tally.codec.encodeTo(
      obj.tally,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.inQueue,
      output,
    );
    const _i1.OptionCodec<_i8.Tuple2<int, _i9.Tuple2<int, int>>>(
        _i8.Tuple2Codec<int, _i9.Tuple2<int, int>>(
      _i1.U32Codec.codec,
      _i9.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      ),
    )).encodeTo(
      obj.alarm,
      output,
    );
  }

  @override
  ReferendumStatus decode(_i1.Input input) {
    return ReferendumStatus(
      track: _i1.U16Codec.codec.decode(input),
      origin: _i2.OriginCaller.codec.decode(input),
      proposal: _i3.Bounded.codec.decode(input),
      enactment: _i4.DispatchTime.codec.decode(input),
      submitted: _i1.U32Codec.codec.decode(input),
      submissionDeposit: _i5.Deposit.codec.decode(input),
      decisionDeposit:
          const _i1.OptionCodec<_i5.Deposit>(_i5.Deposit.codec).decode(input),
      deciding:
          const _i1.OptionCodec<_i6.DecidingStatus>(_i6.DecidingStatus.codec)
              .decode(input),
      tally: _i7.Tally.codec.decode(input),
      inQueue: _i1.BoolCodec.codec.decode(input),
      alarm: const _i1.OptionCodec<_i8.Tuple2<int, _i9.Tuple2<int, int>>>(
          _i8.Tuple2Codec<int, _i9.Tuple2<int, int>>(
        _i1.U32Codec.codec,
        _i9.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        ),
      )).decode(input),
    );
  }

  @override
  int sizeHint(ReferendumStatus obj) {
    int size = 0;
    size = size + _i1.U16Codec.codec.sizeHint(obj.track);
    size = size + _i2.OriginCaller.codec.sizeHint(obj.origin);
    size = size + _i3.Bounded.codec.sizeHint(obj.proposal);
    size = size + _i4.DispatchTime.codec.sizeHint(obj.enactment);
    size = size + _i1.U32Codec.codec.sizeHint(obj.submitted);
    size = size + _i5.Deposit.codec.sizeHint(obj.submissionDeposit);
    size = size +
        const _i1.OptionCodec<_i5.Deposit>(_i5.Deposit.codec)
            .sizeHint(obj.decisionDeposit);
    size = size +
        const _i1.OptionCodec<_i6.DecidingStatus>(_i6.DecidingStatus.codec)
            .sizeHint(obj.deciding);
    size = size + _i7.Tally.codec.sizeHint(obj.tally);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.inQueue);
    size = size +
        const _i1.OptionCodec<_i8.Tuple2<int, _i9.Tuple2<int, int>>>(
            _i8.Tuple2Codec<int, _i9.Tuple2<int, int>>(
          _i1.U32Codec.codec,
          _i9.Tuple2Codec<int, int>(
            _i1.U32Codec.codec,
            _i1.U32Codec.codec,
          ),
        )).sizeHint(obj.alarm);
    return size;
  }
}
