// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'mode.dart' as _i2;

class CheckMetadataHash {
  const CheckMetadataHash({required this.mode});

  factory CheckMetadataHash.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Mode
  final _i2.Mode mode;

  static const $CheckMetadataHashCodec codec = $CheckMetadataHashCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, String> toJson() => {'mode': mode.toJson()};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CheckMetadataHash && other.mode == mode;

  @override
  int get hashCode => mode.hashCode;
}

class $CheckMetadataHashCodec with _i1.Codec<CheckMetadataHash> {
  const $CheckMetadataHashCodec();

  @override
  void encodeTo(
    CheckMetadataHash obj,
    _i1.Output output,
  ) {
    _i2.Mode.codec.encodeTo(
      obj.mode,
      output,
    );
  }

  @override
  CheckMetadataHash decode(_i1.Input input) {
    return CheckMetadataHash(mode: _i2.Mode.codec.decode(input));
  }

  @override
  int sizeHint(CheckMetadataHash obj) {
    int size = 0;
    size = size + _i2.Mode.codec.sizeHint(obj.mode);
    return size;
  }
}
