// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../sp_core/crypto/account_id32.dart' as _i2;

class Proposal {
  const Proposal({
    required this.proposer,
    required this.value,
    required this.beneficiary,
    required this.bond,
  });

  factory Proposal.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 proposer;

  /// Balance
  final BigInt value;

  /// AccountId
  final _i2.AccountId32 beneficiary;

  /// Balance
  final BigInt bond;

  static const $ProposalCodec codec = $ProposalCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'proposer': proposer.toList(),
        'value': value,
        'beneficiary': beneficiary.toList(),
        'bond': bond,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Proposal &&
          _i4.listsEqual(
            other.proposer,
            proposer,
          ) &&
          other.value == value &&
          _i4.listsEqual(
            other.beneficiary,
            beneficiary,
          ) &&
          other.bond == bond;

  @override
  int get hashCode => Object.hash(
        proposer,
        value,
        beneficiary,
        bond,
      );
}

class $ProposalCodec with _i1.Codec<Proposal> {
  const $ProposalCodec();

  @override
  void encodeTo(
    Proposal obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.proposer,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.value,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.beneficiary,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.bond,
      output,
    );
  }

  @override
  Proposal decode(_i1.Input input) {
    return Proposal(
      proposer: const _i1.U8ArrayCodec(32).decode(input),
      value: _i1.U128Codec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
      bond: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Proposal obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.proposer);
    size = size + _i1.U128Codec.codec.sizeHint(obj.value);
    size = size + const _i2.AccountId32Codec().sizeHint(obj.beneficiary);
    size = size + _i1.U128Codec.codec.sizeHint(obj.bond);
    return size;
  }
}
