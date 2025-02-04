// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class Error {
  const Error();

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ErrorCodec codec = $ErrorCodec();

  static const $Error values = $Error();

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

class $Error {
  const $Error();

  Overflow overflow() {
    return Overflow();
  }

  Unimplemented unimplemented() {
    return Unimplemented();
  }

  UntrustedReserveLocation untrustedReserveLocation() {
    return UntrustedReserveLocation();
  }

  UntrustedTeleportLocation untrustedTeleportLocation() {
    return UntrustedTeleportLocation();
  }

  MultiLocationFull multiLocationFull() {
    return MultiLocationFull();
  }

  MultiLocationNotInvertible multiLocationNotInvertible() {
    return MultiLocationNotInvertible();
  }

  BadOrigin badOrigin() {
    return BadOrigin();
  }

  InvalidLocation invalidLocation() {
    return InvalidLocation();
  }

  AssetNotFound assetNotFound() {
    return AssetNotFound();
  }

  FailedToTransactAsset failedToTransactAsset() {
    return FailedToTransactAsset();
  }

  NotWithdrawable notWithdrawable() {
    return NotWithdrawable();
  }

  LocationCannotHold locationCannotHold() {
    return LocationCannotHold();
  }

  ExceedsMaxMessageSize exceedsMaxMessageSize() {
    return ExceedsMaxMessageSize();
  }

  DestinationUnsupported destinationUnsupported() {
    return DestinationUnsupported();
  }

  Transport transport() {
    return Transport();
  }

  Unroutable unroutable() {
    return Unroutable();
  }

  UnknownClaim unknownClaim() {
    return UnknownClaim();
  }

  FailedToDecode failedToDecode() {
    return FailedToDecode();
  }

  MaxWeightInvalid maxWeightInvalid() {
    return MaxWeightInvalid();
  }

  NotHoldingFees notHoldingFees() {
    return NotHoldingFees();
  }

  TooExpensive tooExpensive() {
    return TooExpensive();
  }

  Trap trap(BigInt value0) {
    return Trap(value0);
  }

  UnhandledXcmVersion unhandledXcmVersion() {
    return UnhandledXcmVersion();
  }

  WeightLimitReached weightLimitReached(BigInt value0) {
    return WeightLimitReached(value0);
  }

  Barrier barrier() {
    return Barrier();
  }

