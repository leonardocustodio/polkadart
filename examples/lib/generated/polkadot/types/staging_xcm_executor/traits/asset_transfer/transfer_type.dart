// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../xcm/versioned_location.dart' as _i3;

abstract class TransferType {
  const TransferType();

  factory TransferType.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $TransferTypeCodec codec = $TransferTypeCodec();

  static const $TransferType values = $TransferType();

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

class $TransferType {
  const $TransferType();

  Teleport teleport() {
    return Teleport();
  }

  LocalReserve localReserve() {
    return LocalReserve();
  }

  DestinationReserve destinationReserve() {
    return DestinationReserve();
  }

  RemoteReserve remoteReserve(_i3.VersionedLocation value0) {
    return RemoteReserve(value0);
  }
}

class $TransferTypeCodec with _i1.Codec<TransferType> {
  const $TransferTypeCodec();

  @override
  TransferType decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Teleport();
      case 1:
        return const LocalReserve();
      case 2:
        return const DestinationReserve();
      case 3:
        return RemoteReserve._decode(input);
      default:
        throw Exception('TransferType: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    TransferType value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Teleport:
        (value as Teleport).encodeTo(output);
        break;
      case LocalReserve:
        (value as LocalReserve).encodeTo(output);
        break;
      case DestinationReserve:
        (value as DestinationReserve).encodeTo(output);
        break;
      case RemoteReserve:
        (value as RemoteReserve).encodeTo(output);
        break;
      default:
        throw Exception(
            'TransferType: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(TransferType value) {
    switch (value.runtimeType) {
      case Teleport:
        return 1;
      case LocalReserve:
        return 1;
      case DestinationReserve:
        return 1;
      case RemoteReserve:
        return (value as RemoteReserve)._sizeHint();
      default:
        throw Exception(
            'TransferType: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Teleport extends TransferType {
  const Teleport();

  @override
  Map<String, dynamic> toJson() => {'Teleport': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Teleport;

  @override
  int get hashCode => runtimeType.hashCode;
}

class LocalReserve extends TransferType {
  const LocalReserve();

  @override
  Map<String, dynamic> toJson() => {'LocalReserve': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is LocalReserve;

  @override
  int get hashCode => runtimeType.hashCode;
}

class DestinationReserve extends TransferType {
  const DestinationReserve();

  @override
  Map<String, dynamic> toJson() => {'DestinationReserve': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is DestinationReserve;

  @override
  int get hashCode => runtimeType.hashCode;
}

class RemoteReserve extends TransferType {
  const RemoteReserve(this.value0);

  factory RemoteReserve._decode(_i1.Input input) {
    return RemoteReserve(_i3.VersionedLocation.codec.decode(input));
  }

  /// VersionedLocation
  final _i3.VersionedLocation value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'RemoteReserve': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocation.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
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
      other is RemoteReserve && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
