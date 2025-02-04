// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class ParaInfo {
  const ParaInfo({
    required this.manager,
    required this.deposit,
    this.locked,
  });

  factory ParaInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Account
  final _i2.AccountId32 manager;

  /// Balance
  final BigInt deposit;

  /// Option<bool>
  final bool? locked;

  static const $ParaInfoCodec codec = $ParaInfoCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'manager': manager.toList(),
        'deposit': deposit,
        'locked': locked,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ParaInfo &&
          _i4.listsEqual(
            other.manager,
            manager,
          ) &&
          other.deposit == deposit &&
          other.locked == locked;

  @override
  int get hashCode => Object.hash(
        manager,
        deposit,
        locked,
      );
}

class $ParaInfoCodec with _i1.Codec<ParaInfo> {
  const $ParaInfoCodec();

  @override
  void encodeTo(
    ParaInfo obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.manager,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
    const _i1.OptionCodec<bool>(_i1.BoolCodec.codec).encodeTo(
      obj.locked,
      output,
    );
  }

  @override
  ParaInfo decode(_i1.Input input) {
    return ParaInfo(
      manager: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
      locked: const _i1.OptionCodec<bool>(_i1.BoolCodec.codec).decode(input),
    );
  }

  @override
  int sizeHint(ParaInfo obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.manager);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size +
        const _i1.OptionCodec<bool>(_i1.BoolCodec.codec).sizeHint(obj.locked);
    return size;
  }
}
