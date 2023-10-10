// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// Contains one variant per dispatchable that can be called by an extrinsic.
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

  Map<String, Map<String, int>> toJson();
}

class $Call {
  const $Call();

  ForceApprove forceApprove({required int upTo}) {
    return ForceApprove(upTo: upTo);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ForceApprove._decode(input);
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
      case ForceApprove:
        (value as ForceApprove).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ForceApprove:
        return (value as ForceApprove)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Issue a signal to the consensus engine to forcibly act as though all parachain
/// blocks in all relay chain blocks up to and including the given number in the current
/// chain are valid and should be finalized.
class ForceApprove extends Call {
  const ForceApprove({required this.upTo});

  factory ForceApprove._decode(_i1.Input input) {
    return ForceApprove(upTo: _i1.U32Codec.codec.decode(input));
  }

  /// BlockNumber
  final int upTo;

  @override
  Map<String, Map<String, int>> toJson() => {
        'force_approve': {'upTo': upTo}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(upTo);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      upTo,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceApprove && other.upTo == upTo;

  @override
  int get hashCode => upTo.hashCode;
}
