// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class SpanRecord {
  const SpanRecord({
    required this.slashed,
    required this.paidOut,
  });

  factory SpanRecord.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt slashed;

  /// Balance
  final BigInt paidOut;

  static const $SpanRecordCodec codec = $SpanRecordCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'slashed': slashed,
        'paidOut': paidOut,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SpanRecord &&
          other.slashed == slashed &&
          other.paidOut == paidOut;

  @override
  int get hashCode => Object.hash(
        slashed,
        paidOut,
      );
}

class $SpanRecordCodec with _i1.Codec<SpanRecord> {
  const $SpanRecordCodec();

  @override
  void encodeTo(
    SpanRecord obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.slashed,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.paidOut,
      output,
    );
  }

  @override
  SpanRecord decode(_i1.Input input) {
    return SpanRecord(
      slashed: _i1.U128Codec.codec.decode(input),
      paidOut: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(SpanRecord obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.slashed);
    size = size + _i1.U128Codec.codec.sizeHint(obj.paidOut);
    return size;
  }
}
