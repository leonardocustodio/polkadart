// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i2;
import 'bit_flags.dart' as _i3;

class RegistrarInfo {
  const RegistrarInfo({
    required this.account,
    required this.fee,
    required this.fields,
  });

  factory RegistrarInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 account;

  /// Balance
  final BigInt fee;

  /// IdentityFields
  final _i3.BitFlags fields;

  static const $RegistrarInfoCodec codec = $RegistrarInfoCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'account': account.toList(),
        'fee': fee,
        'fields': fields,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RegistrarInfo &&
          _i5.listsEqual(
            other.account,
            account,
          ) &&
          other.fee == fee &&
          other.fields == fields;

  @override
  int get hashCode => Object.hash(
        account,
        fee,
        fields,
      );
}

class $RegistrarInfoCodec with _i1.Codec<RegistrarInfo> {
  const $RegistrarInfoCodec();

  @override
  void encodeTo(
    RegistrarInfo obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.account,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.fee,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.fields,
      output,
    );
  }

  @override
  RegistrarInfo decode(_i1.Input input) {
    return RegistrarInfo(
      account: const _i1.U8ArrayCodec(32).decode(input),
      fee: _i1.U128Codec.codec.decode(input),
      fields: _i1.U64Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(RegistrarInfo obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.account);
    size = size + _i1.U128Codec.codec.sizeHint(obj.fee);
    size = size + const _i3.BitFlagsCodec().sizeHint(obj.fields);
    return size;
  }
}
