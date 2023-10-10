// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_primitives/v4/availability_bitfield.dart' as _i2;

class AvailabilityBitfieldRecord {
  const AvailabilityBitfieldRecord({
    required this.bitfield,
    required this.submittedAt,
  });

  factory AvailabilityBitfieldRecord.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AvailabilityBitfield
  final _i2.AvailabilityBitfield bitfield;

  /// N
  final int submittedAt;

  static const $AvailabilityBitfieldRecordCodec codec =
      $AvailabilityBitfieldRecordCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'bitfield': bitfield.toJson(),
        'submittedAt': submittedAt,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AvailabilityBitfieldRecord &&
          other.bitfield == bitfield &&
          other.submittedAt == submittedAt;

  @override
  int get hashCode => Object.hash(
        bitfield,
        submittedAt,
      );
}

class $AvailabilityBitfieldRecordCodec
    with _i1.Codec<AvailabilityBitfieldRecord> {
  const $AvailabilityBitfieldRecordCodec();

  @override
  void encodeTo(
    AvailabilityBitfieldRecord obj,
    _i1.Output output,
  ) {
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.bitfield,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.submittedAt,
      output,
    );
  }

  @override
  AvailabilityBitfieldRecord decode(_i1.Input input) {
    return AvailabilityBitfieldRecord(
      bitfield: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
      submittedAt: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AvailabilityBitfieldRecord obj) {
    int size = 0;
    size = size + const _i2.AvailabilityBitfieldCodec().sizeHint(obj.bitfield);
    size = size + _i1.U32Codec.codec.sizeHint(obj.submittedAt);
    return size;
  }
}
