// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../sp_core/crypto/account_id32.dart' as _i4;
import 'error.dart' as _i5;
import 'migration_compute.dart' as _i3;

/// Inner events of this pallet.
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

  Migrated migrated({
    required int top,
    required int child,
    required _i3.MigrationCompute compute,
  }) {
    return Migrated(
      top: top,
      child: child,
      compute: compute,
    );
  }

  Slashed slashed({
    required _i4.AccountId32 who,
    required BigInt amount,
  }) {
    return Slashed(
      who: who,
      amount: amount,
    );
  }

  AutoMigrationFinished autoMigrationFinished() {
    return AutoMigrationFinished();
  }

  Halted halted({required _i5.Error error}) {
    return Halted(error: error);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Migrated._decode(input);
      case 1:
        return Slashed._decode(input);
      case 2:
        return const AutoMigrationFinished();
      case 3:
        return Halted._decode(input);
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
      case Migrated:
        (value as Migrated).encodeTo(output);
        break;
      case Slashed:
        (value as Slashed).encodeTo(output);
        break;
      case AutoMigrationFinished:
        (value as AutoMigrationFinished).encodeTo(output);
        break;
      case Halted:
        (value as Halted).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Migrated:
        return (value as Migrated)._sizeHint();
      case Slashed:
        return (value as Slashed)._sizeHint();
      case AutoMigrationFinished:
        return 1;
      case Halted:
        return (value as Halted)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Given number of `(top, child)` keys were migrated respectively, with the given
/// `compute`.
class Migrated extends Event {
  const Migrated({
    required this.top,
    required this.child,
    required this.compute,
  });

  factory Migrated._decode(_i1.Input input) {
    return Migrated(
      top: _i1.U32Codec.codec.decode(input),
      child: _i1.U32Codec.codec.decode(input),
      compute: _i3.MigrationCompute.codec.decode(input),
    );
  }

  /// u32
  final int top;

  /// u32
  final int child;

  /// MigrationCompute
  final _i3.MigrationCompute compute;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Migrated': {
          'top': top,
          'child': child,
          'compute': compute.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(top);
    size = size + _i1.U32Codec.codec.sizeHint(child);
    size = size + _i3.MigrationCompute.codec.sizeHint(compute);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      top,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      child,
      output,
    );
    _i3.MigrationCompute.codec.encodeTo(
      compute,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Migrated &&
          other.top == top &&
          other.child == child &&
          other.compute == compute;

  @override
  int get hashCode => Object.hash(
        top,
        child,
        compute,
      );
}

/// Some account got slashed by the given amount.
class Slashed extends Event {
  const Slashed({
    required this.who,
    required this.amount,
  });

  factory Slashed._decode(_i1.Input input) {
    return Slashed(
      who: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 who;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Slashed': {
          'who': who.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
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
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Slashed &&
          _i6.listsEqual(
            other.who,
            who,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        who,
        amount,
      );
}

/// The auto migration task finished.
class AutoMigrationFinished extends Event {
  const AutoMigrationFinished();

  @override
  Map<String, dynamic> toJson() => {'AutoMigrationFinished': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is AutoMigrationFinished;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Migration got halted due to an error or miss-configuration.
class Halted extends Event {
  const Halted({required this.error});

  factory Halted._decode(_i1.Input input) {
    return Halted(error: _i5.Error.codec.decode(input));
  }

  /// Error<T>
  final _i5.Error error;

  @override
  Map<String, Map<String, String>> toJson() => {
        'Halted': {'error': error.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Error.codec.sizeHint(error);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i5.Error.codec.encodeTo(
      error,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Halted && other.error == error;

  @override
  int get hashCode => error.hashCode;
}
