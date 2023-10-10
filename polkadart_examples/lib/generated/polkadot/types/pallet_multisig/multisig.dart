// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../sp_core/crypto/account_id32.dart' as _i3;
import 'timepoint.dart' as _i2;

class Multisig {
  const Multisig({
    required this.when,
    required this.deposit,
    required this.depositor,
    required this.approvals,
  });

  factory Multisig.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Timepoint<BlockNumber>
  final _i2.Timepoint when;

  /// Balance
  final BigInt deposit;

  /// AccountId
  final _i3.AccountId32 depositor;

  /// BoundedVec<AccountId, MaxApprovals>
  final List<_i3.AccountId32> approvals;

  static const $MultisigCodec codec = $MultisigCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'when': when.toJson(),
        'deposit': deposit,
        'depositor': depositor.toList(),
        'approvals': approvals.map((value) => value.toList()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Multisig &&
          other.when == when &&
          other.deposit == deposit &&
          _i5.listsEqual(
            other.depositor,
            depositor,
          ) &&
          _i5.listsEqual(
            other.approvals,
            approvals,
          );

  @override
  int get hashCode => Object.hash(
        when,
        deposit,
        depositor,
        approvals,
      );
}

class $MultisigCodec with _i1.Codec<Multisig> {
  const $MultisigCodec();

  @override
  void encodeTo(
    Multisig obj,
    _i1.Output output,
  ) {
    _i2.Timepoint.codec.encodeTo(
      obj.when,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.depositor,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      obj.approvals,
      output,
    );
  }

  @override
  Multisig decode(_i1.Input input) {
    return Multisig(
      when: _i2.Timepoint.codec.decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
      depositor: const _i1.U8ArrayCodec(32).decode(input),
      approvals:
          const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
              .decode(input),
    );
  }

  @override
  int sizeHint(Multisig obj) {
    int size = 0;
    size = size + _i2.Timepoint.codec.sizeHint(obj.when);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size + const _i3.AccountId32Codec().sizeHint(obj.depositor);
    size = size +
        const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(obj.approvals);
    return size;
  }
}
