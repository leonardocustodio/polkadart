// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../../polkadot_primitives/v7/slashing/dispute_proof.dart' as _i3;
import '../../../../sp_session/membership_proof.dart' as _i4;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, Map<String, dynamic>>> toJson();
}

class $Call {
  const $Call();

  ReportDisputeLostUnsigned reportDisputeLostUnsigned({
    required _i3.DisputeProof disputeProof,
    required _i4.MembershipProof keyOwnerProof,
  }) {
    return ReportDisputeLostUnsigned(
      disputeProof: disputeProof,
      keyOwnerProof: keyOwnerProof,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ReportDisputeLostUnsigned._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case ReportDisputeLostUnsigned:
        (value as ReportDisputeLostUnsigned).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ReportDisputeLostUnsigned:
        return (value as ReportDisputeLostUnsigned)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class ReportDisputeLostUnsigned extends Call {
  const ReportDisputeLostUnsigned({
    required this.disputeProof,
    required this.keyOwnerProof,
  });

  factory ReportDisputeLostUnsigned._decode(_i1.Input input) {
    return ReportDisputeLostUnsigned(
      disputeProof: _i3.DisputeProof.codec.decode(input),
      keyOwnerProof: _i4.MembershipProof.codec.decode(input),
    );
  }

  /// Box<DisputeProof>
  final _i3.DisputeProof disputeProof;

  /// T::KeyOwnerProof
  final _i4.MembershipProof keyOwnerProof;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'report_dispute_lost_unsigned': {
          'disputeProof': disputeProof.toJson(),
          'keyOwnerProof': keyOwnerProof.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.DisputeProof.codec.sizeHint(disputeProof);
    size = size + _i4.MembershipProof.codec.sizeHint(keyOwnerProof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.DisputeProof.codec.encodeTo(
      disputeProof,
      output,
    );
    _i4.MembershipProof.codec.encodeTo(
      keyOwnerProof,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReportDisputeLostUnsigned &&
          other.disputeProof == disputeProof &&
          other.keyOwnerProof == keyOwnerProof;

  @override
  int get hashCode => Object.hash(
        disputeProof,
        keyOwnerProof,
      );
}
