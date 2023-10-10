// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/polkadot_primitives/v4/validator_app/public.dart' as _i4;
import '../types/polkadot_primitives/v4/validator_index.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _currentSessionIndex =
      const _i1.StorageValue<int>(
    prefix: 'ParasShared',
    storage: 'CurrentSessionIndex',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i3.ValidatorIndex>> _activeValidatorIndices =
      const _i1.StorageValue<List<_i3.ValidatorIndex>>(
    prefix: 'ParasShared',
    storage: 'ActiveValidatorIndices',
    valueCodec:
        _i2.SequenceCodec<_i3.ValidatorIndex>(_i3.ValidatorIndexCodec()),
  );

  final _i1.StorageValue<List<_i4.Public>> _activeValidatorKeys =
      const _i1.StorageValue<List<_i4.Public>>(
    prefix: 'ParasShared',
    storage: 'ActiveValidatorKeys',
    valueCodec: _i2.SequenceCodec<_i4.Public>(_i4.PublicCodec()),
  );

  /// The current session index.
  _i5.Future<int> currentSessionIndex({_i1.BlockHash? at}) async {
    final hashedKey = _currentSessionIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentSessionIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// All the validators actively participating in parachain consensus.
  /// Indices are into the broader validator set.
  _i5.Future<List<_i3.ValidatorIndex>> activeValidatorIndices(
      {_i1.BlockHash? at}) async {
    final hashedKey = _activeValidatorIndices.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _activeValidatorIndices.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The parachain attestation keys of the validators actively participating in parachain consensus.
  /// This should be the same length as `ActiveValidatorIndices`.
  _i5.Future<List<_i4.Public>> activeValidatorKeys({_i1.BlockHash? at}) async {
    final hashedKey = _activeValidatorKeys.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _activeValidatorKeys.decodeValue(bytes);
    }
    return []; /* Default */
  }
}
