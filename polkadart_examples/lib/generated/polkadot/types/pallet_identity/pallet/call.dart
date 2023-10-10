// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i11;

import '../../primitive_types/h256.dart' as _i10;
import '../../sp_core/crypto/account_id32.dart' as _i6;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;
import '../../tuples.dart' as _i5;
import '../types/bit_flags.dart' as _i8;
import '../types/data.dart' as _i7;
import '../types/identity_info.dart' as _i4;
import '../types/judgement.dart' as _i9;

/// Identity pallet declaration.
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

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  AddRegistrar addRegistrar({required _i3.MultiAddress account}) {
    return AddRegistrar(account: account);
  }

  SetIdentity setIdentity({required _i4.IdentityInfo info}) {
    return SetIdentity(info: info);
  }

  SetSubs setSubs({required List<_i5.Tuple2<_i6.AccountId32, _i7.Data>> subs}) {
    return SetSubs(subs: subs);
  }

  ClearIdentity clearIdentity() {
    return ClearIdentity();
  }

  RequestJudgement requestJudgement({
    required BigInt regIndex,
    required BigInt maxFee,
  }) {
    return RequestJudgement(
      regIndex: regIndex,
      maxFee: maxFee,
    );
  }

  CancelRequest cancelRequest({required int regIndex}) {
    return CancelRequest(regIndex: regIndex);
  }

  SetFee setFee({
    required BigInt index,
    required BigInt fee,
  }) {
    return SetFee(
      index: index,
      fee: fee,
    );
  }

  SetAccountId setAccountId({
    required BigInt index,
    required _i3.MultiAddress new_,
  }) {
    return SetAccountId(
      index: index,
      new_: new_,
    );
  }

  SetFields setFields({
    required BigInt index,
    required _i8.BitFlags fields,
  }) {
    return SetFields(
      index: index,
      fields: fields,
    );
  }

  ProvideJudgement provideJudgement({
    required BigInt regIndex,
    required _i3.MultiAddress target,
    required _i9.Judgement judgement,
    required _i10.H256 identity,
  }) {
    return ProvideJudgement(
      regIndex: regIndex,
      target: target,
      judgement: judgement,
      identity: identity,
    );
  }

  KillIdentity killIdentity({required _i3.MultiAddress target}) {
    return KillIdentity(target: target);
  }

  AddSub addSub({
    required _i3.MultiAddress sub,
    required _i7.Data data,
  }) {
    return AddSub(
      sub: sub,
      data: data,
    );
  }

  RenameSub renameSub({
    required _i3.MultiAddress sub,
    required _i7.Data data,
  }) {
    return RenameSub(
      sub: sub,
      data: data,
    );
  }

  RemoveSub removeSub({required _i3.MultiAddress sub}) {
    return RemoveSub(sub: sub);
  }

  QuitSub quitSub() {
    return QuitSub();
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return AddRegistrar._decode(input);
      case 1:
        return SetIdentity._decode(input);
      case 2:
        return SetSubs._decode(input);
      case 3:
        return const ClearIdentity();
      case 4:
        return RequestJudgement._decode(input);
      case 5:
        return CancelRequest._decode(input);
      case 6:
        return SetFee._decode(input);
      case 7:
        return SetAccountId._decode(input);
      case 8:
        return SetFields._decode(input);
      case 9:
        return ProvideJudgement._decode(input);
      case 10:
        return KillIdentity._decode(input);
      case 11:
        return AddSub._decode(input);
      case 12:
        return RenameSub._decode(input);
      case 13:
        return RemoveSub._decode(input);
      case 14:
        return const QuitSub();
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
      case AddRegistrar:
        (value as AddRegistrar).encodeTo(output);
        break;
      case SetIdentity:
        (value as SetIdentity).encodeTo(output);
        break;
      case SetSubs:
        (value as SetSubs).encodeTo(output);
        break;
      case ClearIdentity:
        (value as ClearIdentity).encodeTo(output);
        break;
      case RequestJudgement:
        (value as RequestJudgement).encodeTo(output);
        break;
      case CancelRequest:
        (value as CancelRequest).encodeTo(output);
        break;
      case SetFee:
        (value as SetFee).encodeTo(output);
        break;
      case SetAccountId:
        (value as SetAccountId).encodeTo(output);
        break;
      case SetFields:
        (value as SetFields).encodeTo(output);
        break;
      case ProvideJudgement:
        (value as ProvideJudgement).encodeTo(output);
        break;
      case KillIdentity:
        (value as KillIdentity).encodeTo(output);
        break;
      case AddSub:
        (value as AddSub).encodeTo(output);
        break;
      case RenameSub:
        (value as RenameSub).encodeTo(output);
        break;
      case RemoveSub:
        (value as RemoveSub).encodeTo(output);
        break;
      case QuitSub:
        (value as QuitSub).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case AddRegistrar:
        return (value as AddRegistrar)._sizeHint();
      case SetIdentity:
        return (value as SetIdentity)._sizeHint();
      case SetSubs:
        return (value as SetSubs)._sizeHint();
      case ClearIdentity:
        return 1;
      case RequestJudgement:
        return (value as RequestJudgement)._sizeHint();
      case CancelRequest:
        return (value as CancelRequest)._sizeHint();
      case SetFee:
        return (value as SetFee)._sizeHint();
      case SetAccountId:
        return (value as SetAccountId)._sizeHint();
      case SetFields:
        return (value as SetFields)._sizeHint();
      case ProvideJudgement:
        return (value as ProvideJudgement)._sizeHint();
      case KillIdentity:
        return (value as KillIdentity)._sizeHint();
      case AddSub:
        return (value as AddSub)._sizeHint();
      case RenameSub:
        return (value as RenameSub)._sizeHint();
      case RemoveSub:
        return (value as RemoveSub)._sizeHint();
      case QuitSub:
        return 1;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Add a registrar to the system.
///
/// The dispatch origin for this call must be `T::RegistrarOrigin`.
///
/// - `account`: the account of the registrar.
///
/// Emits `RegistrarAdded` if successful.
///
/// ## Complexity
/// - `O(R)` where `R` registrar-count (governance-bounded and code-bounded).
class AddRegistrar extends Call {
  const AddRegistrar({required this.account});

  factory AddRegistrar._decode(_i1.Input input) {
    return AddRegistrar(account: _i3.MultiAddress.codec.decode(input));
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress account;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'add_registrar': {'account': account.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(account);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      account,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddRegistrar && other.account == account;

  @override
  int get hashCode => account.hashCode;
}

/// Set an account's identity information and reserve the appropriate deposit.
///
/// If the account already has identity information, the deposit is taken as part payment
/// for the new deposit.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `info`: The identity information.
///
/// Emits `IdentitySet` if successful.
///
/// ## Complexity
/// - `O(X + X' + R)`
///  - where `X` additional-field-count (deposit-bounded and code-bounded)
///  - where `R` judgements-count (registrar-count-bounded)
class SetIdentity extends Call {
  const SetIdentity({required this.info});

  factory SetIdentity._decode(_i1.Input input) {
    return SetIdentity(info: _i4.IdentityInfo.codec.decode(input));
  }

  /// Box<IdentityInfo<T::MaxAdditionalFields>>
  final _i4.IdentityInfo info;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'set_identity': {'info': info.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.IdentityInfo.codec.sizeHint(info);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.IdentityInfo.codec.encodeTo(
      info,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetIdentity && other.info == info;

  @override
  int get hashCode => info.hashCode;
}

/// Set the sub-accounts of the sender.
///
/// Payment: Any aggregate balance reserved by previous `set_subs` calls will be returned
/// and an amount `SubAccountDeposit` will be reserved for each item in `subs`.
///
/// The dispatch origin for this call must be _Signed_ and the sender must have a registered
/// identity.
///
/// - `subs`: The identity's (new) sub-accounts.
///
/// ## Complexity
/// - `O(P + S)`
///  - where `P` old-subs-count (hard- and deposit-bounded).
///  - where `S` subs-count (hard- and deposit-bounded).
class SetSubs extends Call {
  const SetSubs({required this.subs});

  factory SetSubs._decode(_i1.Input input) {
    return SetSubs(
        subs: const _i1.SequenceCodec<_i5.Tuple2<_i6.AccountId32, _i7.Data>>(
            _i5.Tuple2Codec<_i6.AccountId32, _i7.Data>(
      _i6.AccountId32Codec(),
      _i7.Data.codec,
    )).decode(input));
  }

  /// Vec<(T::AccountId, Data)>
  final List<_i5.Tuple2<_i6.AccountId32, _i7.Data>> subs;

  @override
  Map<String, Map<String, List<List<dynamic>>>> toJson() => {
        'set_subs': {
          'subs': subs
              .map((value) => [
                    value.value0.toList(),
                    value.value1.toJson(),
                  ])
              .toList()
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i5.Tuple2<_i6.AccountId32, _i7.Data>>(
            _i5.Tuple2Codec<_i6.AccountId32, _i7.Data>(
          _i6.AccountId32Codec(),
          _i7.Data.codec,
        )).sizeHint(subs);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<_i5.Tuple2<_i6.AccountId32, _i7.Data>>(
        _i5.Tuple2Codec<_i6.AccountId32, _i7.Data>(
      _i6.AccountId32Codec(),
      _i7.Data.codec,
    )).encodeTo(
      subs,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetSubs &&
          _i11.listsEqual(
            other.subs,
            subs,
          );

  @override
  int get hashCode => subs.hashCode;
}

/// Clear an account's identity info and all sub-accounts and return all deposits.
///
/// Payment: All reserved balances on the account are returned.
///
/// The dispatch origin for this call must be _Signed_ and the sender must have a registered
/// identity.
///
/// Emits `IdentityCleared` if successful.
///
/// ## Complexity
/// - `O(R + S + X)`
///  - where `R` registrar-count (governance-bounded).
///  - where `S` subs-count (hard- and deposit-bounded).
///  - where `X` additional-field-count (deposit-bounded and code-bounded).
class ClearIdentity extends Call {
  const ClearIdentity();

  @override
  Map<String, dynamic> toJson() => {'clear_identity': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ClearIdentity;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Request a judgement from a registrar.
///
/// Payment: At most `max_fee` will be reserved for payment to the registrar if judgement
/// given.
///
/// The dispatch origin for this call must be _Signed_ and the sender must have a
/// registered identity.
///
/// - `reg_index`: The index of the registrar whose judgement is requested.
/// - `max_fee`: The maximum fee that may be paid. This should just be auto-populated as:
///
/// ```nocompile
/// Self::registrars().get(reg_index).unwrap().fee
/// ```
///
/// Emits `JudgementRequested` if successful.
///
/// ## Complexity
/// - `O(R + X)`.
///  - where `R` registrar-count (governance-bounded).
///  - where `X` additional-field-count (deposit-bounded and code-bounded).
class RequestJudgement extends Call {
  const RequestJudgement({
    required this.regIndex,
    required this.maxFee,
  });

  factory RequestJudgement._decode(_i1.Input input) {
    return RequestJudgement(
      regIndex: _i1.CompactBigIntCodec.codec.decode(input),
      maxFee: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// RegistrarIndex
  final BigInt regIndex;

  /// BalanceOf<T>
  final BigInt maxFee;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'request_judgement': {
          'regIndex': regIndex,
          'maxFee': maxFee,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(regIndex);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxFee);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      regIndex,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxFee,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RequestJudgement &&
          other.regIndex == regIndex &&
          other.maxFee == maxFee;

  @override
  int get hashCode => Object.hash(
        regIndex,
        maxFee,
      );
}

/// Cancel a previous request.
///
/// Payment: A previously reserved deposit is returned on success.
///
/// The dispatch origin for this call must be _Signed_ and the sender must have a
/// registered identity.
///
/// - `reg_index`: The index of the registrar whose judgement is no longer requested.
///
/// Emits `JudgementUnrequested` if successful.
///
/// ## Complexity
/// - `O(R + X)`.
///  - where `R` registrar-count (governance-bounded).
///  - where `X` additional-field-count (deposit-bounded and code-bounded).
class CancelRequest extends Call {
  const CancelRequest({required this.regIndex});

  factory CancelRequest._decode(_i1.Input input) {
    return CancelRequest(regIndex: _i1.U32Codec.codec.decode(input));
  }

  /// RegistrarIndex
  final int regIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'cancel_request': {'regIndex': regIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(regIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      regIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelRequest && other.regIndex == regIndex;

  @override
  int get hashCode => regIndex.hashCode;
}

/// Set the fee required for a judgement to be requested from a registrar.
///
/// The dispatch origin for this call must be _Signed_ and the sender must be the account
/// of the registrar whose index is `index`.
///
/// - `index`: the index of the registrar whose fee is to be set.
/// - `fee`: the new fee.
///
/// ## Complexity
/// - `O(R)`.
///  - where `R` registrar-count (governance-bounded).
class SetFee extends Call {
  const SetFee({
    required this.index,
    required this.fee,
  });

  factory SetFee._decode(_i1.Input input) {
    return SetFee(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      fee: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// RegistrarIndex
  final BigInt index;

  /// BalanceOf<T>
  final BigInt fee;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_fee': {
          'index': index,
          'fee': fee,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(fee);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      fee,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetFee && other.index == index && other.fee == fee;

  @override
  int get hashCode => Object.hash(
        index,
        fee,
      );
}

/// Change the account associated with a registrar.
///
/// The dispatch origin for this call must be _Signed_ and the sender must be the account
/// of the registrar whose index is `index`.
///
/// - `index`: the index of the registrar whose fee is to be set.
/// - `new`: the new account ID.
///
/// ## Complexity
/// - `O(R)`.
///  - where `R` registrar-count (governance-bounded).
class SetAccountId extends Call {
  const SetAccountId({
    required this.index,
    required this.new_,
  });

  factory SetAccountId._decode(_i1.Input input) {
    return SetAccountId(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      new_: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// RegistrarIndex
  final BigInt index;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress new_;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_account_id': {
          'index': index,
          'new': new_.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i3.MultiAddress.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetAccountId && other.index == index && other.new_ == new_;

  @override
  int get hashCode => Object.hash(
        index,
        new_,
      );
}

/// Set the field information for a registrar.
///
/// The dispatch origin for this call must be _Signed_ and the sender must be the account
/// of the registrar whose index is `index`.
///
/// - `index`: the index of the registrar whose fee is to be set.
/// - `fields`: the fields that the registrar concerns themselves with.
///
/// ## Complexity
/// - `O(R)`.
///  - where `R` registrar-count (governance-bounded).
class SetFields extends Call {
  const SetFields({
    required this.index,
    required this.fields,
  });

  factory SetFields._decode(_i1.Input input) {
    return SetFields(
      index: _i1.CompactBigIntCodec.codec.decode(input),
      fields: _i1.U64Codec.codec.decode(input),
    );
  }

  /// RegistrarIndex
  final BigInt index;

  /// IdentityFields
  final _i8.BitFlags fields;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_fields': {
          'index': index,
          'fields': fields,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + const _i8.BitFlagsCodec().sizeHint(fields);
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
    _i1.U64Codec.codec.encodeTo(
      fields,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetFields && other.index == index && other.fields == fields;

  @override
  int get hashCode => Object.hash(
        index,
        fields,
      );
}

/// Provide a judgement for an account's identity.
///
/// The dispatch origin for this call must be _Signed_ and the sender must be the account
/// of the registrar whose index is `reg_index`.
///
/// - `reg_index`: the index of the registrar whose judgement is being made.
/// - `target`: the account whose identity the judgement is upon. This must be an account
///  with a registered identity.
/// - `judgement`: the judgement of the registrar of index `reg_index` about `target`.
/// - `identity`: The hash of the [`IdentityInfo`] for that the judgement is provided.
///
/// Emits `JudgementGiven` if successful.
///
/// ## Complexity
/// - `O(R + X)`.
///  - where `R` registrar-count (governance-bounded).
///  - where `X` additional-field-count (deposit-bounded and code-bounded).
class ProvideJudgement extends Call {
  const ProvideJudgement({
    required this.regIndex,
    required this.target,
    required this.judgement,
    required this.identity,
  });

  factory ProvideJudgement._decode(_i1.Input input) {
    return ProvideJudgement(
      regIndex: _i1.CompactBigIntCodec.codec.decode(input),
      target: _i3.MultiAddress.codec.decode(input),
      judgement: _i9.Judgement.codec.decode(input),
      identity: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// RegistrarIndex
  final BigInt regIndex;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress target;

  /// Judgement<BalanceOf<T>>
  final _i9.Judgement judgement;

  /// T::Hash
  final _i10.H256 identity;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'provide_judgement': {
          'regIndex': regIndex,
          'target': target.toJson(),
          'judgement': judgement.toJson(),
          'identity': identity.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(regIndex);
    size = size + _i3.MultiAddress.codec.sizeHint(target);
    size = size + _i9.Judgement.codec.sizeHint(judgement);
    size = size + const _i10.H256Codec().sizeHint(identity);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      regIndex,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      target,
      output,
    );
    _i9.Judgement.codec.encodeTo(
      judgement,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      identity,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ProvideJudgement &&
          other.regIndex == regIndex &&
          other.target == target &&
          other.judgement == judgement &&
          _i11.listsEqual(
            other.identity,
            identity,
          );

  @override
  int get hashCode => Object.hash(
        regIndex,
        target,
        judgement,
        identity,
      );
}

/// Remove an account's identity and sub-account information and slash the deposits.
///
/// Payment: Reserved balances from `set_subs` and `set_identity` are slashed and handled by
/// `Slash`. Verification request deposits are not returned; they should be cancelled
/// manually using `cancel_request`.
///
/// The dispatch origin for this call must match `T::ForceOrigin`.
///
/// - `target`: the account whose identity the judgement is upon. This must be an account
///  with a registered identity.
///
/// Emits `IdentityKilled` if successful.
///
/// ## Complexity
/// - `O(R + S + X)`
///  - where `R` registrar-count (governance-bounded).
///  - where `S` subs-count (hard- and deposit-bounded).
///  - where `X` additional-field-count (deposit-bounded and code-bounded).
class KillIdentity extends Call {
  const KillIdentity({required this.target});

  factory KillIdentity._decode(_i1.Input input) {
    return KillIdentity(target: _i3.MultiAddress.codec.decode(input));
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress target;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'kill_identity': {'target': target.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(target);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      target,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is KillIdentity && other.target == target;

  @override
  int get hashCode => target.hashCode;
}

/// Add the given account to the sender's subs.
///
/// Payment: Balance reserved by a previous `set_subs` call for one sub will be repatriated
/// to the sender.
///
/// The dispatch origin for this call must be _Signed_ and the sender must have a registered
/// sub identity of `sub`.
class AddSub extends Call {
  const AddSub({
    required this.sub,
    required this.data,
  });

  factory AddSub._decode(_i1.Input input) {
    return AddSub(
      sub: _i3.MultiAddress.codec.decode(input),
      data: _i7.Data.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress sub;

  /// Data
  final _i7.Data data;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'add_sub': {
          'sub': sub.toJson(),
          'data': data.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(sub);
    size = size + _i7.Data.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      sub,
      output,
    );
    _i7.Data.codec.encodeTo(
      data,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddSub && other.sub == sub && other.data == data;

  @override
  int get hashCode => Object.hash(
        sub,
        data,
      );
}

/// Alter the associated name of the given sub-account.
///
/// The dispatch origin for this call must be _Signed_ and the sender must have a registered
/// sub identity of `sub`.
class RenameSub extends Call {
  const RenameSub({
    required this.sub,
    required this.data,
  });

  factory RenameSub._decode(_i1.Input input) {
    return RenameSub(
      sub: _i3.MultiAddress.codec.decode(input),
      data: _i7.Data.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress sub;

  /// Data
  final _i7.Data data;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'rename_sub': {
          'sub': sub.toJson(),
          'data': data.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(sub);
    size = size + _i7.Data.codec.sizeHint(data);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      sub,
      output,
    );
    _i7.Data.codec.encodeTo(
      data,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RenameSub && other.sub == sub && other.data == data;

  @override
  int get hashCode => Object.hash(
        sub,
        data,
      );
}

/// Remove the given account from the sender's subs.
///
/// Payment: Balance reserved by a previous `set_subs` call for one sub will be repatriated
/// to the sender.
///
/// The dispatch origin for this call must be _Signed_ and the sender must have a registered
/// sub identity of `sub`.
class RemoveSub extends Call {
  const RemoveSub({required this.sub});

  factory RemoveSub._decode(_i1.Input input) {
    return RemoveSub(sub: _i3.MultiAddress.codec.decode(input));
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress sub;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'remove_sub': {'sub': sub.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(sub);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      sub,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveSub && other.sub == sub;

  @override
  int get hashCode => sub.hashCode;
}

/// Remove the sender as a sub-account.
///
/// Payment: Balance reserved by a previous `set_subs` call for one sub will be repatriated
/// to the sender (*not* the original depositor).
///
/// The dispatch origin for this call must be _Signed_ and the sender must have a registered
/// super-identity.
///
/// NOTE: This should not normally be used, but is provided in the case that the non-
/// controller of an account is maliciously registered as a sub-account.
class QuitSub extends Call {
  const QuitSub();

  @override
  Map<String, dynamic> toJson() => {'quit_sub': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is QuitSub;

  @override
  int get hashCode => runtimeType.hashCode;
}
