// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../sp_core/crypto/account_id32.dart' as _i2;

class Voter {
  const Voter({
    required this.votes,
    required this.stake,
    required this.deposit,
  });

  factory Voter.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<AccountId>
  final List<_i2.AccountId32> votes;

  /// Balance
  final BigInt stake;

  /// Balance
  final BigInt deposit;

  static const $VoterCodec codec = $VoterCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'votes': votes.map((value) => value.toList()).toList(),
        'stake': stake,
        'deposit': deposit,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Voter &&
          _i4.listsEqual(
            other.votes,
            votes,
          ) &&
          other.stake == stake &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        votes,
        stake,
        deposit,
      );
}

class $VoterCodec with _i1.Codec<Voter> {
  const $VoterCodec();

  @override
  void encodeTo(
    Voter obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.votes,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.stake,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
  }

  @override
  Voter decode(_i1.Input input) {
    return Voter(
      votes: const _i1.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec())
          .decode(input),
      stake: _i1.U128Codec.codec.decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Voter obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.votes);
    size = size + _i1.U128Codec.codec.sizeHint(obj.stake);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    return size;
  }
}
