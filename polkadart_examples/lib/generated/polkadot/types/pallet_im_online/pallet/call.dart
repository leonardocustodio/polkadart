// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../heartbeat.dart' as _i3;
import '../sr25519/app_sr25519/signature.dart' as _i4;

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

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  Heartbeat heartbeat({
    required _i3.Heartbeat heartbeat,
    required _i4.Signature signature,
  }) {
    return Heartbeat(
      heartbeat: heartbeat,
      signature: signature,
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
        return Heartbeat._decode(input);
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
      case Heartbeat:
        (value as Heartbeat).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Heartbeat:
        return (value as Heartbeat)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// ## Complexity:
/// - `O(K + E)` where K is length of `Keys` (heartbeat.validators_len) and E is length of
///  `heartbeat.network_state.external_address`
///  - `O(K)`: decoding of length `K`
///  - `O(E)`: decoding/encoding of length `E`
class Heartbeat extends Call {
  const Heartbeat({
    required this.heartbeat,
    required this.signature,
  });

  factory Heartbeat._decode(_i1.Input input) {
    return Heartbeat(
      heartbeat: _i3.Heartbeat.codec.decode(input),
      signature: const _i1.U8ArrayCodec(64).decode(input),
    );
  }

  /// Heartbeat<T::BlockNumber>
  final _i3.Heartbeat heartbeat;

  /// <T::AuthorityId as RuntimeAppPublic>::Signature
  final _i4.Signature signature;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'heartbeat': {
          'heartbeat': heartbeat.toJson(),
          'signature': signature.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Heartbeat.codec.sizeHint(heartbeat);
    size = size + const _i4.SignatureCodec().sizeHint(signature);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Heartbeat.codec.encodeTo(
      heartbeat,
      output,
    );
    const _i1.U8ArrayCodec(64).encodeTo(
      signature,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Heartbeat &&
          other.heartbeat == heartbeat &&
          other.signature == signature;

  @override
  int get hashCode => Object.hash(
        heartbeat,
        signature,
      );
}
