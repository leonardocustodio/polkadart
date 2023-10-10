// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../sp_core/crypto/account_id32.dart' as _i2;
import '../conviction/conviction.dart' as _i3;
import '../types/delegations.dart' as _i4;
import 'prior_lock.dart' as _i5;

class Delegating {
  const Delegating({
    required this.balance,
    required this.target,
    required this.conviction,
    required this.delegations,
    required this.prior,
  });

  factory Delegating.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt balance;

  /// AccountId
  final _i2.AccountId32 target;

  /// Conviction
  final _i3.Conviction conviction;

  /// Delegations<Balance>
  final _i4.Delegations delegations;

  /// PriorLock<BlockNumber, Balance>
  final _i5.PriorLock prior;

  static const $DelegatingCodec codec = $DelegatingCodec();

  _i6.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'balance': balance,
        'target': target.toList(),
        'conviction': conviction.toJson(),
        'delegations': delegations.toJson(),
        'prior': prior.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Delegating &&
          other.balance == balance &&
          _i7.listsEqual(
            other.target,
            target,
          ) &&
          other.conviction == conviction &&
          other.delegations == delegations &&
          other.prior == prior;

  @override
  int get hashCode => Object.hash(
        balance,
        target,
        conviction,
        delegations,
        prior,
      );
}

class $DelegatingCodec with _i1.Codec<Delegating> {
  const $DelegatingCodec();

  @override
  void encodeTo(
    Delegating obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.balance,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.target,
      output,
    );
    _i3.Conviction.codec.encodeTo(
      obj.conviction,
      output,
    );
    _i4.Delegations.codec.encodeTo(
      obj.delegations,
      output,
    );
    _i5.PriorLock.codec.encodeTo(
      obj.prior,
      output,
    );
  }

  @override
  Delegating decode(_i1.Input input) {
    return Delegating(
      balance: _i1.U128Codec.codec.decode(input),
      target: const _i1.U8ArrayCodec(32).decode(input),
      conviction: _i3.Conviction.codec.decode(input),
      delegations: _i4.Delegations.codec.decode(input),
      prior: _i5.PriorLock.codec.decode(input),
    );
  }

  @override
  int sizeHint(Delegating obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.balance);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.target);
    size = size + _i3.Conviction.codec.sizeHint(obj.conviction);
    size = size + _i4.Delegations.codec.sizeHint(obj.delegations);
    size = size + _i5.PriorLock.codec.sizeHint(obj.prior);
    return size;
  }
}
