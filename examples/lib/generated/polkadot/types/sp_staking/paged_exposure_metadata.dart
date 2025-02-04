// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class PagedExposureMetadata {
  const PagedExposureMetadata({
    required this.total,
    required this.own,
    required this.nominatorCount,
    required this.pageCount,
  });

  factory PagedExposureMetadata.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt total;

  /// Balance
  final BigInt own;

  /// u32
  final int nominatorCount;

  /// Page
  final int pageCount;

  static const $PagedExposureMetadataCodec codec =
      $PagedExposureMetadataCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'own': own,
        'nominatorCount': nominatorCount,
        'pageCount': pageCount,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PagedExposureMetadata &&
          other.total == total &&
          other.own == own &&
          other.nominatorCount == nominatorCount &&
          other.pageCount == pageCount;

  @override
  int get hashCode => Object.hash(
        total,
        own,
        nominatorCount,
        pageCount,
      );
}

class $PagedExposureMetadataCodec with _i1.Codec<PagedExposureMetadata> {
  const $PagedExposureMetadataCodec();

  @override
  void encodeTo(
    PagedExposureMetadata obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.total,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.own,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.nominatorCount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.pageCount,
      output,
    );
  }

  @override
  PagedExposureMetadata decode(_i1.Input input) {
    return PagedExposureMetadata(
      total: _i1.CompactBigIntCodec.codec.decode(input),
      own: _i1.CompactBigIntCodec.codec.decode(input),
      nominatorCount: _i1.U32Codec.codec.decode(input),
      pageCount: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(PagedExposureMetadata obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.total);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.own);
    size = size + _i1.U32Codec.codec.sizeHint(obj.nominatorCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.pageCount);
    return size;
  }
}
