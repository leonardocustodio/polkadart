// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class BoundedOpaqueNetworkState {
  const BoundedOpaqueNetworkState({
    required this.peerId,
    required this.externalAddresses,
  });

  factory BoundedOpaqueNetworkState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// WeakBoundedVec<u8, PeerIdEncodingLimit>
  final List<int> peerId;

  /// WeakBoundedVec<WeakBoundedVec<u8, MultiAddrEncodingLimit>, AddressesLimit
  ///>
  final List<List<int>> externalAddresses;

  static const $BoundedOpaqueNetworkStateCodec codec =
      $BoundedOpaqueNetworkStateCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<dynamic>> toJson() => {
        'peerId': peerId,
        'externalAddresses': externalAddresses.map((value) => value).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BoundedOpaqueNetworkState &&
          _i3.listsEqual(
            other.peerId,
            peerId,
          ) &&
          _i3.listsEqual(
            other.externalAddresses,
            externalAddresses,
          );

  @override
  int get hashCode => Object.hash(
        peerId,
        externalAddresses,
      );
}

class $BoundedOpaqueNetworkStateCodec
    with _i1.Codec<BoundedOpaqueNetworkState> {
  const $BoundedOpaqueNetworkStateCodec();

  @override
  void encodeTo(
    BoundedOpaqueNetworkState obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.peerId,
      output,
    );
    const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      obj.externalAddresses,
      output,
    );
  }

  @override
  BoundedOpaqueNetworkState decode(_i1.Input input) {
    return BoundedOpaqueNetworkState(
      peerId: _i1.U8SequenceCodec.codec.decode(input),
      externalAddresses:
          const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
              .decode(input),
    );
  }

  @override
  int sizeHint(BoundedOpaqueNetworkState obj) {
    int size = 0;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.peerId);
    size = size +
        const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
            .sizeHint(obj.externalAddresses);
    return size;
  }
}
