// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'ump_queue_id.dart' as _i3;

abstract class AggregateMessageOrigin {
  const AggregateMessageOrigin();

  factory AggregateMessageOrigin.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AggregateMessageOriginCodec codec =
      $AggregateMessageOriginCodec();

  static const $AggregateMessageOrigin values = $AggregateMessageOrigin();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, int>> toJson();
}

class $AggregateMessageOrigin {
  const $AggregateMessageOrigin();

  Ump ump(_i3.UmpQueueId value0) {
    return Ump(value0);
  }
}

class $AggregateMessageOriginCodec with _i1.Codec<AggregateMessageOrigin> {
  const $AggregateMessageOriginCodec();

  @override
  AggregateMessageOrigin decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Ump._decode(input);
      default:
        throw Exception(
            'AggregateMessageOrigin: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AggregateMessageOrigin value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Ump:
        (value as Ump).encodeTo(output);
        break;
      default:
        throw Exception(
            'AggregateMessageOrigin: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AggregateMessageOrigin value) {
    switch (value.runtimeType) {
      case Ump:
        return (value as Ump)._sizeHint();
      default:
        throw Exception(
            'AggregateMessageOrigin: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Ump extends AggregateMessageOrigin {
  const Ump(this.value0);

  factory Ump._decode(_i1.Input input) {
    return Ump(_i3.UmpQueueId.codec.decode(input));
  }

  /// UmpQueueId
  final _i3.UmpQueueId value0;

  @override
  Map<String, Map<String, int>> toJson() => {'Ump': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.UmpQueueId.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.UmpQueueId.codec.encodeTo(
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
      other is Ump && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
