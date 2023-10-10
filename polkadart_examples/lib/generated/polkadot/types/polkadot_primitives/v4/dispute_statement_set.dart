// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i7;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../polkadot_core_primitives/candidate_hash.dart' as _i2;
import '../../tuples.dart' as _i3;
import 'dispute_statement.dart' as _i4;
import 'validator_app/signature.dart' as _i6;
import 'validator_index.dart' as _i5;

class DisputeStatementSet {
  const DisputeStatementSet({
    required this.candidateHash,
    required this.session,
    required this.statements,
  });

  factory DisputeStatementSet.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CandidateHash
  final _i2.CandidateHash candidateHash;

  /// SessionIndex
  final int session;

  /// Vec<(DisputeStatement, ValidatorIndex, ValidatorSignature)>
  final List<
          _i3.Tuple3<_i4.DisputeStatement, _i5.ValidatorIndex, _i6.Signature>>
      statements;

  static const $DisputeStatementSetCodec codec = $DisputeStatementSetCodec();

  _i7.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'candidateHash': candidateHash.toList(),
        'session': session,
        'statements': statements
            .map((value) => [
                  value.value0.toJson(),
                  value.value1,
                  value.value2.toList(),
                ])
            .toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DisputeStatementSet &&
          other.candidateHash == candidateHash &&
          other.session == session &&
          _i8.listsEqual(
            other.statements,
            statements,
          );

  @override
  int get hashCode => Object.hash(
        candidateHash,
        session,
        statements,
      );
}

class $DisputeStatementSetCodec with _i1.Codec<DisputeStatementSet> {
  const $DisputeStatementSetCodec();

  @override
  void encodeTo(
    DisputeStatementSet obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.candidateHash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.session,
      output,
    );
    const _i1.SequenceCodec<
            _i3
            .Tuple3<_i4.DisputeStatement, _i5.ValidatorIndex, _i6.Signature>>(
        _i3.Tuple3Codec<_i4.DisputeStatement, _i5.ValidatorIndex,
            _i6.Signature>(
      _i4.DisputeStatement.codec,
      _i5.ValidatorIndexCodec(),
      _i6.SignatureCodec(),
    )).encodeTo(
      obj.statements,
      output,
    );
  }

  @override
  DisputeStatementSet decode(_i1.Input input) {
    return DisputeStatementSet(
      candidateHash: const _i1.U8ArrayCodec(32).decode(input),
      session: _i1.U32Codec.codec.decode(input),
      statements: const _i1.SequenceCodec<
              _i3
              .Tuple3<_i4.DisputeStatement, _i5.ValidatorIndex, _i6.Signature>>(
          _i3.Tuple3Codec<_i4.DisputeStatement, _i5.ValidatorIndex,
              _i6.Signature>(
        _i4.DisputeStatement.codec,
        _i5.ValidatorIndexCodec(),
        _i6.SignatureCodec(),
      )).decode(input),
    );
  }

  @override
  int sizeHint(DisputeStatementSet obj) {
    int size = 0;
    size = size + const _i2.CandidateHashCodec().sizeHint(obj.candidateHash);
    size = size + _i1.U32Codec.codec.sizeHint(obj.session);
    size = size +
        const _i1.SequenceCodec<
            _i3.Tuple3<_i4.DisputeStatement, _i5.ValidatorIndex,
                _i6.Signature>>(_i3.Tuple3Codec<_i4.DisputeStatement,
            _i5.ValidatorIndex, _i6.Signature>(
          _i4.DisputeStatement.codec,
          _i5.ValidatorIndexCodec(),
          _i6.SignatureCodec(),
        )).sizeHint(obj.statements);
    return size;
  }
}
