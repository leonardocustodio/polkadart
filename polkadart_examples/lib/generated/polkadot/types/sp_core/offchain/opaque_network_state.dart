// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../opaque_peer_id.dart' as _i2;
import 'opaque_multiaddr.dart' as _i3;

class OpaqueNetworkState {
  const OpaqueNetworkState({
    required this.peerId,
    required this.externalAddresses,
  });

  factory OpaqueNetworkState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// OpaquePeerId
  final _i2.OpaquePeerId peerId;

  /// Vec<OpaqueMultiaddr>
  final List<_i3.OpaqueMultiaddr> externalAddresses;

  static const $OpaqueNetworkStateCodec codec = $OpaqueNetworkStateCodec();

  _i4.Uint8List encode() {
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
      other is OpaqueNetworkState &&
          _i5.listsEqual(
            other.peerId,
            peerId,
          ) &&
          _i5.listsEqual(
            other.externalAddresses,
            externalAddresses,
          );

  @override
  int get hashCode => Object.hash(
        peerId,
        externalAddresses,
      );
}

class $OpaqueNetworkStateCodec with _i1.Codec<OpaqueNetworkState> {
  const $OpaqueNetworkStateCodec();

  @override
  void encodeTo(
    OpaqueNetworkState obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.peerId,
      output,
    );
    const _i1.SequenceCodec<_i3.OpaqueMultiaddr>(_i3.OpaqueMultiaddrCodec())
        .encodeTo(
      obj.externalAddresses,
      output,
    );
  }

  @override
  OpaqueNetworkState decode(_i1.Input input) {
    return OpaqueNetworkState(
      peerId: _i1.U8SequenceCodec.codec.decode(input),
      externalAddresses: const _i1.SequenceCodec<_i3.OpaqueMultiaddr>(
              _i3.OpaqueMultiaddrCodec())
          .decode(input),
    );
  }

  @override
  int sizeHint(OpaqueNetworkState obj) {
    int size = 0;
    size = size + const _i2.OpaquePeerIdCodec().sizeHint(obj.peerId);
    size = size +
        const _i1.SequenceCodec<_i3.OpaqueMultiaddr>(_i3.OpaqueMultiaddrCodec())
            .sizeHint(obj.externalAddresses);
    return size;
  }
}
