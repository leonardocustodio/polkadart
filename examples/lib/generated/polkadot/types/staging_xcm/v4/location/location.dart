// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../junctions/junctions.dart' as _i2;

class Location {
  const Location({
    required this.parents,
    required this.interior,
  });

  factory Location.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u8
  final int parents;

  /// Junctions
  final _i2.Junctions interior;

  static const $LocationCodec codec = $LocationCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'parents': parents,
        'interior': interior.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Location &&
          other.parents == parents &&
          other.interior == interior;

  @override
  int get hashCode => Object.hash(
        parents,
        interior,
      );
}

class $LocationCodec with _i1.Codec<Location> {
  const $LocationCodec();

  @override
  void encodeTo(
    Location obj,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      obj.parents,
      output,
    );
    _i2.Junctions.codec.encodeTo(
      obj.interior,
      output,
    );
  }

  @override
  Location decode(_i1.Input input) {
    return Location(
      parents: _i1.U8Codec.codec.decode(input),
      interior: _i2.Junctions.codec.decode(input),
    );
  }

  @override
  int sizeHint(Location obj) {
    int size = 0;
    size = size + _i1.U8Codec.codec.sizeHint(obj.parents);
    size = size + _i2.Junctions.codec.sizeHint(obj.interior);
    return size;
  }
}
