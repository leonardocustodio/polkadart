// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../pallet_im_online/bounded_opaque_network_state.dart' as _i2;

class WrapperOpaque {
  const WrapperOpaque(
    this.value0,
    this.value1,
  );

  factory WrapperOpaque.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final BigInt value0;

  /// T
  final _i2.BoundedOpaqueNetworkState value1;

  static const $WrapperOpaqueCodec codec = $WrapperOpaqueCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  List<dynamic> toJson() => [
        value0,
        value1.toJson(),
      ];

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WrapperOpaque &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class $WrapperOpaqueCodec with _i1.Codec<WrapperOpaque> {
  const $WrapperOpaqueCodec();

  @override
  void encodeTo(
    WrapperOpaque obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.value0,
      output,
    );
    _i2.BoundedOpaqueNetworkState.codec.encodeTo(
      obj.value1,
      output,
    );
  }

  @override
  WrapperOpaque decode(_i1.Input input) {
    return WrapperOpaque(
      _i1.CompactBigIntCodec.codec.decode(input),
      _i2.BoundedOpaqueNetworkState.codec.decode(input),
    );
  }

  @override
  int sizeHint(WrapperOpaque obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.value0);
    size = size + _i2.BoundedOpaqueNetworkState.codec.sizeHint(obj.value1);
    return size;
  }
}
