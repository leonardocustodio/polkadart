// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_parachain/primitives/id.dart' as _i3;

abstract class UmpQueueId {
  const UmpQueueId();

  factory UmpQueueId.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $UmpQueueIdCodec codec = $UmpQueueIdCodec();

  static const $UmpQueueId values = $UmpQueueId();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, int> toJson();
}

class $UmpQueueId {
  const $UmpQueueId();

  Para para(_i3.Id value0) {
    return Para(value0);
  }
}

class $UmpQueueIdCodec with _i1.Codec<UmpQueueId> {
  const $UmpQueueIdCodec();

  @override
  UmpQueueId decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Para._decode(input);
      default:
        throw Exception('UmpQueueId: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    UmpQueueId value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Para:
        (value as Para).encodeTo(output);
        break;
      default:
        throw Exception(
            'UmpQueueId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(UmpQueueId value) {
    switch (value.runtimeType) {
      case Para:
        return (value as Para)._sizeHint();
      default:
        throw Exception(
            'UmpQueueId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Para extends UmpQueueId {
  const Para(this.value0);

  factory Para._decode(_i1.Input input) {
    return Para(_i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id value0;

  @override
  Map<String, int> toJson() => {'Para': value0};

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
      other is Para && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
