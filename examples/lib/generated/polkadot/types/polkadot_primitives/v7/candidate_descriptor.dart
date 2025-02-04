// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i7;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../polkadot_parachain_primitives/primitives/id.dart' as _i2;
import '../../polkadot_parachain_primitives/primitives/validation_code_hash.dart'
    as _i6;
import '../../primitive_types/h256.dart' as _i3;
import 'collator_app/public.dart' as _i4;
import 'collator_app/signature.dart' as _i5;

class CandidateDescriptor {
  const CandidateDescriptor({
    required this.paraId,
    required this.relayParent,
    required this.collator,
    required this.persistedValidationDataHash,
    required this.povHash,
    required this.erasureRoot,
    required this.signature,
    required this.paraHead,
    required this.validationCodeHash,
  });

  factory CandidateDescriptor.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Id
  final _i2.Id paraId;

  /// H
  final _i3.H256 relayParent;

  /// CollatorId
  final _i4.Public collator;

  /// Hash
  final _i3.H256 persistedValidationDataHash;

  /// Hash
  final _i3.H256 povHash;

  /// Hash
  final _i3.H256 erasureRoot;

  /// CollatorSignature
  final _i5.Signature signature;

  /// Hash
  final _i3.H256 paraHead;

  /// ValidationCodeHash
  final _i6.ValidationCodeHash validationCodeHash;

  static const $CandidateDescriptorCodec codec = $CandidateDescriptorCodec();

  _i7.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'paraId': paraId,
        'relayParent': relayParent.toList(),
        'collator': collator.toList(),
        'persistedValidationDataHash': persistedValidationDataHash.toList(),
        'povHash': povHash.toList(),
        'erasureRoot': erasureRoot.toList(),
        'signature': signature.toList(),
        'paraHead': paraHead.toList(),
        'validationCodeHash': validationCodeHash.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CandidateDescriptor &&
          other.paraId == paraId &&
          _i8.listsEqual(
            other.relayParent,
            relayParent,
          ) &&
          _i8.listsEqual(
            other.collator,
            collator,
          ) &&
          _i8.listsEqual(
            other.persistedValidationDataHash,
            persistedValidationDataHash,
          ) &&
          _i8.listsEqual(
            other.povHash,
            povHash,
          ) &&
          _i8.listsEqual(
            other.erasureRoot,
            erasureRoot,
          ) &&
          _i8.listsEqual(
            other.signature,
            signature,
          ) &&
          _i8.listsEqual(
            other.paraHead,
            paraHead,
          ) &&
          other.validationCodeHash == validationCodeHash;

  @override
  int get hashCode => Object.hash(
        paraId,
        relayParent,
        collator,
        persistedValidationDataHash,
        povHash,
        erasureRoot,
        signature,
        paraHead,
        validationCodeHash,
      );
}

class $CandidateDescriptorCodec with _i1.Codec<CandidateDescriptor> {
  const $CandidateDescriptorCodec();

  @override
  void encodeTo(
    CandidateDescriptor obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.paraId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.relayParent,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.collator,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.persistedValidationDataHash,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.povHash,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.erasureRoot,
      output,
    );
    const _i1.U8ArrayCodec(64).encodeTo(
      obj.signature,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.paraHead,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.validationCodeHash,
      output,
    );
  }

  @override
  CandidateDescriptor decode(_i1.Input input) {
    return CandidateDescriptor(
      paraId: _i1.U32Codec.codec.decode(input),
      relayParent: const _i1.U8ArrayCodec(32).decode(input),
      collator: const _i1.U8ArrayCodec(32).decode(input),
      persistedValidationDataHash: const _i1.U8ArrayCodec(32).decode(input),
      povHash: const _i1.U8ArrayCodec(32).decode(input),
      erasureRoot: const _i1.U8ArrayCodec(32).decode(input),
      signature: const _i1.U8ArrayCodec(64).decode(input),
      paraHead: const _i1.U8ArrayCodec(32).decode(input),
      validationCodeHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(CandidateDescriptor obj) {
    int size = 0;
    size = size + const _i2.IdCodec().sizeHint(obj.paraId);
    size = size + const _i3.H256Codec().sizeHint(obj.relayParent);
    size = size + const _i4.PublicCodec().sizeHint(obj.collator);
    size =
        size + const _i3.H256Codec().sizeHint(obj.persistedValidationDataHash);
    size = size + const _i3.H256Codec().sizeHint(obj.povHash);
    size = size + const _i3.H256Codec().sizeHint(obj.erasureRoot);
    size = size + const _i5.SignatureCodec().sizeHint(obj.signature);
    size = size + const _i3.H256Codec().sizeHint(obj.paraHead);
    size = size +
        const _i6.ValidationCodeHashCodec().sizeHint(obj.validationCodeHash);
    return size;
  }
}
