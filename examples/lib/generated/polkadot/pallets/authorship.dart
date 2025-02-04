// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:typed_data' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/sp_core/crypto/account_id32.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.AccountId32> _author =
      const _i1.StorageValue<_i2.AccountId32>(
    prefix: 'Authorship',
    storage: 'Author',
    valueCodec: _i2.AccountId32Codec(),
  );

  /// Author of current block.
  _i3.Future<_i2.AccountId32?> author({_i1.BlockHash? at}) async {
    final hashedKey = _author.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _author.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `author`.
  _i4.Uint8List authorKey() {
    final hashedKey = _author.hashedKey();
    return hashedKey;
  }
}
