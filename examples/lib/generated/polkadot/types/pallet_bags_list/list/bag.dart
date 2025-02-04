// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class Bag {
  const Bag({
    this.head,
    this.tail,
  });

  factory Bag.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Option<T::AccountId>
  final _i2.AccountId32? head;

  /// Option<T::AccountId>
  final _i2.AccountId32? tail;

  static const $BagCodec codec = $BagCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<int>?> toJson() => {
        'head': head?.toList(),
        'tail': tail?.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Bag && other.head == head && other.tail == tail;

  @override
  int get hashCode => Object.hash(
        head,
        tail,
      );
}

class $BagCodec with _i1.Codec<Bag> {
  const $BagCodec();

  @override
  void encodeTo(
    Bag obj,
    _i1.Output output,
  ) {
    const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.head,
      output,
    );
    const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.tail,
      output,
    );
  }

  @override
  Bag decode(_i1.Input input) {
    return Bag(
      head: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
          .decode(input),
      tail: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
          .decode(input),
    );
  }

  @override
  int sizeHint(Bag obj) {
    int size = 0;
    size = size +
        const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.head);
    size = size +
        const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.tail);
    return size;
  }
}