  WeightNotComputable weightNotComputable() {
    return WeightNotComputable();
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Overflow();
      case 1:
        return const Unimplemented();
      case 2:
        return const UntrustedReserveLocation();
      case 3:
        return const UntrustedTeleportLocation();
      case 4:
        return const MultiLocationFull();
      case 5:
        return const MultiLocationNotInvertible();
      case 6:
        return const BadOrigin();
      case 7:
        return const InvalidLocation();
      case 8:
        return const AssetNotFound();
      case 9:
        return const FailedToTransactAsset();
      case 10:
        return const NotWithdrawable();
      case 11:
        return const LocationCannotHold();
      case 12:
        return const ExceedsMaxMessageSize();
      case 13:
        return const DestinationUnsupported();
      case 14:
        return const Transport();
      case 15:
        return const Unroutable();
      case 16:
        return const UnknownClaim();
      case 17:
        return const FailedToDecode();
      case 18:
        return const MaxWeightInvalid();
      case 19:
        return const NotHoldingFees();
      case 20:
        return const TooExpensive();
      case 21:
        return Trap._decode(input);
      case 22:
        return const UnhandledXcmVersion();
      case 23:
        return WeightLimitReached._decode(input);
      case 24:
        return const Barrier();
      case 25:
        return const WeightNotComputable();
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Overflow:
        (value as Overflow).encodeTo(output);
        break;
      case Unimplemented:
        (value as Unimplemented).encodeTo(output);
        break;
      case UntrustedReserveLocation:
        (value as UntrustedReserveLocation).encodeTo(output);
        break;
      case UntrustedTeleportLocation:
        (value as UntrustedTeleportLocation).encodeTo(output);
        break;
      case MultiLocationFull:
        (value as MultiLocationFull).encodeTo(output);
        break;
      case MultiLocationNotInvertible:
        (value as MultiLocationNotInvertible).encodeTo(output);
        break;
      case BadOrigin:
        (value as BadOrigin).encodeTo(output);
        break;
      case InvalidLocation:
        (value as InvalidLocation).encodeTo(output);
        break;
      case AssetNotFound:
        (value as AssetNotFound).encodeTo(output);
        break;
      case FailedToTransactAsset:
        (value as FailedToTransactAsset).encodeTo(output);
        break;
      case NotWithdrawable:
        (value as NotWithdrawable).encodeTo(output);
        break;
      case LocationCannotHold:
        (value as LocationCannotHold).encodeTo(output);
        break;
      case ExceedsMaxMessageSize:
        (value as ExceedsMaxMessageSize).encodeTo(output);
        break;
      case DestinationUnsupported:
        (value as DestinationUnsupported).encodeTo(output);
        break;
      case Transport:
        (value as Transport).encodeTo(output);
        break;
      case Unroutable:
        (value as Unroutable).encodeTo(output);
        break;
      case UnknownClaim:
        (value as UnknownClaim).encodeTo(output);
        break;
      case FailedToDecode:
        (value as FailedToDecode).encodeTo(output);
        break;
      case MaxWeightInvalid:
        (value as MaxWeightInvalid).encodeTo(output);
        break;
      case NotHoldingFees:
        (value as NotHoldingFees).encodeTo(output);
        break;
      case TooExpensive:
        (value as TooExpensive).encodeTo(output);
        break;
      case Trap:
        (value as Trap).encodeTo(output);
        break;
      case UnhandledXcmVersion:
        (value as UnhandledXcmVersion).encodeTo(output);
        break;
      case WeightLimitReached:
        (value as WeightLimitReached).encodeTo(output);
        break;
      case Barrier:
        (value as Barrier).encodeTo(output);
        break;
      case WeightNotComputable:
        (value as WeightNotComputable).encodeTo(output);
        break;
      default:
        throw Exception(
            'Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Error value) {
    switch (value.runtimeType) {
      case Overflow:
        return 1;
      case Unimplemented:
        return 1;
      case UntrustedReserveLocation:
        return 1;
      case UntrustedTeleportLocation:
        return 1;
      case MultiLocationFull:
        return 1;
      case MultiLocationNotInvertible:
        return 1;
      case BadOrigin:
        return 1;
      case InvalidLocation:
        return 1;
      case AssetNotFound:
        return 1;
      case FailedToTransactAsset:
        return 1;
      case NotWithdrawable:
        return 1;
      case LocationCannotHold:
        return 1;
      case ExceedsMaxMessageSize:
        return 1;
      case DestinationUnsupported:
        return 1;
      case Transport:
        return 1;
      case Unroutable:
        return 1;
      case UnknownClaim:
        return 1;
      case FailedToDecode:
        return 1;
      case MaxWeightInvalid:
        return 1;
      case NotHoldingFees:
        return 1;
      case TooExpensive:
        return 1;
      case Trap:
        return (value as Trap)._sizeHint();
      case UnhandledXcmVersion:
        return 1;
      case WeightLimitReached:
        return (value as WeightLimitReached)._sizeHint();
      case Barrier:
        return 1;
      case WeightNotComputable:
        return 1;
      default:
        throw Exception(
            'Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Overflow extends Error {
  const Overflow();

  @override
  Map<String, dynamic> toJson() => {'Overflow': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Overflow;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Unimplemented extends Error {
  const Unimplemented();

  @override
  Map<String, dynamic> toJson() => {'Unimplemented': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Unimplemented;

  @override
  int get hashCode => runtimeType.hashCode;
}

class UntrustedReserveLocation extends Error {
  const UntrustedReserveLocation();

  @override
  Map<String, dynamic> toJson() => {'UntrustedReserveLocation': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UntrustedReserveLocation;

  @override
  int get hashCode => runtimeType.hashCode;
}

class UntrustedTeleportLocation extends Error {
  const UntrustedTeleportLocation();

  @override
  Map<String, dynamic> toJson() => {'UntrustedTeleportLocation': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UntrustedTeleportLocation;

  @override
  int get hashCode => runtimeType.hashCode;
}

class MultiLocationFull extends Error {
  const MultiLocationFull();

  @override
  Map<String, dynamic> toJson() => {'MultiLocationFull': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MultiLocationFull;

  @override
  int get hashCode => runtimeType.hashCode;
}

class MultiLocationNotInvertible extends Error {
  const MultiLocationNotInvertible();

  @override
  Map<String, dynamic> toJson() => {'MultiLocationNotInvertible': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MultiLocationNotInvertible;

  @override
  int get hashCode => runtimeType.hashCode;
}

class BadOrigin extends Error {
  const BadOrigin();

  @override
  Map<String, dynamic> toJson() => {'BadOrigin': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is BadOrigin;

  @override
  int get hashCode => runtimeType.hashCode;
}

class InvalidLocation extends Error {
  const InvalidLocation();

  @override
  Map<String, dynamic> toJson() => {'InvalidLocation': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is InvalidLocation;

  @override
  int get hashCode => runtimeType.hashCode;
}

class AssetNotFound extends Error {
  const AssetNotFound();

  @override
  Map<String, dynamic> toJson() => {'AssetNotFound': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is AssetNotFound;

  @override
  int get hashCode => runtimeType.hashCode;
}

class FailedToTransactAsset extends Error {
  const FailedToTransactAsset();

  @override
  Map<String, dynamic> toJson() => {'FailedToTransactAsset': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is FailedToTransactAsset;

  @override
  int get hashCode => runtimeType.hashCode;
}

class NotWithdrawable extends Error {
  const NotWithdrawable();

  @override
  Map<String, dynamic> toJson() => {'NotWithdrawable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NotWithdrawable;

  @override
  int get hashCode => runtimeType.hashCode;
}

class LocationCannotHold extends Error {
  const LocationCannotHold();

  @override
  Map<String, dynamic> toJson() => {'LocationCannotHold': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is LocationCannotHold;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ExceedsMaxMessageSize extends Error {
  const ExceedsMaxMessageSize();

  @override
  Map<String, dynamic> toJson() => {'ExceedsMaxMessageSize': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ExceedsMaxMessageSize;

  @override
  int get hashCode => runtimeType.hashCode;
}

class DestinationUnsupported extends Error {
  const DestinationUnsupported();

  @override
  Map<String, dynamic> toJson() => {'DestinationUnsupported': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is DestinationUnsupported;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Transport extends Error {
  const Transport();

  @override
  Map<String, dynamic> toJson() => {'Transport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Transport;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Unroutable extends Error {
  const Unroutable();

  @override
  Map<String, dynamic> toJson() => {'Unroutable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Unroutable;

  @override
  int get hashCode => runtimeType.hashCode;
}

class UnknownClaim extends Error {
  const UnknownClaim();

  @override
  Map<String, dynamic> toJson() => {'UnknownClaim': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UnknownClaim;

  @override
  int get hashCode => runtimeType.hashCode;
}

class FailedToDecode extends Error {
  const FailedToDecode();

  @override
  Map<String, dynamic> toJson() => {'FailedToDecode': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is FailedToDecode;

  @override
  int get hashCode => runtimeType.hashCode;
}

class MaxWeightInvalid extends Error {
  const MaxWeightInvalid();

  @override
  Map<String, dynamic> toJson() => {'MaxWeightInvalid': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MaxWeightInvalid;

  @override
  int get hashCode => runtimeType.hashCode;
}

class NotHoldingFees extends Error {
  const NotHoldingFees();

  @override
  Map<String, dynamic> toJson() => {'NotHoldingFees': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NotHoldingFees;

  @override
  int get hashCode => runtimeType.hashCode;
}

class TooExpensive extends Error {
  const TooExpensive();

  @override
  Map<String, dynamic> toJson() => {'TooExpensive': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is TooExpensive;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Trap extends Error {
  const Trap(this.value0);

  factory Trap._decode(_i1.Input input) {
    return Trap(_i1.U64Codec.codec.decode(input));
  }

  /// u64
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'Trap': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is Trap && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class UnhandledXcmVersion extends Error {
  const UnhandledXcmVersion();

  @override
  Map<String, dynamic> toJson() => {'UnhandledXcmVersion': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is UnhandledXcmVersion;

  @override
  int get hashCode => runtimeType.hashCode;
}

class WeightLimitReached extends Error {
  const WeightLimitReached(this.value0);

  factory WeightLimitReached._decode(_i1.Input input) {
    return WeightLimitReached(_i1.U64Codec.codec.decode(input));
  }

  /// Weight
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'WeightLimitReached': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is WeightLimitReached && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Barrier extends Error {
  const Barrier();

  @override
  Map<String, dynamic> toJson() => {'Barrier': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Barrier;

  @override
  int get hashCode => runtimeType.hashCode;
}

class WeightNotComputable extends Error {
  const WeightNotComputable();

  @override
  Map<String, dynamic> toJson() => {'WeightNotComputable': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is WeightNotComputable;

  @override
  int get hashCode => runtimeType.hashCode;
}
