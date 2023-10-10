// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i9;

import '../../../polkadot_parachain/primitives/head_data.dart' as _i5;
import '../../../polkadot_parachain/primitives/id.dart' as _i3;
import '../../../polkadot_parachain/primitives/validation_code.dart' as _i4;
import '../../../polkadot_parachain/primitives/validation_code_hash.dart'
    as _i6;
import '../../../polkadot_primitives/v4/pvf_check_statement.dart' as _i7;
import '../../../polkadot_primitives/v4/validator_app/signature.dart' as _i8;

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

  ForceSetCurrentCode forceSetCurrentCode({
    required _i3.Id para,
    required _i4.ValidationCode newCode,
  }) {
    return ForceSetCurrentCode(
      para: para,
      newCode: newCode,
    );
  }

  ForceSetCurrentHead forceSetCurrentHead({
    required _i3.Id para,
    required _i5.HeadData newHead,
  }) {
    return ForceSetCurrentHead(
      para: para,
      newHead: newHead,
    );
  }

  ForceScheduleCodeUpgrade forceScheduleCodeUpgrade({
    required _i3.Id para,
    required _i4.ValidationCode newCode,
    required int relayParentNumber,
  }) {
    return ForceScheduleCodeUpgrade(
      para: para,
      newCode: newCode,
      relayParentNumber: relayParentNumber,
    );
  }

  ForceNoteNewHead forceNoteNewHead({
    required _i3.Id para,
    required _i5.HeadData newHead,
  }) {
    return ForceNoteNewHead(
      para: para,
      newHead: newHead,
    );
  }

  ForceQueueAction forceQueueAction({required _i3.Id para}) {
    return ForceQueueAction(para: para);
  }

  AddTrustedValidationCode addTrustedValidationCode(
      {required _i4.ValidationCode validationCode}) {
    return AddTrustedValidationCode(validationCode: validationCode);
  }

  PokeUnusedValidationCode pokeUnusedValidationCode(
      {required _i6.ValidationCodeHash validationCodeHash}) {
    return PokeUnusedValidationCode(validationCodeHash: validationCodeHash);
  }

  IncludePvfCheckStatement includePvfCheckStatement({
    required _i7.PvfCheckStatement stmt,
    required _i8.Signature signature,
  }) {
    return IncludePvfCheckStatement(
      stmt: stmt,
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
        return ForceSetCurrentCode._decode(input);
      case 1:
        return ForceSetCurrentHead._decode(input);
      case 2:
        return ForceScheduleCodeUpgrade._decode(input);
      case 3:
        return ForceNoteNewHead._decode(input);
      case 4:
        return ForceQueueAction._decode(input);
      case 5:
        return AddTrustedValidationCode._decode(input);
      case 6:
        return PokeUnusedValidationCode._decode(input);
      case 7:
        return IncludePvfCheckStatement._decode(input);
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
      case ForceSetCurrentCode:
        (value as ForceSetCurrentCode).encodeTo(output);
        break;
      case ForceSetCurrentHead:
        (value as ForceSetCurrentHead).encodeTo(output);
        break;
      case ForceScheduleCodeUpgrade:
        (value as ForceScheduleCodeUpgrade).encodeTo(output);
        break;
      case ForceNoteNewHead:
        (value as ForceNoteNewHead).encodeTo(output);
        break;
      case ForceQueueAction:
        (value as ForceQueueAction).encodeTo(output);
        break;
      case AddTrustedValidationCode:
        (value as AddTrustedValidationCode).encodeTo(output);
        break;
      case PokeUnusedValidationCode:
        (value as PokeUnusedValidationCode).encodeTo(output);
        break;
      case IncludePvfCheckStatement:
        (value as IncludePvfCheckStatement).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ForceSetCurrentCode:
        return (value as ForceSetCurrentCode)._sizeHint();
      case ForceSetCurrentHead:
        return (value as ForceSetCurrentHead)._sizeHint();
      case ForceScheduleCodeUpgrade:
        return (value as ForceScheduleCodeUpgrade)._sizeHint();
      case ForceNoteNewHead:
        return (value as ForceNoteNewHead)._sizeHint();
      case ForceQueueAction:
        return (value as ForceQueueAction)._sizeHint();
      case AddTrustedValidationCode:
        return (value as AddTrustedValidationCode)._sizeHint();
      case PokeUnusedValidationCode:
        return (value as PokeUnusedValidationCode)._sizeHint();
      case IncludePvfCheckStatement:
        return (value as IncludePvfCheckStatement)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Set the storage for the parachain validation code immediately.
class ForceSetCurrentCode extends Call {
  const ForceSetCurrentCode({
    required this.para,
    required this.newCode,
  });

  factory ForceSetCurrentCode._decode(_i1.Input input) {
    return ForceSetCurrentCode(
      para: _i1.U32Codec.codec.decode(input),
      newCode: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id para;

  /// ValidationCode
  final _i4.ValidationCode newCode;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_set_current_code': {
          'para': para,
          'newCode': newCode,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    size = size + const _i4.ValidationCodeCodec().sizeHint(newCode);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
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
      other is ForceSetCurrentCode &&
          other.para == para &&
          _i9.listsEqual(
            other.newCode,
            newCode,
          );

  @override
  int get hashCode => Object.hash(
        para,
        newCode,
      );
}

/// Set the storage for the current parachain head data immediately.
class ForceSetCurrentHead extends Call {
  const ForceSetCurrentHead({
    required this.para,
    required this.newHead,
  });

  factory ForceSetCurrentHead._decode(_i1.Input input) {
    return ForceSetCurrentHead(
      para: _i1.U32Codec.codec.decode(input),
      newHead: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id para;

  /// HeadData
  final _i5.HeadData newHead;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_set_current_head': {
          'para': para,
          'newHead': newHead,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    size = size + const _i5.HeadDataCodec().sizeHint(newHead);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
      other is ForceSetCurrentHead &&
          other.para == para &&
          _i9.listsEqual(
            other.newHead,
            newHead,
          );

  @override
  int get hashCode => Object.hash(
        para,
        newHead,
      );
}

/// Schedule an upgrade as if it was scheduled in the given relay parent block.
class ForceScheduleCodeUpgrade extends Call {
  const ForceScheduleCodeUpgrade({
    required this.para,
    required this.newCode,
    required this.relayParentNumber,
  });

  factory ForceScheduleCodeUpgrade._decode(_i1.Input input) {
    return ForceScheduleCodeUpgrade(
      para: _i1.U32Codec.codec.decode(input),
      newCode: _i1.U8SequenceCodec.codec.decode(input),
      relayParentNumber: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id para;

  /// ValidationCode
  final _i4.ValidationCode newCode;

  /// T::BlockNumber
  final int relayParentNumber;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_schedule_code_upgrade': {
          'para': para,
          'newCode': newCode,
          'relayParentNumber': relayParentNumber,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    size = size + const _i4.ValidationCodeCodec().sizeHint(newCode);
    size = size + _i1.U32Codec.codec.sizeHint(relayParentNumber);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
    _i1.U32Codec.codec.encodeTo(
      relayParentNumber,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceScheduleCodeUpgrade &&
          other.para == para &&
          _i9.listsEqual(
            other.newCode,
            newCode,
          ) &&
          other.relayParentNumber == relayParentNumber;

  @override
  int get hashCode => Object.hash(
        para,
        newCode,
        relayParentNumber,
      );
}

/// Note a new block head for para within the context of the current block.
class ForceNoteNewHead extends Call {
  const ForceNoteNewHead({
    required this.para,
    required this.newHead,
  });

  factory ForceNoteNewHead._decode(_i1.Input input) {
    return ForceNoteNewHead(
      para: _i1.U32Codec.codec.decode(input),
      newHead: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id para;

  /// HeadData
  final _i5.HeadData newHead;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_note_new_head': {
          'para': para,
          'newHead': newHead,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    size = size + const _i5.HeadDataCodec().sizeHint(newHead);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
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
      other is ForceNoteNewHead &&
          other.para == para &&
          _i9.listsEqual(
            other.newHead,
            newHead,
          );

  @override
  int get hashCode => Object.hash(
        para,
        newHead,
      );
}

/// Put a parachain directly into the next session's action queue.
/// We can't queue it any sooner than this without going into the
/// initializer...
class ForceQueueAction extends Call {
  const ForceQueueAction({required this.para});

  factory ForceQueueAction._decode(_i1.Input input) {
    return ForceQueueAction(para: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id para;

  @override
  Map<String, Map<String, int>> toJson() => {
        'force_queue_action': {'para': para}
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
      other is ForceQueueAction && other.para == para;

  @override
  int get hashCode => para.hashCode;
}

/// Adds the validation code to the storage.
///
/// The code will not be added if it is already present. Additionally, if PVF pre-checking
/// is running for that code, it will be instantly accepted.
///
/// Otherwise, the code will be added into the storage. Note that the code will be added
/// into storage with reference count 0. This is to account the fact that there are no users
/// for this code yet. The caller will have to make sure that this code eventually gets
/// used by some parachain or removed from the storage to avoid storage leaks. For the latter
/// prefer to use the `poke_unused_validation_code` dispatchable to raw storage manipulation.
///
/// This function is mainly meant to be used for upgrading parachains that do not follow
/// the go-ahead signal while the PVF pre-checking feature is enabled.
class AddTrustedValidationCode extends Call {
  const AddTrustedValidationCode({required this.validationCode});

  factory AddTrustedValidationCode._decode(_i1.Input input) {
    return AddTrustedValidationCode(
        validationCode: _i1.U8SequenceCodec.codec.decode(input));
  }

  /// ValidationCode
  final _i4.ValidationCode validationCode;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'add_trusted_validation_code': {'validationCode': validationCode}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.ValidationCodeCodec().sizeHint(validationCode);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
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
      other is AddTrustedValidationCode &&
          _i9.listsEqual(
            other.validationCode,
            validationCode,
          );

  @override
  int get hashCode => validationCode.hashCode;
}

/// Remove the validation code from the storage iff the reference count is 0.
///
/// This is better than removing the storage directly, because it will not remove the code
/// that was suddenly got used by some parachain while this dispatchable was pending
/// dispatching.
class PokeUnusedValidationCode extends Call {
  const PokeUnusedValidationCode({required this.validationCodeHash});

  factory PokeUnusedValidationCode._decode(_i1.Input input) {
    return PokeUnusedValidationCode(
        validationCodeHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// ValidationCodeHash
  final _i6.ValidationCodeHash validationCodeHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'poke_unused_validation_code': {
          'validationCodeHash': validationCodeHash.toList()
        }
      };

  int _sizeHint() {
    int size = 1;
    size =
        size + const _i6.ValidationCodeHashCodec().sizeHint(validationCodeHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      validationCodeHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PokeUnusedValidationCode &&
          other.validationCodeHash == validationCodeHash;

  @override
  int get hashCode => validationCodeHash.hashCode;
}

/// Includes a statement for a PVF pre-checking vote. Potentially, finalizes the vote and
/// enacts the results if that was the last vote before achieving the supermajority.
class IncludePvfCheckStatement extends Call {
  const IncludePvfCheckStatement({
    required this.stmt,
    required this.signature,
  });

  factory IncludePvfCheckStatement._decode(_i1.Input input) {
    return IncludePvfCheckStatement(
      stmt: _i7.PvfCheckStatement.codec.decode(input),
      signature: const _i1.U8ArrayCodec(64).decode(input),
    );
  }

  /// PvfCheckStatement
  final _i7.PvfCheckStatement stmt;

  /// ValidatorSignature
  final _i8.Signature signature;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'include_pvf_check_statement': {
          'stmt': stmt.toJson(),
          'signature': signature.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i7.PvfCheckStatement.codec.sizeHint(stmt);
    size = size + const _i8.SignatureCodec().sizeHint(signature);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i7.PvfCheckStatement.codec.encodeTo(
      stmt,
      output,
    );
    const _i1.U8ArrayCodec(64).encodeTo(
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
      other is IncludePvfCheckStatement &&
          other.stmt == stmt &&
          other.signature == signature;

  @override
  int get hashCode => Object.hash(
        stmt,
        signature,
      );
}
