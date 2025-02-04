// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../availability_bitfield.dart' as _i2;
import '../validator_app/signature.dart' as _i4;
import '../validator_index.dart' as _i3;

class UncheckedSigned {
  const UncheckedSigned({
    required this.payload,
    required this.validatorIndex,
    required this.signature,
  });

  factory UncheckedSigned.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Payload
  final _i2.AvailabilityBitfield payload;

  /// ValidatorIndex
  final _i3.ValidatorIndex validatorIndex;

  /// ValidatorSignature
  final _i4.Signature signature;

  static const $UncheckedSignedCodec codec = $UncheckedSignedCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'payload': payload.toJson(),
        'validatorIndex': validatorIndex,
        'signature': signature.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UncheckedSigned &&
          other.payload == payload &&
          other.validatorIndex == validatorIndex &&
          _i6.listsEqual(
            other.signature,
            signature,
          );

  @override
  int get hashCode => Object.hash(
        payload,
        validatorIndex,
        signature,
      );
}

class $UncheckedSignedCodec with _i1.Codec<UncheckedSigned> {
  const $UncheckedSignedCodec();

  @override
  void encodeTo(
    UncheckedSigned obj,
    _i1.Output output,
  ) {
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.payload,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.validatorIndex,
      output,
    );
    const _i1.U8ArrayCodec(64).encodeTo(
      obj.signature,
      output,
    );
  }

  @override
  UncheckedSigned decode(_i1.Input input) {
    return UncheckedSigned(
      payload: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
      validatorIndex: _i1.U32Codec.codec.decode(input),
      signature: const _i1.U8ArrayCodec(64).decode(input),
    );
  }

  @override
  int sizeHint(UncheckedSigned obj) {
    int size = 0;
    size = size + const _i2.AvailabilityBitfieldCodec().sizeHint(obj.payload);
    size = size + const _i3.ValidatorIndexCodec().sizeHint(obj.validatorIndex);
    size = size + const _i4.SignatureCodec().sizeHint(obj.signature);
    return size;
  }
}
