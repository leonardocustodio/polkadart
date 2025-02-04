// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'vote_message.dart' as _i2;

class DoubleVotingProof {
  const DoubleVotingProof({
    required this.first,
    required this.second,
  });

  factory DoubleVotingProof.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// VoteMessage<Number, Id, Signature>
  final _i2.VoteMessage first;

  /// VoteMessage<Number, Id, Signature>
  final _i2.VoteMessage second;

  static const $DoubleVotingProofCodec codec = $DoubleVotingProofCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, dynamic>> toJson() => {
        'first': first.toJson(),
        'second': second.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DoubleVotingProof &&
          other.first == first &&
          other.second == second;

  @override
  int get hashCode => Object.hash(
        first,
        second,
      );
}

class $DoubleVotingProofCodec with _i1.Codec<DoubleVotingProof> {
  const $DoubleVotingProofCodec();

  @override
  void encodeTo(
    DoubleVotingProof obj,
    _i1.Output output,
  ) {
    _i2.VoteMessage.codec.encodeTo(
      obj.first,
      output,
    );
    _i2.VoteMessage.codec.encodeTo(
      obj.second,
      output,
    );
  }

  @override
  DoubleVotingProof decode(_i1.Input input) {
    return DoubleVotingProof(
      first: _i2.VoteMessage.codec.decode(input),
      second: _i2.VoteMessage.codec.decode(input),
    );
  }

  @override
  int sizeHint(DoubleVotingProof obj) {
    int size = 0;
    size = size + _i2.VoteMessage.codec.sizeHint(obj.first);
    size = size + _i2.VoteMessage.codec.sizeHint(obj.second);
    return size;
  }
}
