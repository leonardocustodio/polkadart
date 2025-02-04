// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class Node {
  const Node({
    required this.id,
    this.prev,
    this.next,
    required this.bagUpper,
    required this.score,
  });

  factory Node.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// T::AccountId
  final _i2.AccountId32 id;

  /// Option<T::AccountId>
  final _i2.AccountId32? prev;

  /// Option<T::AccountId>
  final _i2.AccountId32? next;

  /// T::Score
  final BigInt bagUpper;

  /// T::Score
  final BigInt score;

  static const $NodeCodec codec = $NodeCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'id': id.toList(),
        'prev': prev?.toList(),
        'next': next?.toList(),
        'bagUpper': bagUpper,
        'score': score,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Node &&
          _i4.listsEqual(
            other.id,
            id,
          ) &&
          other.prev == prev &&
          other.next == next &&
          other.bagUpper == bagUpper &&
          other.score == score;

  @override
  int get hashCode => Object.hash(
        id,
        prev,
        next,
        bagUpper,
        score,
      );
}

class $NodeCodec with _i1.Codec<Node> {
  const $NodeCodec();

  @override
  void encodeTo(
    Node obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.id,
      output,
    );
    const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.prev,
      output,
    );
    const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.next,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.bagUpper,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.score,
      output,
    );
  }

  @override
  Node decode(_i1.Input input) {
    return Node(
      id: const _i1.U8ArrayCodec(32).decode(input),
      prev: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
          .decode(input),
      next: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
          .decode(input),
      bagUpper: _i1.U64Codec.codec.decode(input),
      score: _i1.U64Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Node obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.id);
    size = size +
        const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.prev);
    size = size +
        const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.next);
    size = size + _i1.U64Codec.codec.sizeHint(obj.bagUpper);
    size = size + _i1.U64Codec.codec.sizeHint(obj.score);
    return size;
  }
}
