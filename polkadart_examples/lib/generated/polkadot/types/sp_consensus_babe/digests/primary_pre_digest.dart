// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_consensus_slots/slot.dart' as _i2;
import '../../sp_core/sr25519/vrf/vrf_signature.dart' as _i3;

class PrimaryPreDigest {
  const PrimaryPreDigest({
    required this.authorityIndex,
    required this.slot,
    required this.vrfSignature,
  });

  factory PrimaryPreDigest.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// super::AuthorityIndex
  final int authorityIndex;

  /// Slot
  final _i2.Slot slot;

  /// VrfSignature
  final _i3.VrfSignature vrfSignature;

  static const $PrimaryPreDigestCodec codec = $PrimaryPreDigestCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'authorityIndex': authorityIndex,
        'slot': slot,
        'vrfSignature': vrfSignature.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PrimaryPreDigest &&
          other.authorityIndex == authorityIndex &&
          other.slot == slot &&
          other.vrfSignature == vrfSignature;

  @override
  int get hashCode => Object.hash(
        authorityIndex,
        slot,
        vrfSignature,
      );
}

class $PrimaryPreDigestCodec with _i1.Codec<PrimaryPreDigest> {
  const $PrimaryPreDigestCodec();

  @override
  void encodeTo(
    PrimaryPreDigest obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.authorityIndex,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.slot,
      output,
    );
    _i3.VrfSignature.codec.encodeTo(
      obj.vrfSignature,
      output,
    );
  }

  @override
  PrimaryPreDigest decode(_i1.Input input) {
    return PrimaryPreDigest(
      authorityIndex: _i1.U32Codec.codec.decode(input),
      slot: _i1.U64Codec.codec.decode(input),
      vrfSignature: _i3.VrfSignature.codec.decode(input),
    );
  }

  @override
  int sizeHint(PrimaryPreDigest obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.authorityIndex);
    size = size + const _i2.SlotCodec().sizeHint(obj.slot);
    size = size + _i3.VrfSignature.codec.sizeHint(obj.vrfSignature);
    return size;
  }
}
