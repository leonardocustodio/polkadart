// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_parachain/primitives/id.dart' as _i3;
import '../../../polkadot_parachain/primitives/validation_code_hash.dart'
    as _i4;

///
///			The [event](https://docs.substrate.io/main-docs/build/events-errors/) emitted
///			by this pallet.
///
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  CurrentCodeUpdated currentCodeUpdated(_i3.Id value0) {
    return CurrentCodeUpdated(value0);
  }

  CurrentHeadUpdated currentHeadUpdated(_i3.Id value0) {
    return CurrentHeadUpdated(value0);
  }

  CodeUpgradeScheduled codeUpgradeScheduled(_i3.Id value0) {
    return CodeUpgradeScheduled(value0);
  }

  NewHeadNoted newHeadNoted(_i3.Id value0) {
    return NewHeadNoted(value0);
  }

  ActionQueued actionQueued(
    _i3.Id value0,
    int value1,
  ) {
    return ActionQueued(
      value0,
      value1,
    );
  }

  PvfCheckStarted pvfCheckStarted(
    _i4.ValidationCodeHash value0,
    _i3.Id value1,
  ) {
    return PvfCheckStarted(
      value0,
      value1,
    );
  }

  PvfCheckAccepted pvfCheckAccepted(
    _i4.ValidationCodeHash value0,
    _i3.Id value1,
  ) {
    return PvfCheckAccepted(
      value0,
      value1,
    );
  }

  PvfCheckRejected pvfCheckRejected(
    _i4.ValidationCodeHash value0,
    _i3.Id value1,
  ) {
    return PvfCheckRejected(
      value0,
      value1,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return CurrentCodeUpdated._decode(input);
      case 1:
        return CurrentHeadUpdated._decode(input);
      case 2:
        return CodeUpgradeScheduled._decode(input);
      case 3:
        return NewHeadNoted._decode(input);
      case 4:
        return ActionQueued._decode(input);
      case 5:
        return PvfCheckStarted._decode(input);
      case 6:
        return PvfCheckAccepted._decode(input);
      case 7:
        return PvfCheckRejected._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case CurrentCodeUpdated:
        (value as CurrentCodeUpdated).encodeTo(output);
        break;
      case CurrentHeadUpdated:
        (value as CurrentHeadUpdated).encodeTo(output);
        break;
      case CodeUpgradeScheduled:
        (value as CodeUpgradeScheduled).encodeTo(output);
        break;
      case NewHeadNoted:
        (value as NewHeadNoted).encodeTo(output);
        break;
      case ActionQueued:
        (value as ActionQueued).encodeTo(output);
        break;
      case PvfCheckStarted:
        (value as PvfCheckStarted).encodeTo(output);
        break;
      case PvfCheckAccepted:
        (value as PvfCheckAccepted).encodeTo(output);
        break;
      case PvfCheckRejected:
        (value as PvfCheckRejected).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case CurrentCodeUpdated:
        return (value as CurrentCodeUpdated)._sizeHint();
      case CurrentHeadUpdated:
        return (value as CurrentHeadUpdated)._sizeHint();
      case CodeUpgradeScheduled:
        return (value as CodeUpgradeScheduled)._sizeHint();
      case NewHeadNoted:
        return (value as NewHeadNoted)._sizeHint();
      case ActionQueued:
        return (value as ActionQueued)._sizeHint();
      case PvfCheckStarted:
        return (value as PvfCheckStarted)._sizeHint();
      case PvfCheckAccepted:
        return (value as PvfCheckAccepted)._sizeHint();
      case PvfCheckRejected:
        return (value as PvfCheckRejected)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Current code has been updated for a Para. `para_id`
class CurrentCodeUpdated extends Event {
  const CurrentCodeUpdated(this.value0);

  factory CurrentCodeUpdated._decode(_i1.Input input) {
    return CurrentCodeUpdated(_i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id value0;

  @override
  Map<String, int> toJson() => {'CurrentCodeUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CurrentCodeUpdated && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

/// Current head has been updated for a Para. `para_id`
class CurrentHeadUpdated extends Event {
  const CurrentHeadUpdated(this.value0);

  factory CurrentHeadUpdated._decode(_i1.Input input) {
    return CurrentHeadUpdated(_i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id value0;

  @override
  Map<String, int> toJson() => {'CurrentHeadUpdated': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CurrentHeadUpdated && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

/// A code upgrade has been scheduled for a Para. `para_id`
class CodeUpgradeScheduled extends Event {
  const CodeUpgradeScheduled(this.value0);

  factory CodeUpgradeScheduled._decode(_i1.Input input) {
    return CodeUpgradeScheduled(_i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id value0;

  @override
  Map<String, int> toJson() => {'CodeUpgradeScheduled': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CodeUpgradeScheduled && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

/// A new head has been noted for a Para. `para_id`
class NewHeadNoted extends Event {
  const NewHeadNoted(this.value0);

  factory NewHeadNoted._decode(_i1.Input input) {
    return NewHeadNoted(_i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id value0;

  @override
  Map<String, int> toJson() => {'NewHeadNoted': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NewHeadNoted && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

/// A para has been queued to execute pending actions. `para_id`
class ActionQueued extends Event {
  const ActionQueued(
    this.value0,
    this.value1,
  );

  factory ActionQueued._decode(_i1.Input input) {
    return ActionQueued(
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id value0;

  /// SessionIndex
  final int value1;

  @override
  Map<String, List<int>> toJson() => {
        'ActionQueued': [
          value0,
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    size = size + _i1.U32Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ActionQueued && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// The given para either initiated or subscribed to a PVF check for the given validation
/// code. `code_hash` `para_id`
class PvfCheckStarted extends Event {
  const PvfCheckStarted(
    this.value0,
    this.value1,
  );

  factory PvfCheckStarted._decode(_i1.Input input) {
    return PvfCheckStarted(
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// ValidationCodeHash
  final _i4.ValidationCodeHash value0;

  /// ParaId
  final _i3.Id value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'PvfCheckStarted': [
          value0.toList(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.ValidationCodeHashCodec().sizeHint(value0);
    size = size + const _i3.IdCodec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PvfCheckStarted &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// The given validation code was accepted by the PVF pre-checking vote.
/// `code_hash` `para_id`
class PvfCheckAccepted extends Event {
  const PvfCheckAccepted(
    this.value0,
    this.value1,
  );

  factory PvfCheckAccepted._decode(_i1.Input input) {
    return PvfCheckAccepted(
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// ValidationCodeHash
  final _i4.ValidationCodeHash value0;

  /// ParaId
  final _i3.Id value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'PvfCheckAccepted': [
          value0.toList(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.ValidationCodeHashCodec().sizeHint(value0);
    size = size + const _i3.IdCodec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PvfCheckAccepted &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// The given validation code was rejected by the PVF pre-checking vote.
/// `code_hash` `para_id`
class PvfCheckRejected extends Event {
  const PvfCheckRejected(
    this.value0,
    this.value1,
  );

  factory PvfCheckRejected._decode(_i1.Input input) {
    return PvfCheckRejected(
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// ValidationCodeHash
  final _i4.ValidationCodeHash value0;

  /// ParaId
  final _i3.Id value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'PvfCheckRejected': [
          value0.toList(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.ValidationCodeHashCodec().sizeHint(value0);
    size = size + const _i3.IdCodec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PvfCheckRejected &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}
