// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i7;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../tuples.dart' as _i2;
import 'candidate_receipt.dart' as _i3;
import 'dispute_statement_set.dart' as _i6;
import 'validator_index.dart' as _i4;
import 'validity_attestation.dart' as _i5;

class ScrapedOnChainVotes {
  const ScrapedOnChainVotes({
    required this.session,
    required this.backingValidatorsPerCandidate,
    required this.disputes,
  });

  factory ScrapedOnChainVotes.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// SessionIndex
  final int session;

  /// Vec<(CandidateReceipt<H>, Vec<(ValidatorIndex, ValidityAttestation)>)
  ///>
  final List<
          _i2.Tuple2<_i3.CandidateReceipt,
              List<_i2.Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>>>
      backingValidatorsPerCandidate;

  /// MultiDisputeStatementSet
  final List<_i6.DisputeStatementSet> disputes;

  static const $ScrapedOnChainVotesCodec codec = $ScrapedOnChainVotesCodec();

  _i7.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'session': session,
        'backingValidatorsPerCandidate': backingValidatorsPerCandidate
            .map((value) => [
                  value.value0.toJson(),
                  value.value1
                      .map((value) => [
                            value.value0,
                            value.value1.toJson(),
                          ])
                      .toList(),
                ])
            .toList(),
        'disputes': disputes.map((value) => value.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ScrapedOnChainVotes &&
          other.session == session &&
          _i8.listsEqual(
            other.backingValidatorsPerCandidate,
            backingValidatorsPerCandidate,
          ) &&
          _i8.listsEqual(
            other.disputes,
            disputes,
          );

  @override
  int get hashCode => Object.hash(
        session,
        backingValidatorsPerCandidate,
        disputes,
      );
}

class $ScrapedOnChainVotesCodec with _i1.Codec<ScrapedOnChainVotes> {
  const $ScrapedOnChainVotesCodec();

  @override
  void encodeTo(
    ScrapedOnChainVotes obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.session,
      output,
    );
    const _i1.SequenceCodec<
            _i2.Tuple2<_i3.CandidateReceipt,
                List<_i2.Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>>>(
        _i2.Tuple2Codec<_i3.CandidateReceipt,
            List<_i2.Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>>(
      _i3.CandidateReceipt.codec,
      _i1.SequenceCodec<
              _i2.Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>(
          _i2.Tuple2Codec<_i4.ValidatorIndex, _i5.ValidityAttestation>(
        _i4.ValidatorIndexCodec(),
        _i5.ValidityAttestation.codec,
      )),
    )).encodeTo(
      obj.backingValidatorsPerCandidate,
      output,
    );
    const _i1.SequenceCodec<_i6.DisputeStatementSet>(
            _i6.DisputeStatementSet.codec)
        .encodeTo(
      obj.disputes,
      output,
    );
  }

  @override
  ScrapedOnChainVotes decode(_i1.Input input) {
    return ScrapedOnChainVotes(
      session: _i1.U32Codec.codec.decode(input),
      backingValidatorsPerCandidate: const _i1.SequenceCodec<
              _i2.Tuple2<
                  _i3.CandidateReceipt,
                  List<
                      _i2
                      .Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>>>(
          _i2.Tuple2Codec<_i3.CandidateReceipt,
              List<_i2.Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>>(
        _i3.CandidateReceipt.codec,
        _i1.SequenceCodec<
                _i2.Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>(
            _i2.Tuple2Codec<_i4.ValidatorIndex, _i5.ValidityAttestation>(
          _i4.ValidatorIndexCodec(),
          _i5.ValidityAttestation.codec,
        )),
      )).decode(input),
      disputes: const _i1.SequenceCodec<_i6.DisputeStatementSet>(
              _i6.DisputeStatementSet.codec)
          .decode(input),
    );
  }

  @override
  int sizeHint(ScrapedOnChainVotes obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.session);
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple2<
                    _i3.CandidateReceipt,
                    List<
                        _i2
                        .Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>>>(
            _i2.Tuple2Codec<_i3.CandidateReceipt,
                List<_i2.Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>>(
          _i3.CandidateReceipt.codec,
          _i1.SequenceCodec<
                  _i2.Tuple2<_i4.ValidatorIndex, _i5.ValidityAttestation>>(
              _i2.Tuple2Codec<_i4.ValidatorIndex, _i5.ValidityAttestation>(
            _i4.ValidatorIndexCodec(),
            _i5.ValidityAttestation.codec,
          )),
        )).sizeHint(obj.backingValidatorsPerCandidate);
    size = size +
        const _i1.SequenceCodec<_i6.DisputeStatementSet>(
                _i6.DisputeStatementSet.codec)
            .sizeHint(obj.disputes);
    return size;
  }
}
