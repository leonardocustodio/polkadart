// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../../polkadot_parachain/primitives/id.dart' as _i6;
import '../../../sp_core/crypto/account_id32.dart' as _i5;
import '../../../sp_runtime/multi_signature.dart' as _i4;
import '../../../sp_runtime/multi_signer.dart' as _i3;

/// Contains one variant per dispatchable that can be called by an extrinsic.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  Create create({
    required BigInt index,
    required BigInt cap,
    required BigInt firstPeriod,
    required BigInt lastPeriod,
    required BigInt end,
    _i3.MultiSigner? verifier,
  }) {
    return Create(
      index: index,
      cap: cap,
      firstPeriod: firstPeriod,
      lastPeriod: lastPeriod,
      end: end,
      verifier: verifier,
    );
  }

  Contribute contribute({
    required BigInt index,
    required BigInt value,
    _i4.MultiSignature? signature,
  }) {
    return Contribute(
      index: index,
      value: value,
      signature: signature,
    );
  }

  Withdraw withdraw({
    required _i5.AccountId32 who,
    required BigInt index,
  }) {
    return Withdraw(
      who: who,
      index: index,
    );
  }

  Refund refund({required BigInt index}) {
    return Refund(index: index);
  }

  Dissolve dissolve({required BigInt index}) {
    return Dissolve(index: index);
  }

  Edit edit({
    required BigInt index,
    required BigInt cap,
    required BigInt firstPeriod,
    required BigInt lastPeriod,
    required BigInt end,
    _i3.MultiSigner? verifier,
  }) {
    return Edit(
      index: index,
      cap: cap,
      firstPeriod: firstPeriod,
      lastPeriod: lastPeriod,
      end: end,
      verifier: verifier,
    );
  }

  AddMemo addMemo({
    required _i6.Id index,
    required List<int> memo,
  }) {
    return AddMemo(
      index: index,
      memo: memo,
    );
  }

  Poke poke({required _i6.Id index}) {
    return Poke(index: index);
  }

  ContributeAll contributeAll({
    required BigInt index,
    _i4.MultiSignature? signature,
  }) {
    return ContributeAll(
      index: index,
      signature: signature,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Create._decode(input);
      case 1:
        return Contribute._decode(input);
      case 2:
        return Withdraw._decode(input);
      case 3:
        return Refund._decode(input);
      case 4:
        return Dissolve._decode(input);
      case 5:
        return Edit._decode(input);
      case 6:
        return AddMemo._decode(input);
      case 7:
        return Poke._decode(input);
      case 8:
        return ContributeAll._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Create:
        (value as Create).encodeTo(output);
        break;
      case Contribute:
        (value as Contribute).encodeTo(output);
        break;
      case Withdraw:
        (value as Withdraw).encodeTo(output);
        break;
      case Refund:
        (value as Refund).encodeTo(output);
        break;
      case Dissolve:
        (value as Dissolve).encodeTo(output);
        break;
      case Edit:
        (value as Edit).encodeTo(output);
        break;
      case AddMemo:
        (value as AddMemo).encodeTo(output);
        break;
      case Poke:
        (value as Poke).encodeTo(output);
        break;
      case ContributeAll:
        (value as ContributeAll).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Create:
        return (value as Create)._sizeHint();
      case Contribute:
        return (value as Contribute)._sizeHint();
      case Withdraw:
        return (value as Withdraw)._sizeHint();
      case Refund:
        return (value as Refund)._sizeHint();
      case Dissolve:
        return (value as Dissolve)._sizeHint();
      case Edit:
        return (value as Edit)._sizeHint();
      case AddMemo:
        return (value as AddMemo)._sizeHint();
      case Poke:
        return (value as Poke)._sizeHint();
      case ContributeAll:
        return (value as ContributeAll)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Create a new crowdloaning campaign for a parachain slot with the given lease period range.
///
/// This applies a lock to your parachain configuration, ensuring that it cannot be changed
/// by the parachain manager.
class Create extends Call {
  const Create({
    required this.index,
    required this.cap,
    required this.firstPeriod,
    required this.lastPeriod,
    required this.end,
    this.verifier,
  });

  factory Create._decode(_i1.Input input) {
    return Create(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      cap: _i1.CompactBigIntCodec.codec.decode(input),
      firstPeriod: _i1.CompactBigIntCodec.codec.decode(input),
      lastPeriod: _i1.CompactBigIntCodec.codec.decode(input),
      end: _i1.CompactBigIntCodec.codec.decode(input),
      verifier: const _i1.OptionCodec<_i3.MultiSigner>(_i3.MultiSigner.codec)
          .decode(input),
    );
  }

  /// ParaId
  final BigInt index;

  /// BalanceOf<T>
  final BigInt cap;

  /// LeasePeriodOf<T>
  final BigInt firstPeriod;

  /// LeasePeriodOf<T>
  final BigInt lastPeriod;

  /// T::BlockNumber
  final BigInt end;

  /// Option<MultiSigner>
  final _i3.MultiSigner? verifier;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create': {
          'index': index,
          'cap': cap,
          'firstPeriod': firstPeriod,
          'lastPeriod': lastPeriod,
          'end': end,
          'verifier': verifier?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(cap);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(firstPeriod);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(lastPeriod);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(end);
    size = size +
        const _i1.OptionCodec<_i3.MultiSigner>(_i3.MultiSigner.codec)
            .sizeHint(verifier);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      cap,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      firstPeriod,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      lastPeriod,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      end,
      output,
    );
    const _i1.OptionCodec<_i3.MultiSigner>(_i3.MultiSigner.codec).encodeTo(
      verifier,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Create &&
          other.index == index &&
          other.cap == cap &&
          other.firstPeriod == firstPeriod &&
          other.lastPeriod == lastPeriod &&
          other.end == end &&
          other.verifier == verifier;

  @override
  int get hashCode => Object.hash(
        index,
        cap,
        firstPeriod,
        lastPeriod,
        end,
        verifier,
      );
}

/// Contribute to a crowd sale. This will transfer some balance over to fund a parachain
/// slot. It will be withdrawable when the crowdloan has ended and the funds are unused.
class Contribute extends Call {
  const Contribute({
    required this.index,
    required this.value,
    this.signature,
  });

  factory Contribute._decode(_i1.Input input) {
    return Contribute(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      value: _i1.CompactBigIntCodec.codec.decode(input),
      signature:
          const _i1.OptionCodec<_i4.MultiSignature>(_i4.MultiSignature.codec)
              .decode(input),
    );
  }

  /// ParaId
  final BigInt index;

  /// BalanceOf<T>
  final BigInt value;

  /// Option<MultiSignature>
  final _i4.MultiSignature? signature;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'contribute': {
          'index': index,
          'value': value,
          'signature': signature?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    size = size +
        const _i1.OptionCodec<_i4.MultiSignature>(_i4.MultiSignature.codec)
            .sizeHint(signature);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
      output,
    );
    const _i1.OptionCodec<_i4.MultiSignature>(_i4.MultiSignature.codec)
        .encodeTo(
      signature,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Contribute &&
          other.index == index &&
          other.value == value &&
          other.signature == signature;

  @override
  int get hashCode => Object.hash(
        index,
        value,
        signature,
      );
}

/// Withdraw full balance of a specific contributor.
///
/// Origin must be signed, but can come from anyone.
///
/// The fund must be either in, or ready for, retirement. For a fund to be *in* retirement, then the retirement
/// flag must be set. For a fund to be ready for retirement, then:
/// - it must not already be in retirement;
/// - the amount of raised funds must be bigger than the _free_ balance of the account;
/// - and either:
///  - the block number must be at least `end`; or
///  - the current lease period must be greater than the fund's `last_period`.
///
/// In this case, the fund's retirement flag is set and its `end` is reset to the current block
/// number.
///
/// - `who`: The account whose contribution should be withdrawn.
/// - `index`: The parachain to whose crowdloan the contribution was made.
class Withdraw extends Call {
  const Withdraw({
    required this.who,
    required this.index,
  });

  factory Withdraw._decode(_i1.Input input) {
    return Withdraw(
      who: const _i1.U8ArrayCodec(32).decode(input),
      index: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i5.AccountId32 who;

  /// ParaId
  final BigInt index;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'withdraw': {
          'who': who.toList(),
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.AccountId32Codec().sizeHint(who);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Withdraw &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          other.index == index;

  @override
  int get hashCode => Object.hash(
        who,
        index,
      );
}

/// Automatically refund contributors of an ended crowdloan.
/// Due to weight restrictions, this function may need to be called multiple
/// times to fully refund all users. We will refund `RemoveKeysLimit` users at a time.
///
/// Origin must be signed, but can come from anyone.
class Refund extends Call {
  const Refund({required this.index});

  factory Refund._decode(_i1.Input input) {
    return Refund(index: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// ParaId
  final BigInt index;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'refund': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Refund && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Remove a fund after the retirement period has ended and all funds have been returned.
class Dissolve extends Call {
  const Dissolve({required this.index});

  factory Dissolve._decode(_i1.Input input) {
    return Dissolve(index: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// ParaId
  final BigInt index;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'dissolve': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Dissolve && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Edit the configuration for an in-progress crowdloan.
///
/// Can only be called by Root origin.
class Edit extends Call {
  const Edit({
    required this.index,
    required this.cap,
    required this.firstPeriod,
    required this.lastPeriod,
    required this.end,
    this.verifier,
  });

  factory Edit._decode(_i1.Input input) {
    return Edit(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      cap: _i1.CompactBigIntCodec.codec.decode(input),
      firstPeriod: _i1.CompactBigIntCodec.codec.decode(input),
      lastPeriod: _i1.CompactBigIntCodec.codec.decode(input),
      end: _i1.CompactBigIntCodec.codec.decode(input),
      verifier: const _i1.OptionCodec<_i3.MultiSigner>(_i3.MultiSigner.codec)
          .decode(input),
    );
  }

  /// ParaId
  final BigInt index;

  /// BalanceOf<T>
  final BigInt cap;

  /// LeasePeriodOf<T>
  final BigInt firstPeriod;

  /// LeasePeriodOf<T>
  final BigInt lastPeriod;

  /// T::BlockNumber
  final BigInt end;

  /// Option<MultiSigner>
  final _i3.MultiSigner? verifier;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'edit': {
          'index': index,
          'cap': cap,
          'firstPeriod': firstPeriod,
          'lastPeriod': lastPeriod,
          'end': end,
          'verifier': verifier?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(cap);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(firstPeriod);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(lastPeriod);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(end);
    size = size +
        const _i1.OptionCodec<_i3.MultiSigner>(_i3.MultiSigner.codec)
            .sizeHint(verifier);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      cap,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      firstPeriod,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      lastPeriod,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      end,
      output,
    );
    const _i1.OptionCodec<_i3.MultiSigner>(_i3.MultiSigner.codec).encodeTo(
      verifier,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Edit &&
          other.index == index &&
          other.cap == cap &&
          other.firstPeriod == firstPeriod &&
          other.lastPeriod == lastPeriod &&
          other.end == end &&
          other.verifier == verifier;

  @override
  int get hashCode => Object.hash(
        index,
        cap,
        firstPeriod,
        lastPeriod,
        end,
        verifier,
      );
}

/// Add an optional memo to an existing crowdloan contribution.
///
/// Origin must be Signed, and the user must have contributed to the crowdloan.
class AddMemo extends Call {
  const AddMemo({
    required this.index,
    required this.memo,
  });

  factory AddMemo._decode(_i1.Input input) {
    return AddMemo(
      index: _i1.U32Codec.codec.decode(input),
      memo: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// ParaId
  final _i6.Id index;

  /// Vec<u8>
  final List<int> memo;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'add_memo': {
          'index': index,
          'memo': memo,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.IdCodec().sizeHint(index);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(memo);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      memo,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddMemo &&
          other.index == index &&
          _i7.listsEqual(
            other.memo,
            memo,
          );

  @override
  int get hashCode => Object.hash(
        index,
        memo,
      );
}

/// Poke the fund into `NewRaise`
///
/// Origin must be Signed, and the fund has non-zero raise.
class Poke extends Call {
  const Poke({required this.index});

  factory Poke._decode(_i1.Input input) {
    return Poke(index: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i6.Id index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'poke': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.IdCodec().sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Poke && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Contribute your entire balance to a crowd sale. This will transfer the entire balance of a user over to fund a parachain
/// slot. It will be withdrawable when the crowdloan has ended and the funds are unused.
class ContributeAll extends Call {
  const ContributeAll({
    required this.index,
    this.signature,
  });

  factory ContributeAll._decode(_i1.Input input) {
    return ContributeAll(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      signature:
          const _i1.OptionCodec<_i4.MultiSignature>(_i4.MultiSignature.codec)
              .decode(input),
    );
  }

  /// ParaId
  final BigInt index;

  /// Option<MultiSignature>
  final _i4.MultiSignature? signature;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'contribute_all': {
          'index': index,
          'signature': signature?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size +
        const _i1.OptionCodec<_i4.MultiSignature>(_i4.MultiSignature.codec)
            .sizeHint(signature);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    const _i1.OptionCodec<_i4.MultiSignature>(_i4.MultiSignature.codec)
        .encodeTo(
      signature,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ContributeAll &&
          other.index == index &&
          other.signature == signature;

  @override
  int get hashCode => Object.hash(
        index,
        signature,
      );
}
