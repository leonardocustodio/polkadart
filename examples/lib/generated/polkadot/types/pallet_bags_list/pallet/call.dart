// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;

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

  Map<String, Map<String, Map<String, dynamic>>> toJson();
}

class $Call {
  const $Call();

  Rebag rebag({required _i3.MultiAddress dislocated}) {
    return Rebag(dislocated: dislocated);
  }

  PutInFrontOf putInFrontOf({required _i3.MultiAddress lighter}) {
    return PutInFrontOf(lighter: lighter);
  }

  PutInFrontOfOther putInFrontOfOther({
    required _i3.MultiAddress heavier,
    required _i3.MultiAddress lighter,
  }) {
    return PutInFrontOfOther(
      heavier: heavier,
      lighter: lighter,
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
        return Rebag._decode(input);
      case 1:
        return PutInFrontOf._decode(input);
      case 2:
        return PutInFrontOfOther._decode(input);
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
      case Rebag:
        (value as Rebag).encodeTo(output);
        break;
      case PutInFrontOf:
        (value as PutInFrontOf).encodeTo(output);
        break;
      case PutInFrontOfOther:
        (value as PutInFrontOfOther).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Rebag:
        return (value as Rebag)._sizeHint();
      case PutInFrontOf:
        return (value as PutInFrontOf)._sizeHint();
      case PutInFrontOfOther:
        return (value as PutInFrontOfOther)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Declare that some `dislocated` account has, through rewards or penalties, sufficiently
/// changed its score that it should properly fall into a different bag than its current
/// one.
///
/// Anyone can call this function about any potentially dislocated account.
///
/// Will always update the stored score of `dislocated` to the correct score, based on
/// `ScoreProvider`.
///
/// If `dislocated` does not exists, it returns an error.
class Rebag extends Call {
  const Rebag({required this.dislocated});

  factory Rebag._decode(_i1.Input input) {
    return Rebag(dislocated: _i3.MultiAddress.codec.decode(input));
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress dislocated;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'rebag': {'dislocated': dislocated.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(dislocated);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      dislocated,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Rebag && other.dislocated == dislocated;

  @override
  int get hashCode => dislocated.hashCode;
}

/// Move the caller's Id directly in front of `lighter`.
///
/// The dispatch origin for this call must be _Signed_ and can only be called by the Id of
/// the account going in front of `lighter`. Fee is payed by the origin under all
/// circumstances.
///
/// Only works if:
///
/// - both nodes are within the same bag,
/// - and `origin` has a greater `Score` than `lighter`.
class PutInFrontOf extends Call {
  const PutInFrontOf({required this.lighter});

  factory PutInFrontOf._decode(_i1.Input input) {
    return PutInFrontOf(lighter: _i3.MultiAddress.codec.decode(input));
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress lighter;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'put_in_front_of': {'lighter': lighter.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(lighter);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      lighter,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PutInFrontOf && other.lighter == lighter;

  @override
  int get hashCode => lighter.hashCode;
}

/// Same as [`Pallet::put_in_front_of`], but it can be called by anyone.
///
/// Fee is paid by the origin under all circumstances.
class PutInFrontOfOther extends Call {
  const PutInFrontOfOther({
    required this.heavier,
    required this.lighter,
  });

  factory PutInFrontOfOther._decode(_i1.Input input) {
    return PutInFrontOfOther(
      heavier: _i3.MultiAddress.codec.decode(input),
      lighter: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress heavier;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress lighter;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'put_in_front_of_other': {
          'heavier': heavier.toJson(),
          'lighter': lighter.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(heavier);
    size = size + _i3.MultiAddress.codec.sizeHint(lighter);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      heavier,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      lighter,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PutInFrontOfOther &&
          other.heavier == heavier &&
          other.lighter == lighter;

  @override
  int get hashCode => Object.hash(
        heavier,
        lighter,
      );
}
