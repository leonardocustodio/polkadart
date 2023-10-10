// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../sp_core/crypto/account_id32.dart' as _i2;
import '../../sp_runtime/multi_signer.dart' as _i3;
import 'last_contribution.dart' as _i4;

class FundInfo {
  const FundInfo({
    required this.depositor,
    this.verifier,
    required this.deposit,
    required this.raised,
    required this.end,
    required this.cap,
    required this.lastContribution,
    required this.firstPeriod,
    required this.lastPeriod,
    required this.fundIndex,
  });

  factory FundInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 depositor;

  /// Option<MultiSigner>
  final _i3.MultiSigner? verifier;

  /// Balance
  final BigInt deposit;

  /// Balance
  final BigInt raised;

  /// BlockNumber
  final int end;

  /// Balance
  final BigInt cap;

  /// LastContribution<BlockNumber>
  final _i4.LastContribution lastContribution;

  /// LeasePeriod
  final int firstPeriod;

  /// LeasePeriod
  final int lastPeriod;

  /// FundIndex
  final int fundIndex;

  static const $FundInfoCodec codec = $FundInfoCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'depositor': depositor.toList(),
        'verifier': verifier?.toJson(),
        'deposit': deposit,
        'raised': raised,
        'end': end,
        'cap': cap,
        'lastContribution': lastContribution.toJson(),
        'firstPeriod': firstPeriod,
        'lastPeriod': lastPeriod,
        'fundIndex': fundIndex,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is FundInfo &&
          _i6.listsEqual(
            other.depositor,
            depositor,
          ) &&
          other.verifier == verifier &&
          other.deposit == deposit &&
          other.raised == raised &&
          other.end == end &&
          other.cap == cap &&
          other.lastContribution == lastContribution &&
          other.firstPeriod == firstPeriod &&
          other.lastPeriod == lastPeriod &&
          other.fundIndex == fundIndex;

  @override
  int get hashCode => Object.hash(
        depositor,
        verifier,
        deposit,
        raised,
        end,
        cap,
        lastContribution,
        firstPeriod,
        lastPeriod,
        fundIndex,
      );
}

class $FundInfoCodec with _i1.Codec<FundInfo> {
  const $FundInfoCodec();

  @override
  void encodeTo(
    FundInfo obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.depositor,
      output,
    );
    const _i1.OptionCodec<_i3.MultiSigner>(_i3.MultiSigner.codec).encodeTo(
      obj.verifier,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.raised,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.end,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.cap,
      output,
    );
    _i4.LastContribution.codec.encodeTo(
      obj.lastContribution,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.firstPeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.lastPeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.fundIndex,
      output,
    );
  }

  @override
  FundInfo decode(_i1.Input input) {
    return FundInfo(
      depositor: const _i1.U8ArrayCodec(32).decode(input),
      verifier: const _i1.OptionCodec<_i3.MultiSigner>(_i3.MultiSigner.codec)
          .decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
      raised: _i1.U128Codec.codec.decode(input),
      end: _i1.U32Codec.codec.decode(input),
      cap: _i1.U128Codec.codec.decode(input),
      lastContribution: _i4.LastContribution.codec.decode(input),
      firstPeriod: _i1.U32Codec.codec.decode(input),
      lastPeriod: _i1.U32Codec.codec.decode(input),
      fundIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(FundInfo obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.depositor);
    size = size +
        const _i1.OptionCodec<_i3.MultiSigner>(_i3.MultiSigner.codec)
            .sizeHint(obj.verifier);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size + _i1.U128Codec.codec.sizeHint(obj.raised);
    size = size + _i1.U32Codec.codec.sizeHint(obj.end);
    size = size + _i1.U128Codec.codec.sizeHint(obj.cap);
    size = size + _i4.LastContribution.codec.sizeHint(obj.lastContribution);
    size = size + _i1.U32Codec.codec.sizeHint(obj.firstPeriod);
    size = size + _i1.U32Codec.codec.sizeHint(obj.lastPeriod);
    size = size + _i1.U32Codec.codec.sizeHint(obj.fundIndex);
    return size;
  }
}
