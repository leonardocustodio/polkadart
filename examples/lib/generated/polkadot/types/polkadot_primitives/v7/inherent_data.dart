// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../sp_runtime/generic/header/header.dart' as _i5;
import 'backed_candidate.dart' as _i3;
import 'dispute_statement_set.dart' as _i4;
import 'signed/unchecked_signed.dart' as _i2;

class InherentData {
  const InherentData({
    required this.bitfields,
    required this.backedCandidates,
    required this.disputes,
    required this.parentHeader,
  });

  factory InherentData.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// UncheckedSignedAvailabilityBitfields
  final List<_i2.UncheckedSigned> bitfields;

  /// Vec<BackedCandidate<HDR::Hash>>
  final List<_i3.BackedCandidate> backedCandidates;

  /// MultiDisputeStatementSet
  final List<_i4.DisputeStatementSet> disputes;

  /// HDR
  final _i5.Header parentHeader;

  static const $InherentDataCodec codec = $InherentDataCodec();

  _i6.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'bitfields': bitfields.map((value) => value.toJson()).toList(),
        'backedCandidates':
            backedCandidates.map((value) => value.toJson()).toList(),
        'disputes': disputes.map((value) => value.toJson()).toList(),
        'parentHeader': parentHeader.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InherentData &&
          _i7.listsEqual(
            other.bitfields,
            bitfields,
          ) &&
          _i7.listsEqual(
            other.backedCandidates,
            backedCandidates,
          ) &&
          _i7.listsEqual(
            other.disputes,
            disputes,
          ) &&
          other.parentHeader == parentHeader;

  @override
  int get hashCode => Object.hash(
        bitfields,
        backedCandidates,
        disputes,
        parentHeader,
      );
}

class $InherentDataCodec with _i1.Codec<InherentData> {
  const $InherentDataCodec();

  @override
  void encodeTo(
    InherentData obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.UncheckedSigned>(_i2.UncheckedSigned.codec)
        .encodeTo(
      obj.bitfields,
      output,
    );
    const _i1.SequenceCodec<_i3.BackedCandidate>(_i3.BackedCandidate.codec)
        .encodeTo(
      obj.backedCandidates,
      output,
    );
    const _i1.SequenceCodec<_i4.DisputeStatementSet>(
            _i4.DisputeStatementSet.codec)
        .encodeTo(
      obj.disputes,
      output,
    );
    _i5.Header.codec.encodeTo(
      obj.parentHeader,
      output,
    );
  }

  @override
  InherentData decode(_i1.Input input) {
    return InherentData(
      bitfields: const _i1.SequenceCodec<_i2.UncheckedSigned>(
              _i2.UncheckedSigned.codec)
          .decode(input),
      backedCandidates: const _i1.SequenceCodec<_i3.BackedCandidate>(
              _i3.BackedCandidate.codec)
          .decode(input),
      disputes: const _i1.SequenceCodec<_i4.DisputeStatementSet>(
              _i4.DisputeStatementSet.codec)
          .decode(input),
      parentHeader: _i5.Header.codec.decode(input),
    );
  }

  @override
  int sizeHint(InherentData obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.UncheckedSigned>(_i2.UncheckedSigned.codec)
            .sizeHint(obj.bitfields);
    size = size +
        const _i1.SequenceCodec<_i3.BackedCandidate>(_i3.BackedCandidate.codec)
            .sizeHint(obj.backedCandidates);
    size = size +
        const _i1.SequenceCodec<_i4.DisputeStatementSet>(
                _i4.DisputeStatementSet.codec)
            .sizeHint(obj.disputes);
    size = size + _i5.Header.codec.sizeHint(obj.parentHeader);
    return size;
  }
}
