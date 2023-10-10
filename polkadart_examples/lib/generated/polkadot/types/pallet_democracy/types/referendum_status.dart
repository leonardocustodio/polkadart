// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../frame_support/traits/preimages/bounded.dart' as _i2;
import '../vote_threshold/vote_threshold.dart' as _i3;
import 'tally.dart' as _i4;

class ReferendumStatus {
  const ReferendumStatus({
    required this.end,
    required this.proposal,
    required this.threshold,
    required this.delay,
    required this.tally,
  });

  factory ReferendumStatus.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BlockNumber
  final int end;

  /// Proposal
  final _i2.Bounded proposal;

  /// VoteThreshold
  final _i3.VoteThreshold threshold;

  /// BlockNumber
  final int delay;

  /// Tally<Balance>
  final _i4.Tally tally;

  static const $ReferendumStatusCodec codec = $ReferendumStatusCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'end': end,
        'proposal': proposal.toJson(),
        'threshold': threshold.toJson(),
        'delay': delay,
        'tally': tally.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReferendumStatus &&
          other.end == end &&
          other.proposal == proposal &&
          other.threshold == threshold &&
          other.delay == delay &&
          other.tally == tally;

  @override
  int get hashCode => Object.hash(
        end,
        proposal,
        threshold,
        delay,
        tally,
      );
}

class $ReferendumStatusCodec with _i1.Codec<ReferendumStatus> {
  const $ReferendumStatusCodec();

  @override
  void encodeTo(
    ReferendumStatus obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.end,
      output,
    );
    _i2.Bounded.codec.encodeTo(
      obj.proposal,
      output,
    );
    _i3.VoteThreshold.codec.encodeTo(
      obj.threshold,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.delay,
      output,
    );
    _i4.Tally.codec.encodeTo(
      obj.tally,
      output,
    );
  }

  @override
  ReferendumStatus decode(_i1.Input input) {
    return ReferendumStatus(
      end: _i1.U32Codec.codec.decode(input),
      proposal: _i2.Bounded.codec.decode(input),
      threshold: _i3.VoteThreshold.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
      tally: _i4.Tally.codec.decode(input),
    );
  }

  @override
  int sizeHint(ReferendumStatus obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.end);
    size = size + _i2.Bounded.codec.sizeHint(obj.proposal);
    size = size + _i3.VoteThreshold.codec.sizeHint(obj.threshold);
    size = size + _i1.U32Codec.codec.sizeHint(obj.delay);
    size = size + _i4.Tally.codec.sizeHint(obj.tally);
    return size;
  }
}
