// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/polkadot_runtime/runtime_call.dart' as _i5;
import '../types/polkadot_runtime_parachains/initializer/buffered_session_change.dart'
    as _i3;
import '../types/polkadot_runtime_parachains/initializer/pallet/call.dart'
    as _i6;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<dynamic> _hasInitialized =
      const _i1.StorageValue<dynamic>(
    prefix: 'Initializer',
    storage: 'HasInitialized',
    valueCodec: _i2.NullCodec.codec,
  );

  final _i1.StorageValue<List<_i3.BufferedSessionChange>>
      _bufferedSessionChanges =
      const _i1.StorageValue<List<_i3.BufferedSessionChange>>(
    prefix: 'Initializer',
    storage: 'BufferedSessionChanges',
    valueCodec: _i2.SequenceCodec<_i3.BufferedSessionChange>(
        _i3.BufferedSessionChange.codec),
  );

  /// Whether the parachains modules have been initialized within this block.
  ///
  /// Semantically a `bool`, but this guarantees it should never hit the trie,
  /// as this is cleared in `on_finalize` and Frame optimizes `None` values to be empty values.
  ///
  /// As a `bool`, `set(false)` and `remove()` both lead to the next `get()` being false, but one of
  /// them writes to the trie and one does not. This confusion makes `Option<()>` more suitable for
  /// the semantics of this variable.
  _i4.Future<dynamic> hasInitialized({_i1.BlockHash? at}) async {
    final hashedKey = _hasInitialized.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _hasInitialized.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Buffered session changes along with the block number at which they should be applied.
  ///
  /// Typically this will be empty or one element long. Apart from that this item never hits
  /// the storage.
  ///
  /// However this is a `Vec` regardless to handle various edge cases that may occur at runtime
  /// upgrade boundaries or if governance intervenes.
  _i4.Future<List<_i3.BufferedSessionChange>> bufferedSessionChanges(
      {_i1.BlockHash? at}) async {
    final hashedKey = _bufferedSessionChanges.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bufferedSessionChanges.decodeValue(bytes);
    }
    return []; /* Default */
  }
}

class Txs {
  const Txs();

  /// Issue a signal to the consensus engine to forcibly act as though all parachain
  /// blocks in all relay chain blocks up to and including the given number in the current
  /// chain are valid and should be finalized.
  _i5.RuntimeCall forceApprove({required upTo}) {
    final _call = _i6.Call.values.forceApprove(upTo: upTo);
    return _i5.RuntimeCall.values.initializer(_call);
  }
}
