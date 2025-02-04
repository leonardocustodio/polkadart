// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../frame_support/dispatch/raw_origin.dart' as _i3;
import '../pallet_xcm/pallet/origin.dart' as _i6;
import '../polkadot_runtime_parachains/origin/pallet/origin.dart' as _i5;
import '../sp_core/void.dart' as _i7;
import 'governance/origins/pallet_custom_origins/origin.dart' as _i4;

abstract class OriginCaller {
  const OriginCaller();

  factory OriginCaller.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $OriginCallerCodec codec = $OriginCallerCodec();

  static const $OriginCaller values = $OriginCaller();

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

class $OriginCaller {
  const $OriginCaller();

  System system(_i3.RawOrigin value0) {
    return System(value0);
  }

  Origins origins(_i4.Origin value0) {
    return Origins(value0);
  }

  ParachainsOrigin parachainsOrigin(_i5.Origin value0) {
    return ParachainsOrigin(value0);
  }

  XcmPallet xcmPallet(_i6.Origin value0) {
    return XcmPallet(value0);
  }

  Void void_(_i7.Void value0) {
    return Void(value0);
  }
}

class $OriginCallerCodec with _i1.Codec<OriginCaller> {
  const $OriginCallerCodec();

  @override
  OriginCaller decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return System._decode(input);
      case 22:
        return Origins._decode(input);
      case 50:
        return ParachainsOrigin._decode(input);
      case 99:
        return XcmPallet._decode(input);
      case 4:
        return Void._decode(input);
      default:
        throw Exception('OriginCaller: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    OriginCaller value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case System:
        (value as System).encodeTo(output);
        break;
      case Origins:
        (value as Origins).encodeTo(output);
        break;
      case ParachainsOrigin:
        (value as ParachainsOrigin).encodeTo(output);
        break;
      case XcmPallet:
        (value as XcmPallet).encodeTo(output);
        break;
      case Void:
        (value as Void).encodeTo(output);
        break;
      default:
        throw Exception(
            'OriginCaller: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(OriginCaller value) {
    switch (value.runtimeType) {
      case System:
        return (value as System)._sizeHint();
      case Origins:
        return (value as Origins)._sizeHint();
      case ParachainsOrigin:
        return (value as ParachainsOrigin)._sizeHint();
      case XcmPallet:
        return (value as XcmPallet)._sizeHint();
      case Void:
        return (value as Void)._sizeHint();
      default:
        throw Exception(
            'OriginCaller: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class System extends OriginCaller {
  const System(this.value0);

  factory System._decode(_i1.Input input) {
    return System(_i3.RawOrigin.codec.decode(input));
  }

  /// frame_system::Origin<Runtime>
  final _i3.RawOrigin value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'system': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.RawOrigin.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.RawOrigin.codec.encodeTo(
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
      other is System && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Origins extends OriginCaller {
  const Origins(this.value0);

  factory Origins._decode(_i1.Input input) {
    return Origins(_i4.Origin.codec.decode(input));
  }

  /// pallet_custom_origins::Origin
  final _i4.Origin value0;

  @override
  Map<String, String> toJson() => {'Origins': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Origin.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i4.Origin.codec.encodeTo(
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
      other is Origins && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class ParachainsOrigin extends OriginCaller {
  const ParachainsOrigin(this.value0);

  factory ParachainsOrigin._decode(_i1.Input input) {
    return ParachainsOrigin(_i5.Origin.codec.decode(input));
  }

  /// parachains_origin::Origin
  final _i5.Origin value0;

  @override
  Map<String, Map<String, int>> toJson() =>
      {'ParachainsOrigin': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Origin.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      50,
      output,
    );
    _i5.Origin.codec.encodeTo(
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
      other is ParachainsOrigin && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class XcmPallet extends OriginCaller {
  const XcmPallet(this.value0);

  factory XcmPallet._decode(_i1.Input input) {
    return XcmPallet(_i6.Origin.codec.decode(input));
  }

  /// pallet_xcm::Origin
  final _i6.Origin value0;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() =>
      {'XcmPallet': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i6.Origin.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      99,
      output,
    );
    _i6.Origin.codec.encodeTo(
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
      other is XcmPallet && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Void extends OriginCaller {
  const Void(this.value0);

  factory Void._decode(_i1.Input input) {
    return Void(_i1.NullCodec.codec.decode(input));
  }

  /// self::sp_api_hidden_includes_construct_runtime::hidden_include::
  ///__private::Void
  final _i7.Void value0;

  @override
  Map<String, dynamic> toJson() => {'Void': null};

  int _sizeHint() {
    int size = 1;
    size = size + const _i7.VoidCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.NullCodec.codec.encodeTo(
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
      other is Void && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
