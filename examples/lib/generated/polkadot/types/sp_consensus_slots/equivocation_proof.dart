// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../sp_consensus_babe/app/public.dart' as _i2;
import '../sp_runtime/generic/header/header.dart' as _i4;
import 'slot.dart' as _i3;

class EquivocationProof {
  const EquivocationProof({
    required this.offender,
    required this.slot,
    required this.firstHeader,
    required this.secondHeader,
  });

  factory EquivocationProof.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Id
  final _i2.Public offender;

  /// Slot
  final _i3.Slot slot;

  /// Header
  final _i4.Header firstHeader;

  /// Header
  final _i4.Header secondHeader;

  static const $EquivocationProofCodec codec = $EquivocationProofCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'offender': offender.toList(),
        'slot': slot,
        'firstHeader': firstHeader.toJson(),
        'secondHeader': secondHeader.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is EquivocationProof &&
          _i6.listsEqual(
            other.offender,
            offender,
          ) &&
          other.slot == slot &&
          other.firstHeader == firstHeader &&
          other.secondHeader == secondHeader;

  @override
  int get hashCode => Object.hash(
        offender,
        slot,
        firstHeader,
        secondHeader,
      );
}

class $EquivocationProofCodec with _i1.Codec<EquivocationProof> {
  const $EquivocationProofCodec();

  @override
  void encodeTo(
    EquivocationProof obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.offender,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.slot,
      output,
    );
    _i4.Header.codec.encodeTo(
      obj.firstHeader,
      output,
    );
    _i4.Header.codec.encodeTo(
      obj.secondHeader,
      output,
    );
  }

  @override
  EquivocationProof decode(_i1.Input input) {
    return EquivocationProof(
      offender: const _i1.U8ArrayCodec(32).decode(input),
      slot: _i1.U64Codec.codec.decode(input),
      firstHeader: _i4.Header.codec.decode(input),
      secondHeader: _i4.Header.codec.decode(input),
    );
  }

  @override
  int sizeHint(EquivocationProof obj) {
    int size = 0;
    size = size + const _i2.PublicCodec().sizeHint(obj.offender);
    size = size + const _i3.SlotCodec().sizeHint(obj.slot);
    size = size + _i4.Header.codec.sizeHint(obj.firstHeader);
    size = size + _i4.Header.codec.sizeHint(obj.secondHeader);
    return size;
  }
}
