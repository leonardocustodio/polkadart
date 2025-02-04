// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../../polkadot_parachain_primitives/primitives/head_data.dart'
    as _i4;
import '../../../polkadot_parachain_primitives/primitives/id.dart' as _i3;
import '../../../polkadot_parachain_primitives/primitives/validation_code.dart'
    as _i5;
import '../../../sp_core/crypto/account_id32.dart' as _i6;

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

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  Register register({
    required _i3.Id id,
    required _i4.HeadData genesisHead,
    required _i5.ValidationCode validationCode,
  }) {
    return Register(
      id: id,
      genesisHead: genesisHead,
      validationCode: validationCode,
    );
  }

  ForceRegister forceRegister({
    required _i6.AccountId32 who,
    required BigInt deposit,
    required _i3.Id id,
    required _i4.HeadData genesisHead,
    required _i5.ValidationCode validationCode,
  }) {
    return ForceRegister(
      who: who,
      deposit: deposit,
      id: id,
      genesisHead: genesisHead,
      validationCode: validationCode,
    );
  }

  Deregister deregister({required _i3.Id id}) {
    return Deregister(id: id);
  }

  Swap swap({
    required _i3.Id id,
    required _i3.Id other,
  }) {
    return Swap(
      id: id,
      other: other,
    );
  }

  RemoveLock removeLock({required _i3.Id para}) {
    return RemoveLock(para: para);
  }

  Reserve reserve() {
    return Reserve();
  }

  AddLock addLock({required _i3.Id para}) {
    return AddLock(para: para);
  }

  ScheduleCodeUpgrade scheduleCodeUpgrade({
    required _i3.Id para,
    required _i5.ValidationCode newCode,
  }) {
    return ScheduleCodeUpgrade(
      para: para,
      newCode: newCode,
    );
  }

  SetCurrentHead setCurrentHead({
    required _i3.Id para,
    required _i4.HeadData newHead,
  }) {
    return SetCurrentHead(
      para: para,
      newHead: newHead,
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
        return Register._decode(input);
      case 1:
        return ForceRegister._decode(input);
      case 2:
        return Deregister._decode(input);
      case 3:
        return Swap._decode(input);
      case 4:
        return RemoveLock._decode(input);
      case 5:
        return const Reserve();
      case 6:
        return AddLock._decode(input);
      case 7:
        return ScheduleCodeUpgrade._decode(input);
      case 8:
        return SetCurrentHead._decode(input);
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
      case Register:
        (value as Register).encodeTo(output);
        break;
      case ForceRegister:
        (value as ForceRegister).encodeTo(output);
        break;
      case Deregister:
        (value as Deregister).encodeTo(output);
        break;
      case Swap:
        (value as Swap).encodeTo(output);
        break;
      case RemoveLock:
        (value as RemoveLock).encodeTo(output);
        break;
      case Reserve:
        (value as Reserve).encodeTo(output);
        break;
      case AddLock:
        (value as AddLock).encodeTo(output);
        break;
      case ScheduleCodeUpgrade:
        (value as ScheduleCodeUpgrade).encodeTo(output);
        break;
      case SetCurrentHead:
        (value as SetCurrentHead).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Register:
        return (value as Register)._sizeHint();
      case ForceRegister:
        return (value as ForceRegister)._sizeHint();
      case Deregister:
        return (value as Deregister)._sizeHint();
      case Swap:
        return (value as Swap)._sizeHint();
      case RemoveLock:
        return (value as RemoveLock)._sizeHint();
      case Reserve:
        return 1;
      case AddLock:
        return (value as AddLock)._sizeHint();
      case ScheduleCodeUpgrade:
        return (value as ScheduleCodeUpgrade)._sizeHint();
      case SetCurrentHead:
        return (value as SetCurrentHead)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Register head data and validation code for a reserved Para Id.
///
/// ## Arguments
/// - `origin`: Must be called by a `Signed` origin.
/// - `id`: The para ID. Must be owned/managed by the `origin` signing account.
/// - `genesis_head`: The genesis head data of the parachain/thread.
/// - `validation_code`: The initial validation code of the parachain/thread.
///
/// ## Deposits/Fees
/// The account with the originating signature must reserve a deposit.
///
/// The deposit is required to cover the costs associated with storing the genesis head
/// data and the validation code.
/// This accounts for the potential to store validation code of a size up to the
/// `max_code_size`, as defined in the configuration pallet
///
/// Anything already reserved previously for this para ID is accounted for.
///
/// ## Events
/// The `Registered` event is emitted in case of success.
class Register extends Call {
  const Register({
    required this.id,
    required this.genesisHead,
    required this.validationCode,
  });

  factory Register._decode(_i1.Input input) {
    return Register(
      id: _i1.U32Codec.codec.decode(input),
      genesisHead: _i1.U8SequenceCodec.codec.decode(input),
      validationCode: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id id;

  /// HeadData
  final _i4.HeadData genesisHead;

  /// ValidationCode
  final _i5.ValidationCode validationCode;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'register': {
          'id': id,
          'genesisHead': genesisHead,
          'validationCode': validationCode,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(id);
    size = size + const _i4.HeadDataCodec().sizeHint(genesisHead);
    size = size + const _i5.ValidationCodeCodec().sizeHint(validationCode);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      id,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      genesisHead,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      validationCode,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Register &&
          other.id == id &&
          _i7.listsEqual(
            other.genesisHead,
            genesisHead,
          ) &&
          _i7.listsEqual(
            other.validationCode,
            validationCode,
          );

  @override
  int get hashCode => Object.hash(
        id,
        genesisHead,
        validationCode,
      );
}

/// Force the registration of a Para Id on the relay chain.
///
/// This function must be called by a Root origin.
///
/// The deposit taken can be specified for this registration. Any `ParaId`
/// can be registered, including sub-1000 IDs which are System Parachains.
class ForceRegister extends Call {
  const ForceRegister({
    required this.who,
    required this.deposit,
    required this.id,
    required this.genesisHead,
    required this.validationCode,
  });

  factory ForceRegister._decode(_i1.Input input) {
    return ForceRegister(
      who: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
      id: _i1.U32Codec.codec.decode(input),
      genesisHead: _i1.U8SequenceCodec.codec.decode(input),
      validationCode: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i6.AccountId32 who;

  /// BalanceOf<T>
  final BigInt deposit;

  /// ParaId
  final _i3.Id id;

  /// HeadData
  final _i4.HeadData genesisHead;

  /// ValidationCode
  final _i5.ValidationCode validationCode;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_register': {
          'who': who.toList(),
          'deposit': deposit,
          'id': id,
          'genesisHead': genesisHead,
          'validationCode': validationCode,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    size = size + const _i3.IdCodec().sizeHint(id);
    size = size + const _i4.HeadDataCodec().sizeHint(genesisHead);
    size = size + const _i5.ValidationCodeCodec().sizeHint(validationCode);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      id,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      genesisHead,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      validationCode,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceRegister &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          other.deposit == deposit &&
          other.id == id &&
          _i7.listsEqual(
            other.genesisHead,
            genesisHead,
          ) &&
          _i7.listsEqual(
            other.validationCode,
            validationCode,
          );

  @override
  int get hashCode => Object.hash(
        who,
        deposit,
        id,
        genesisHead,
        validationCode,
      );
}

/// Deregister a Para Id, freeing all data and returning any deposit.
///
/// The caller must be Root, the `para` owner, or the `para` itself. The para must be an
/// on-demand parachain.
class Deregister extends Call {
  const Deregister({required this.id});

  factory Deregister._decode(_i1.Input input) {
    return Deregister(id: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id id;

  @override
  Map<String, Map<String, int>> toJson() => {
        'deregister': {'id': id}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Deregister && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// Swap a lease holding parachain with another parachain, either on-demand or lease
/// holding.
///
/// The origin must be Root, the `para` owner, or the `para` itself.
///
/// The swap will happen only if there is already an opposite swap pending. If there is not,
/// the swap will be stored in the pending swaps map, ready for a later confirmatory swap.
///
/// The `ParaId`s remain mapped to the same head data and code so external code can rely on
/// `ParaId` to be a long-term identifier of a notional "parachain". However, their
/// scheduling info (i.e. whether they're an on-demand parachain or lease holding
/// parachain), auction information and the auction deposit are switched.
class Swap extends Call {
  const Swap({
    required this.id,
    required this.other,
  });

  factory Swap._decode(_i1.Input input) {
    return Swap(
      id: _i1.U32Codec.codec.decode(input),
      other: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id id;

  /// ParaId
  final _i3.Id other;

  @override
  Map<String, Map<String, int>> toJson() => {
        'swap': {
          'id': id,
          'other': other,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(id);
    size = size + const _i3.IdCodec().sizeHint(other);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      id,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      other,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Swap && other.id == id && other.other == this.other;

  @override
  int get hashCode => Object.hash(
        id,
        other,
      );
}

/// Remove a manager lock from a para. This will allow the manager of a
/// previously locked para to deregister or swap a para without using governance.
///
/// Can only be called by the Root origin or the parachain.
class RemoveLock extends Call {
  const RemoveLock({required this.para});

  factory RemoveLock._decode(_i1.Input input) {
    return RemoveLock(para: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id para;

  @override
  Map<String, Map<String, int>> toJson() => {
        'remove_lock': {'para': para}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      para,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveLock && other.para == para;

  @override
  int get hashCode => para.hashCode;
}

/// Reserve a Para Id on the relay chain.
///
/// This function will reserve a new Para Id to be owned/managed by the origin account.
/// The origin account is able to register head data and validation code using `register` to
/// create an on-demand parachain. Using the Slots pallet, an on-demand parachain can then
/// be upgraded to a lease holding parachain.
///
/// ## Arguments
/// - `origin`: Must be called by a `Signed` origin. Becomes the manager/owner of the new
///  para ID.
///
/// ## Deposits/Fees
/// The origin must reserve a deposit of `ParaDeposit` for the registration.
///
/// ## Events
/// The `Reserved` event is emitted in case of success, which provides the ID reserved for
/// use.
class Reserve extends Call {
  const Reserve();

  @override
  Map<String, dynamic> toJson() => {'reserve': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Reserve;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Add a manager lock from a para. This will prevent the manager of a
/// para to deregister or swap a para.
///
/// Can be called by Root, the parachain, or the parachain manager if the parachain is
/// unlocked.
class AddLock extends Call {
  const AddLock({required this.para});

  factory AddLock._decode(_i1.Input input) {
    return AddLock(para: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id para;

  @override
  Map<String, Map<String, int>> toJson() => {
        'add_lock': {'para': para}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      para,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddLock && other.para == para;

  @override
  int get hashCode => para.hashCode;
}

/// Schedule a parachain upgrade.
///
/// This will kick off a check of `new_code` by all validators. After the majority of the
/// validators have reported on the validity of the code, the code will either be enacted
/// or the upgrade will be rejected. If the code will be enacted, the current code of the
/// parachain will be overwritten directly. This means that any PoV will be checked by this
/// new code. The parachain itself will not be informed explicitly that the validation code
/// has changed.
///
/// Can be called by Root, the parachain, or the parachain manager if the parachain is
/// unlocked.
class ScheduleCodeUpgrade extends Call {
  const ScheduleCodeUpgrade({
    required this.para,
    required this.newCode,
  });

  factory ScheduleCodeUpgrade._decode(_i1.Input input) {
    return ScheduleCodeUpgrade(
      para: _i1.U32Codec.codec.decode(input),
      newCode: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id para;

  /// ValidationCode
  final _i5.ValidationCode newCode;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'schedule_code_upgrade': {
          'para': para,
          'newCode': newCode,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    size = size + const _i5.ValidationCodeCodec().sizeHint(newCode);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      para,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      newCode,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ScheduleCodeUpgrade &&
          other.para == para &&
          _i7.listsEqual(
            other.newCode,
            newCode,
          );

  @override
  int get hashCode => Object.hash(
        para,
        newCode,
      );
}

/// Set the parachain's current head.
///
/// Can be called by Root, the parachain, or the parachain manager if the parachain is
/// unlocked.
class SetCurrentHead extends Call {
  const SetCurrentHead({
    required this.para,
    required this.newHead,
  });

  factory SetCurrentHead._decode(_i1.Input input) {
    return SetCurrentHead(
      para: _i1.U32Codec.codec.decode(input),
      newHead: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id para;

  /// HeadData
  final _i4.HeadData newHead;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_current_head': {
          'para': para,
          'newHead': newHead,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    size = size + const _i4.HeadDataCodec().sizeHint(newHead);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      para,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      newHead,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetCurrentHead &&
          other.para == para &&
          _i7.listsEqual(
            other.newHead,
            newHead,
          );

  @override
  int get hashCode => Object.hash(
        para,
        newHead,
      );
}
