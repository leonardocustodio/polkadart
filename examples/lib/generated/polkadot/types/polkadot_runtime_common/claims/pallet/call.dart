// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../../sp_core/crypto/account_id32.dart' as _i3;
import '../../../tuples_2.dart' as _i6;
import '../ecdsa_signature.dart' as _i4;
import '../ethereum_address.dart' as _i5;
import '../statement_kind.dart' as _i7;

/// Contains a variant per dispatchable extrinsic that this pallet has.
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

  Claim claim({
    required _i3.AccountId32 dest,
    required _i4.EcdsaSignature ethereumSignature,
  }) {
    return Claim(
      dest: dest,
      ethereumSignature: ethereumSignature,
    );
  }

  MintClaim mintClaim({
    required _i5.EthereumAddress who,
    required BigInt value,
    _i6.Tuple3<BigInt, BigInt, int>? vestingSchedule,
    _i7.StatementKind? statement,
  }) {
    return MintClaim(
      who: who,
      value: value,
      vestingSchedule: vestingSchedule,
      statement: statement,
    );
  }

  ClaimAttest claimAttest({
    required _i3.AccountId32 dest,
    required _i4.EcdsaSignature ethereumSignature,
    required List<int> statement,
  }) {
    return ClaimAttest(
      dest: dest,
      ethereumSignature: ethereumSignature,
      statement: statement,
    );
  }

  Attest attest({required List<int> statement}) {
    return Attest(statement: statement);
  }

  MoveClaim moveClaim({
    required _i5.EthereumAddress old,
    required _i5.EthereumAddress new_,
    _i3.AccountId32? maybePreclaim,
  }) {
    return MoveClaim(
      old: old,
      new_: new_,
      maybePreclaim: maybePreclaim,
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
        return Claim._decode(input);
      case 1:
        return MintClaim._decode(input);
      case 2:
        return ClaimAttest._decode(input);
      case 3:
        return Attest._decode(input);
      case 4:
        return MoveClaim._decode(input);
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
      case Claim:
        (value as Claim).encodeTo(output);
        break;
      case MintClaim:
        (value as MintClaim).encodeTo(output);
        break;
      case ClaimAttest:
        (value as ClaimAttest).encodeTo(output);
        break;
      case Attest:
        (value as Attest).encodeTo(output);
        break;
      case MoveClaim:
        (value as MoveClaim).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Claim:
        return (value as Claim)._sizeHint();
      case MintClaim:
        return (value as MintClaim)._sizeHint();
      case ClaimAttest:
        return (value as ClaimAttest)._sizeHint();
      case Attest:
        return (value as Attest)._sizeHint();
      case MoveClaim:
        return (value as MoveClaim)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Make a claim to collect your DOTs.
///
/// The dispatch origin for this call must be _None_.
///
/// Unsigned Validation:
/// A call to claim is deemed valid if the signature provided matches
/// the expected signed message of:
///
/// > Ethereum Signed Message:
/// > (configured prefix string)(address)
///
/// and `address` matches the `dest` account.
///
/// Parameters:
/// - `dest`: The destination account to payout the claim.
/// - `ethereum_signature`: The signature of an ethereum signed message matching the format
///  described above.
///
/// <weight>
/// The weight of this call is invariant over the input parameters.
/// Weight includes logic to validate unsigned `claim` call.
///
/// Total Complexity: O(1)
/// </weight>
class Claim extends Call {
  const Claim({
    required this.dest,
    required this.ethereumSignature,
  });

  factory Claim._decode(_i1.Input input) {
    return Claim(
      dest: const _i1.U8ArrayCodec(32).decode(input),
      ethereumSignature: const _i1.U8ArrayCodec(65).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 dest;

  /// EcdsaSignature
  final _i4.EcdsaSignature ethereumSignature;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'claim': {
          'dest': dest.toList(),
          'ethereumSignature': ethereumSignature.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(dest);
    size = size + const _i4.EcdsaSignatureCodec().sizeHint(ethereumSignature);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      dest,
      output,
    );
    const _i1.U8ArrayCodec(65).encodeTo(
      ethereumSignature,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Claim &&
          _i8.listsEqual(
            other.dest,
            dest,
          ) &&
          _i8.listsEqual(
            other.ethereumSignature,
            ethereumSignature,
          );

  @override
  int get hashCode => Object.hash(
        dest,
        ethereumSignature,
      );
}

/// Mint a new claim to collect DOTs.
///
/// The dispatch origin for this call must be _Root_.
///
/// Parameters:
/// - `who`: The Ethereum address allowed to collect this claim.
/// - `value`: The number of DOTs that will be claimed.
/// - `vesting_schedule`: An optional vesting schedule for these DOTs.
///
/// <weight>
/// The weight of this call is invariant over the input parameters.
/// We assume worst case that both vesting and statement is being inserted.
///
/// Total Complexity: O(1)
/// </weight>
class MintClaim extends Call {
  const MintClaim({
    required this.who,
    required this.value,
    this.vestingSchedule,
    this.statement,
  });

  factory MintClaim._decode(_i1.Input input) {
    return MintClaim(
      who: const _i1.U8ArrayCodec(20).decode(input),
      value: _i1.U128Codec.codec.decode(input),
      vestingSchedule: const _i1.OptionCodec<_i6.Tuple3<BigInt, BigInt, int>>(
          _i6.Tuple3Codec<BigInt, BigInt, int>(
        _i1.U128Codec.codec,
        _i1.U128Codec.codec,
        _i1.U32Codec.codec,
      )).decode(input),
      statement:
          const _i1.OptionCodec<_i7.StatementKind>(_i7.StatementKind.codec)
              .decode(input),
    );
  }

  /// EthereumAddress
  final _i5.EthereumAddress who;

  /// BalanceOf<T>
  final BigInt value;

  /// Option<(BalanceOf<T>, BalanceOf<T>, BlockNumberFor<T>)>
  final _i6.Tuple3<BigInt, BigInt, int>? vestingSchedule;

  /// Option<StatementKind>
  final _i7.StatementKind? statement;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'mint_claim': {
          'who': who.toList(),
          'value': value,
          'vestingSchedule': [
            vestingSchedule?.value0,
            vestingSchedule?.value1,
            vestingSchedule?.value2,
          ],
          'statement': statement?.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.EthereumAddressCodec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(value);
    size = size +
        const _i1.OptionCodec<_i6.Tuple3<BigInt, BigInt, int>>(
            _i6.Tuple3Codec<BigInt, BigInt, int>(
          _i1.U128Codec.codec,
          _i1.U128Codec.codec,
          _i1.U32Codec.codec,
        )).sizeHint(vestingSchedule);
    size = size +
        const _i1.OptionCodec<_i7.StatementKind>(_i7.StatementKind.codec)
            .sizeHint(statement);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      who,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      value,
      output,
    );
    const _i1.OptionCodec<_i6.Tuple3<BigInt, BigInt, int>>(
        _i6.Tuple3Codec<BigInt, BigInt, int>(
      _i1.U128Codec.codec,
      _i1.U128Codec.codec,
      _i1.U32Codec.codec,
    )).encodeTo(
      vestingSchedule,
      output,
    );
    const _i1.OptionCodec<_i7.StatementKind>(_i7.StatementKind.codec).encodeTo(
      statement,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MintClaim &&
          _i8.listsEqual(
            other.who,
            who,
          ) &&
          other.value == value &&
          other.vestingSchedule == vestingSchedule &&
          other.statement == statement;

  @override
  int get hashCode => Object.hash(
        who,
        value,
        vestingSchedule,
        statement,
      );
}

/// Make a claim to collect your DOTs by signing a statement.
///
/// The dispatch origin for this call must be _None_.
///
/// Unsigned Validation:
/// A call to `claim_attest` is deemed valid if the signature provided matches
/// the expected signed message of:
///
/// > Ethereum Signed Message:
/// > (configured prefix string)(address)(statement)
///
/// and `address` matches the `dest` account; the `statement` must match that which is
/// expected according to your purchase arrangement.
///
/// Parameters:
/// - `dest`: The destination account to payout the claim.
/// - `ethereum_signature`: The signature of an ethereum signed message matching the format
///  described above.
/// - `statement`: The identity of the statement which is being attested to in the
///  signature.
///
/// <weight>
/// The weight of this call is invariant over the input parameters.
/// Weight includes logic to validate unsigned `claim_attest` call.
///
/// Total Complexity: O(1)
/// </weight>
class ClaimAttest extends Call {
  const ClaimAttest({
    required this.dest,
    required this.ethereumSignature,
    required this.statement,
  });

  factory ClaimAttest._decode(_i1.Input input) {
    return ClaimAttest(
      dest: const _i1.U8ArrayCodec(32).decode(input),
      ethereumSignature: const _i1.U8ArrayCodec(65).decode(input),
      statement: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 dest;

  /// EcdsaSignature
  final _i4.EcdsaSignature ethereumSignature;

  /// Vec<u8>
  final List<int> statement;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'claim_attest': {
          'dest': dest.toList(),
          'ethereumSignature': ethereumSignature.toList(),
          'statement': statement,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(dest);
    size = size + const _i4.EcdsaSignatureCodec().sizeHint(ethereumSignature);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(statement);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      dest,
      output,
    );
    const _i1.U8ArrayCodec(65).encodeTo(
      ethereumSignature,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      statement,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClaimAttest &&
          _i8.listsEqual(
            other.dest,
            dest,
          ) &&
          _i8.listsEqual(
            other.ethereumSignature,
            ethereumSignature,
          ) &&
          _i8.listsEqual(
            other.statement,
            statement,
          );

  @override
  int get hashCode => Object.hash(
        dest,
        ethereumSignature,
        statement,
      );
}

/// Attest to a statement, needed to finalize the claims process.
///
/// WARNING: Insecure unless your chain includes `PrevalidateAttests` as a
/// `SignedExtension`.
///
/// Unsigned Validation:
/// A call to attest is deemed valid if the sender has a `Preclaim` registered
/// and provides a `statement` which is expected for the account.
///
/// Parameters:
/// - `statement`: The identity of the statement which is being attested to in the
///  signature.
///
/// <weight>
/// The weight of this call is invariant over the input parameters.
/// Weight includes logic to do pre-validation on `attest` call.
///
/// Total Complexity: O(1)
/// </weight>
class Attest extends Call {
  const Attest({required this.statement});

  factory Attest._decode(_i1.Input input) {
    return Attest(statement: _i1.U8SequenceCodec.codec.decode(input));
  }

  /// Vec<u8>
  final List<int> statement;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'attest': {'statement': statement}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(statement);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      statement,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Attest &&
          _i8.listsEqual(
            other.statement,
            statement,
          );

  @override
  int get hashCode => statement.hashCode;
}

class MoveClaim extends Call {
  const MoveClaim({
    required this.old,
    required this.new_,
    this.maybePreclaim,
  });

  factory MoveClaim._decode(_i1.Input input) {
    return MoveClaim(
      old: const _i1.U8ArrayCodec(20).decode(input),
      new_: const _i1.U8ArrayCodec(20).decode(input),
      maybePreclaim:
          const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec())
              .decode(input),
    );
  }

  /// EthereumAddress
  final _i5.EthereumAddress old;

  /// EthereumAddress
  final _i5.EthereumAddress new_;

  /// Option<T::AccountId>
  final _i3.AccountId32? maybePreclaim;

  @override
  Map<String, Map<String, List<int>?>> toJson() => {
        'move_claim': {
          'old': old.toList(),
          'new': new_.toList(),
          'maybePreclaim': maybePreclaim?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.EthereumAddressCodec().sizeHint(old);
    size = size + const _i5.EthereumAddressCodec().sizeHint(new_);
    size = size +
        const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(maybePreclaim);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      old,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      new_,
      output,
    );
    const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      maybePreclaim,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MoveClaim &&
          _i8.listsEqual(
            other.old,
            old,
          ) &&
          _i8.listsEqual(
            other.new_,
            new_,
          ) &&
          other.maybePreclaim == maybePreclaim;

  @override
  int get hashCode => Object.hash(
        old,
        new_,
        maybePreclaim,
      );
}
