// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../../primitive_types/h256.dart' as _i2;
import '../digest/digest.dart' as _i3;

class Header {
  const Header({
    required this.parentHash,
    required this.number,
    required this.stateRoot,
    required this.extrinsicsRoot,
    required this.digest,
  });

  factory Header.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Hash::Output
  final _i2.H256 parentHash;

  /// Number
  final BigInt number;

  /// Hash::Output
  final _i2.H256 stateRoot;

  /// Hash::Output
  final _i2.H256 extrinsicsRoot;

  /// Digest
  final _i3.Digest digest;

  static const $HeaderCodec codec = $HeaderCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'parentHash': parentHash.toList(),
        'number': number,
        'stateRoot': stateRoot.toList(),
        'extrinsicsRoot': extrinsicsRoot.toList(),
        'digest': digest.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Header &&
          _i5.listsEqual(
            other.parentHash,
            parentHash,
          ) &&
          other.number == number &&
          _i5.listsEqual(
            other.stateRoot,
            stateRoot,
          ) &&
          _i5.listsEqual(
            other.extrinsicsRoot,
            extrinsicsRoot,
          ) &&
          other.digest == digest;

  @override
  int get hashCode => Object.hash(
        parentHash,
        number,
        stateRoot,
        extrinsicsRoot,
        digest,
      );
}

class $HeaderCodec with _i1.Codec<Header> {
  const $HeaderCodec();

  @override
  void encodeTo(
    Header obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.parentHash,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.number,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.stateRoot,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.extrinsicsRoot,
      output,
    );
    _i3.Digest.codec.encodeTo(
      obj.digest,
      output,
    );
  }

  @override
  Header decode(_i1.Input input) {
    return Header(
      parentHash: const _i1.U8ArrayCodec(32).decode(input),
      number: _i1.CompactBigIntCodec.codec.decode(input),
      stateRoot: const _i1.U8ArrayCodec(32).decode(input),
      extrinsicsRoot: const _i1.U8ArrayCodec(32).decode(input),
      digest: _i3.Digest.codec.decode(input),
    );
  }

  @override
  int sizeHint(Header obj) {
    int size = 0;
    size = size + const _i2.H256Codec().sizeHint(obj.parentHash);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.number);
    size = size + const _i2.H256Codec().sizeHint(obj.stateRoot);
    size = size + const _i2.H256Codec().sizeHint(obj.extrinsicsRoot);
    size = size + _i3.Digest.codec.sizeHint(obj.digest);
    return size;
  }
}
