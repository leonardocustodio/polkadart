// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_consensus_slots/slot.dart' as _i2;

class SecondaryPlainPreDigest {
  const SecondaryPlainPreDigest({
    required this.authorityIndex,
    required this.slot,
  });

  factory SecondaryPlainPreDigest.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// super::AuthorityIndex
  final int authorityIndex;

  /// Slot
  final _i2.Slot slot;

  static const $SecondaryPlainPreDigestCodec codec =
      $SecondaryPlainPreDigestCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'authorityIndex': authorityIndex,
        'slot': slot,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SecondaryPlainPreDigest &&
          other.authorityIndex == authorityIndex &&
          other.slot == slot;

  @override
  int get hashCode => Object.hash(
        authorityIndex,
        slot,
      );
}

class $SecondaryPlainPreDigestCodec with _i1.Codec<SecondaryPlainPreDigest> {
  const $SecondaryPlainPreDigestCodec();

  @override
  void encodeTo(
    SecondaryPlainPreDigest obj,
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
  }

  @override
  SecondaryPlainPreDigest decode(_i1.Input input) {
    return SecondaryPlainPreDigest(
      authorityIndex: _i1.U32Codec.codec.decode(input),
      slot: _i1.U64Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(SecondaryPlainPreDigest obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.authorityIndex);
    size = size + const _i2.SlotCodec().sizeHint(obj.slot);
    return size;
  }
}
