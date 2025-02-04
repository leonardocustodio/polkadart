// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../pallet_nomination_pools/pallet/freeze_reason.dart' as _i3;

abstract class RuntimeFreezeReason {
  const RuntimeFreezeReason();

  factory RuntimeFreezeReason.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RuntimeFreezeReasonCodec codec = $RuntimeFreezeReasonCodec();

  static const $RuntimeFreezeReason values = $RuntimeFreezeReason();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, String> toJson();
}

class $RuntimeFreezeReason {
  const $RuntimeFreezeReason();

  NominationPools nominationPools(_i3.FreezeReason value0) {
    return NominationPools(value0);
  }
}

class $RuntimeFreezeReasonCodec with _i1.Codec<RuntimeFreezeReason> {
  const $RuntimeFreezeReasonCodec();

  @override
  RuntimeFreezeReason decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 39:
        return NominationPools._decode(input);
      default:
        throw Exception('RuntimeFreezeReason: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RuntimeFreezeReason value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case NominationPools:
        (value as NominationPools).encodeTo(output);
        break;
      default:
        throw Exception(
            'RuntimeFreezeReason: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RuntimeFreezeReason value) {
    switch (value.runtimeType) {
      case NominationPools:
        return (value as NominationPools)._sizeHint();
      default:
        throw Exception(
            'RuntimeFreezeReason: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class NominationPools extends RuntimeFreezeReason {
  const NominationPools(this.value0);

  factory NominationPools._decode(_i1.Input input) {
    return NominationPools(_i3.FreezeReason.codec.decode(input));
  }

  /// pallet_nomination_pools::FreezeReason
  final _i3.FreezeReason value0;

  @override
  Map<String, String> toJson() => {'NominationPools': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.FreezeReason.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      39,
      output,
    );
    _i3.FreezeReason.codec.encodeTo(
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
      other is NominationPools && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
