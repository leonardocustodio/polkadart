// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../primitive_types/h256.dart' as _i3;

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

  Map<String, Map<String, List<int>>> toJson();
}

class $Call {
  const $Call();

  NotePreimage notePreimage({required List<int> bytes}) {
    return NotePreimage(bytes: bytes);
  }

  UnnotePreimage unnotePreimage({required _i3.H256 hash}) {
    return UnnotePreimage(hash: hash);
  }

  RequestPreimage requestPreimage({required _i3.H256 hash}) {
    return RequestPreimage(hash: hash);
  }

  UnrequestPreimage unrequestPreimage({required _i3.H256 hash}) {
    return UnrequestPreimage(hash: hash);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return NotePreimage._decode(input);
      case 1:
        return UnnotePreimage._decode(input);
      case 2:
        return RequestPreimage._decode(input);
      case 3:
        return UnrequestPreimage._decode(input);
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
      case NotePreimage:
        (value as NotePreimage).encodeTo(output);
        break;
      case UnnotePreimage:
        (value as UnnotePreimage).encodeTo(output);
        break;
      case RequestPreimage:
        (value as RequestPreimage).encodeTo(output);
        break;
      case UnrequestPreimage:
        (value as UnrequestPreimage).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case NotePreimage:
        return (value as NotePreimage)._sizeHint();
      case UnnotePreimage:
        return (value as UnnotePreimage)._sizeHint();
      case RequestPreimage:
        return (value as RequestPreimage)._sizeHint();
      case UnrequestPreimage:
        return (value as UnrequestPreimage)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Register a preimage on-chain.
///
/// If the preimage was previously requested, no fees or deposits are taken for providing
/// the preimage. Otherwise, a deposit is taken proportional to the size of the preimage.
class NotePreimage extends Call {
  const NotePreimage({required this.bytes});

  factory NotePreimage._decode(_i1.Input input) {
    return NotePreimage(bytes: _i1.U8SequenceCodec.codec.decode(input));
  }

  /// Vec<u8>
  final List<int> bytes;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'note_preimage': {'bytes': bytes}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(bytes);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      bytes,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NotePreimage &&
          _i4.listsEqual(
            other.bytes,
            bytes,
          );

  @override
  int get hashCode => bytes.hashCode;
}

/// Clear an unrequested preimage from the runtime storage.
///
/// If `len` is provided, then it will be a much cheaper operation.
///
/// - `hash`: The hash of the preimage to be removed from the store.
/// - `len`: The length of the preimage of `hash`.
class UnnotePreimage extends Call {
  const UnnotePreimage({required this.hash});

  factory UnnotePreimage._decode(_i1.Input input) {
    return UnnotePreimage(hash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'unnote_preimage': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnnotePreimage &&
          _i4.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => hash.hashCode;
}

/// Request a preimage be uploaded to the chain without paying any fees or deposits.
///
/// If the preimage requests has already been provided on-chain, we unreserve any deposit
/// a user may have paid, and take the control of the preimage out of their hands.
class RequestPreimage extends Call {
  const RequestPreimage({required this.hash});

  factory RequestPreimage._decode(_i1.Input input) {
    return RequestPreimage(hash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'request_preimage': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RequestPreimage &&
          _i4.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => hash.hashCode;
}

/// Clear a previously made request for a preimage.
///
/// NOTE: THIS MUST NOT BE CALLED ON `hash` MORE TIMES THAN `request_preimage`.
class UnrequestPreimage extends Call {
  const UnrequestPreimage({required this.hash});

  factory UnrequestPreimage._decode(_i1.Input input) {
    return UnrequestPreimage(hash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'unrequest_preimage': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnrequestPreimage &&
          _i4.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => hash.hashCode;
}
