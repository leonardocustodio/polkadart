// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i2;
import '../raw_solution.dart' as _i3;

class SignedSubmission {
  const SignedSubmission({
    required this.who,
    required this.deposit,
    required this.rawSolution,
    required this.callFee,
  });

  factory SignedSubmission.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 who;

  /// Balance
  final BigInt deposit;

  /// RawSolution<Solution>
  final _i3.RawSolution rawSolution;

  /// Balance
  final BigInt callFee;

  static const $SignedSubmissionCodec codec = $SignedSubmissionCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'who': who.toList(),
        'deposit': deposit,
        'rawSolution': rawSolution.toJson(),
        'callFee': callFee,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SignedSubmission &&
          _i5.listsEqual(
            other.who,
            who,
          ) &&
          other.deposit == deposit &&
          other.rawSolution == rawSolution &&
          other.callFee == callFee;

  @override
  int get hashCode => Object.hash(
        who,
        deposit,
        rawSolution,
        callFee,
      );
}

class $SignedSubmissionCodec with _i1.Codec<SignedSubmission> {
  const $SignedSubmissionCodec();

  @override
  void encodeTo(
    SignedSubmission obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.who,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
    _i3.RawSolution.codec.encodeTo(
      obj.rawSolution,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.callFee,
      output,
    );
  }

  @override
  SignedSubmission decode(_i1.Input input) {
    return SignedSubmission(
      who: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
      rawSolution: _i3.RawSolution.codec.decode(input),
      callFee: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(SignedSubmission obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.who);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size + _i3.RawSolution.codec.sizeHint(obj.rawSolution);
    size = size + _i1.U128Codec.codec.sizeHint(obj.callFee);
    return size;
  }
}
