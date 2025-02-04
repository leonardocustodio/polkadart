// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../sp_core/crypto/account_id32.dart' as _i2;

class PoolRoles {
  const PoolRoles({
    required this.depositor,
    this.root,
    this.nominator,
    this.bouncer,
  });

  factory PoolRoles.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 depositor;

  /// Option<AccountId>
  final _i2.AccountId32? root;

  /// Option<AccountId>
  final _i2.AccountId32? nominator;

  /// Option<AccountId>
  final _i2.AccountId32? bouncer;

  static const $PoolRolesCodec codec = $PoolRolesCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<int>?> toJson() => {
        'depositor': depositor.toList(),
        'root': root?.toList(),
        'nominator': nominator?.toList(),
        'bouncer': bouncer?.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PoolRoles &&
          _i4.listsEqual(
            other.depositor,
            depositor,
          ) &&
          other.root == root &&
          other.nominator == nominator &&
          other.bouncer == bouncer;

  @override
  int get hashCode => Object.hash(
        depositor,
        root,
        nominator,
        bouncer,
      );
}

class $PoolRolesCodec with _i1.Codec<PoolRoles> {
  const $PoolRolesCodec();

  @override
  void encodeTo(
    PoolRoles obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.depositor,
      output,
    );
    const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.root,
      output,
    );
    const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.nominator,
      output,
    );
    const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.bouncer,
      output,
    );
  }

  @override
  PoolRoles decode(_i1.Input input) {
    return PoolRoles(
      depositor: const _i1.U8ArrayCodec(32).decode(input),
      root: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
          .decode(input),
      nominator: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
          .decode(input),
      bouncer: const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
          .decode(input),
    );
  }

  @override
  int sizeHint(PoolRoles obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.depositor);
    size = size +
        const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.root);
    size = size +
        const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.nominator);
    size = size +
        const _i1.OptionCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.bouncer);
    return size;
  }
}
