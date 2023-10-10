// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_weights/weight_v2/weight.dart' as _i3;
import 'multilocation/multi_location.dart' as _i2;

class QueryResponseInfo {
  const QueryResponseInfo({
    required this.destination,
    required this.queryId,
    required this.maxWeight,
  });

  factory QueryResponseInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// MultiLocation
  final _i2.MultiLocation destination;

  /// QueryId
  final BigInt queryId;

  /// Weight
  final _i3.Weight maxWeight;

  static const $QueryResponseInfoCodec codec = $QueryResponseInfoCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'destination': destination.toJson(),
        'queryId': queryId,
        'maxWeight': maxWeight.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is QueryResponseInfo &&
          other.destination == destination &&
          other.queryId == queryId &&
          other.maxWeight == maxWeight;

  @override
  int get hashCode => Object.hash(
        destination,
        queryId,
        maxWeight,
      );
}

class $QueryResponseInfoCodec with _i1.Codec<QueryResponseInfo> {
  const $QueryResponseInfoCodec();

  @override
  void encodeTo(
    QueryResponseInfo obj,
    _i1.Output output,
  ) {
    _i2.MultiLocation.codec.encodeTo(
      obj.destination,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.queryId,
      output,
    );
    _i3.Weight.codec.encodeTo(
      obj.maxWeight,
      output,
    );
  }

  @override
  QueryResponseInfo decode(_i1.Input input) {
    return QueryResponseInfo(
      destination: _i2.MultiLocation.codec.decode(input),
      queryId: _i1.CompactBigIntCodec.codec.decode(input),
      maxWeight: _i3.Weight.codec.decode(input),
    );
  }

  @override
  int sizeHint(QueryResponseInfo obj) {
    int size = 0;
    size = size + _i2.MultiLocation.codec.sizeHint(obj.destination);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.queryId);
    size = size + _i3.Weight.codec.sizeHint(obj.maxWeight);
    return size;
  }
}
