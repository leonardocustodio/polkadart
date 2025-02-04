// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

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

  RegisterFastUnstake registerFastUnstake() {
    return RegisterFastUnstake();
  }

  Deregister deregister() {
    return Deregister();
  }

  Control control({required int erasToCheck}) {
    return Control(erasToCheck: erasToCheck);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const RegisterFastUnstake();
      case 1:
        return const Deregister();
      case 2:
        return Control._decode(input);
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
      case RegisterFastUnstake:
        (value as RegisterFastUnstake).encodeTo(output);
        break;
      case Deregister:
        (value as Deregister).encodeTo(output);
        break;
      case Control:
        (value as Control).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case RegisterFastUnstake:
        return 1;
      case Deregister:
        return 1;
      case Control:
        return (value as Control)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Register oneself for fast-unstake.
///
/// ## Dispatch Origin
///
/// The dispatch origin of this call must be *signed* by whoever is permitted to call
/// unbond funds by the staking system. See [`Config::Staking`].
///
/// ## Details
///
/// The stash associated with the origin must have no ongoing unlocking chunks. If
/// successful, this will fully unbond and chill the stash. Then, it will enqueue the stash
/// to be checked in further blocks.
///
/// If by the time this is called, the stash is actually eligible for fast-unstake, then
/// they are guaranteed to remain eligible, because the call will chill them as well.
///
/// If the check works, the entire staking data is removed, i.e. the stash is fully
/// unstaked.
///
/// If the check fails, the stash remains chilled and waiting for being unbonded as in with
/// the normal staking system, but they lose part of their unbonding chunks due to consuming
/// the chain's resources.
///
/// ## Events
///
/// Some events from the staking and currency system might be emitted.
class RegisterFastUnstake extends Call {
  const RegisterFastUnstake();

  @override
  Map<String, dynamic> toJson() => {'register_fast_unstake': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is RegisterFastUnstake;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Deregister oneself from the fast-unstake.
///
/// ## Dispatch Origin
///
/// The dispatch origin of this call must be *signed* by whoever is permitted to call
/// unbond funds by the staking system. See [`Config::Staking`].
///
/// ## Details
///
/// This is useful if one is registered, they are still waiting, and they change their mind.
///
/// Note that the associated stash is still fully unbonded and chilled as a consequence of
/// calling [`Pallet::register_fast_unstake`]. Therefore, this should probably be followed
/// by a call to `rebond` in the staking system.
///
/// ## Events
///
/// Some events from the staking and currency system might be emitted.
class Deregister extends Call {
  const Deregister();

  @override
  Map<String, dynamic> toJson() => {'deregister': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Deregister;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Control the operation of this pallet.
///
/// ## Dispatch Origin
///
/// The dispatch origin of this call must be [`Config::ControlOrigin`].
///
/// ## Details
///
/// Can set the number of eras to check per block, and potentially other admin work.
///
/// ## Events
///
/// No events are emitted from this dispatch.
class Control extends Call {
  const Control({required this.erasToCheck});

  factory Control._decode(_i1.Input input) {
    return Control(erasToCheck: _i1.U32Codec.codec.decode(input));
  }

  /// EraIndex
  final int erasToCheck;

  @override
  Map<String, Map<String, int>> toJson() => {
        'control': {'erasToCheck': erasToCheck}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(erasToCheck);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      erasToCheck,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Control && other.erasToCheck == erasToCheck;

  @override
  int get hashCode => erasToCheck.hashCode;
}
