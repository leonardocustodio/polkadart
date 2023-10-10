// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../polkadot_runtime/npos_compact_solution16.dart' as _i2;
import '../sp_npos_elections/election_score.dart' as _i3;

class RawSolution {
  const RawSolution({
    required this.solution,
    required this.score,
    required this.round,
  });

  factory RawSolution.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// S
  final _i2.NposCompactSolution16 solution;

  /// ElectionScore
  final _i3.ElectionScore score;

  /// u32
  final int round;

  static const $RawSolutionCodec codec = $RawSolutionCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'solution': solution.toJson(),
        'score': score.toJson(),
        'round': round,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RawSolution &&
          other.solution == solution &&
          other.score == score &&
          other.round == round;

  @override
  int get hashCode => Object.hash(
        solution,
        score,
        round,
      );
}

class $RawSolutionCodec with _i1.Codec<RawSolution> {
  const $RawSolutionCodec();

  @override
  void encodeTo(
    RawSolution obj,
    _i1.Output output,
  ) {
    _i2.NposCompactSolution16.codec.encodeTo(
      obj.solution,
      output,
    );
    _i3.ElectionScore.codec.encodeTo(
      obj.score,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.round,
      output,
    );
  }

  @override
  RawSolution decode(_i1.Input input) {
    return RawSolution(
      solution: _i2.NposCompactSolution16.codec.decode(input),
      score: _i3.ElectionScore.codec.decode(input),
      round: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(RawSolution obj) {
    int size = 0;
    size = size + _i2.NposCompactSolution16.codec.sizeHint(obj.solution);
    size = size + _i3.ElectionScore.codec.sizeHint(obj.score);
    size = size + _i1.U32Codec.codec.sizeHint(obj.round);
    return size;
  }
}
