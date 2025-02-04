// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../polkadot_core_primitives/outbound_hrmp_message.dart' as _i2;
import '../../polkadot_parachain_primitives/primitives/head_data.dart' as _i4;
import '../../polkadot_parachain_primitives/primitives/validation_code.dart'
    as _i3;

class CandidateCommitments {
  const CandidateCommitments({
    required this.upwardMessages,
    required this.horizontalMessages,
    this.newValidationCode,
    required this.headData,
    required this.processedDownwardMessages,
    required this.hrmpWatermark,
  });

  factory CandidateCommitments.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// UpwardMessages
  final List<List<int>> upwardMessages;

  /// HorizontalMessages
  final List<_i2.OutboundHrmpMessage> horizontalMessages;

  /// Option<ValidationCode>
  final _i3.ValidationCode? newValidationCode;

  /// HeadData
  final _i4.HeadData headData;

  /// u32
  final int processedDownwardMessages;

  /// N
  final int hrmpWatermark;

  static const $CandidateCommitmentsCodec codec = $CandidateCommitmentsCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'upwardMessages': upwardMessages.map((value) => value).toList(),
        'horizontalMessages':
            horizontalMessages.map((value) => value.toJson()).toList(),
        'newValidationCode': newValidationCode,
        'headData': headData,
        'processedDownwardMessages': processedDownwardMessages,
        'hrmpWatermark': hrmpWatermark,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CandidateCommitments &&
          _i6.listsEqual(
            other.upwardMessages,
            upwardMessages,
          ) &&
          _i6.listsEqual(
            other.horizontalMessages,
            horizontalMessages,
          ) &&
          other.newValidationCode == newValidationCode &&
          _i6.listsEqual(
            other.headData,
            headData,
          ) &&
          other.processedDownwardMessages == processedDownwardMessages &&
          other.hrmpWatermark == hrmpWatermark;

  @override
  int get hashCode => Object.hash(
        upwardMessages,
        horizontalMessages,
        newValidationCode,
        headData,
        processedDownwardMessages,
        hrmpWatermark,
      );
}

class $CandidateCommitmentsCodec with _i1.Codec<CandidateCommitments> {
  const $CandidateCommitmentsCodec();

  @override
  void encodeTo(
    CandidateCommitments obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      obj.upwardMessages,
      output,
    );
    const _i1.SequenceCodec<_i2.OutboundHrmpMessage>(
            _i2.OutboundHrmpMessage.codec)
        .encodeTo(
      obj.horizontalMessages,
      output,
    );
    const _i1.OptionCodec<_i3.ValidationCode>(_i3.ValidationCodeCodec())
        .encodeTo(
      obj.newValidationCode,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.headData,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.processedDownwardMessages,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpWatermark,
      output,
    );
  }

  @override
  CandidateCommitments decode(_i1.Input input) {
    return CandidateCommitments(
      upwardMessages:
          const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
              .decode(input),
      horizontalMessages: const _i1.SequenceCodec<_i2.OutboundHrmpMessage>(
              _i2.OutboundHrmpMessage.codec)
          .decode(input),
      newValidationCode:
          const _i1.OptionCodec<_i3.ValidationCode>(_i3.ValidationCodeCodec())
              .decode(input),
      headData: _i1.U8SequenceCodec.codec.decode(input),
      processedDownwardMessages: _i1.U32Codec.codec.decode(input),
      hrmpWatermark: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CandidateCommitments obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
            .sizeHint(obj.upwardMessages);
    size = size +
        const _i1.SequenceCodec<_i2.OutboundHrmpMessage>(
                _i2.OutboundHrmpMessage.codec)
            .sizeHint(obj.horizontalMessages);
    size = size +
        const _i1.OptionCodec<_i3.ValidationCode>(_i3.ValidationCodeCodec())
            .sizeHint(obj.newValidationCode);
    size = size + const _i4.HeadDataCodec().sizeHint(obj.headData);
    size = size + _i1.U32Codec.codec.sizeHint(obj.processedDownwardMessages);
    size = size + _i1.U32Codec.codec.sizeHint(obj.hrmpWatermark);
    return size;
  }
}
