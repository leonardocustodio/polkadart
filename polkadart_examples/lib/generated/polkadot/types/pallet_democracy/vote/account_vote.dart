// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'vote.dart' as _i3;

abstract class AccountVote {
  const AccountVote();

  factory AccountVote.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AccountVoteCodec codec = $AccountVoteCodec();

  static const $AccountVote values = $AccountVote();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $AccountVote {
  const $AccountVote();

  Standard standard({
    required _i3.Vote vote,
    required BigInt balance,
  }) {
    return Standard(
      vote: vote,
      balance: balance,
    );
  }

  Split split({
    required BigInt aye,
    required BigInt nay,
  }) {
    return Split(
      aye: aye,
      nay: nay,
    );
  }
}

class $AccountVoteCodec with _i1.Codec<AccountVote> {
  const $AccountVoteCodec();

  @override
  AccountVote decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Standard._decode(input);
      case 1:
        return Split._decode(input);
      default:
        throw Exception('AccountVote: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AccountVote value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Standard:
        (value as Standard).encodeTo(output);
        break;
      case Split:
        (value as Split).encodeTo(output);
        break;
      default:
        throw Exception(
            'AccountVote: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AccountVote value) {
    switch (value.runtimeType) {
      case Standard:
        return (value as Standard)._sizeHint();
      case Split:
        return (value as Split)._sizeHint();
      default:
        throw Exception(
            'AccountVote: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Standard extends AccountVote {
  const Standard({
    required this.vote,
    required this.balance,
  });

  factory Standard._decode(_i1.Input input) {
    return Standard(
      vote: _i1.U8Codec.codec.decode(input),
      balance: _i1.U128Codec.codec.decode(input),
    );
  }

  /// Vote
  final _i3.Vote vote;

  /// Balance
  final BigInt balance;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Standard': {
          'vote': vote,
          'balance': balance,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.VoteCodec().sizeHint(vote);
    size = size + _i1.U128Codec.codec.sizeHint(balance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      vote,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      balance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Standard && other.vote == vote && other.balance == balance;

  @override
  int get hashCode => Object.hash(
        vote,
        balance,
      );
}

class Split extends AccountVote {
  const Split({
    required this.aye,
    required this.nay,
  });

  factory Split._decode(_i1.Input input) {
    return Split(
      aye: _i1.U128Codec.codec.decode(input),
      nay: _i1.U128Codec.codec.decode(input),
    );
  }

  /// Balance
  final BigInt aye;

  /// Balance
  final BigInt nay;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Split': {
          'aye': aye,
          'nay': nay,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(aye);
    size = size + _i1.U128Codec.codec.sizeHint(nay);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      aye,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      nay,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Split && other.aye == aye && other.nay == nay;

  @override
  int get hashCode => Object.hash(
        aye,
        nay,
      );
}
