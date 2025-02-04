// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import 'commitment/commitment.dart' as _i2;
import 'ecdsa_crypto/public.dart' as _i3;
import 'ecdsa_crypto/signature.dart' as _i4;

class VoteMessage {
  const VoteMessage({
    required this.commitment,
    required this.id,
    required this.signature,
  });

  factory VoteMessage.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Commitment<Number>
  final _i2.Commitment commitment;

  /// Id
  final _i3.Public id;

  /// Signature
  final _i4.Signature signature;

  static const $VoteMessageCodec codec = $VoteMessageCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'commitment': commitment.toJson(),
        'id': id.toList(),
        'signature': signature.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VoteMessage &&
          other.commitment == commitment &&
          _i6.listsEqual(
            other.id,
            id,
          ) &&
          _i6.listsEqual(
            other.signature,
            signature,
          );

  @override
  int get hashCode => Object.hash(
        commitment,
        id,
        signature,
      );
}

class $VoteMessageCodec with _i1.Codec<VoteMessage> {
  const $VoteMessageCodec();

  @override
  void encodeTo(
    VoteMessage obj,
    _i1.Output output,
  ) {
    _i2.Commitment.codec.encodeTo(
      obj.commitment,
      output,
    );
    const _i1.U8ArrayCodec(33).encodeTo(
      obj.id,
      output,
    );
    const _i1.U8ArrayCodec(65).encodeTo(
      obj.signature,
      output,
    );
  }

  @override
  VoteMessage decode(_i1.Input input) {
    return VoteMessage(
      commitment: _i2.Commitment.codec.decode(input),
      id: const _i1.U8ArrayCodec(33).decode(input),
      signature: const _i1.U8ArrayCodec(65).decode(input),
    );
  }

  @override
  int sizeHint(VoteMessage obj) {
    int size = 0;
    size = size + _i2.Commitment.codec.sizeHint(obj.commitment);
    size = size + const _i3.PublicCodec().sizeHint(obj.id);
    size = size + const _i4.SignatureCodec().sizeHint(obj.signature);
    return size;
  }
}
