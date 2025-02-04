// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/polkadot_primitives/v7/inherent_data.dart' as _i7;
import '../types/polkadot_primitives/v7/scraped_on_chain_votes.dart' as _i3;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/polkadot_runtime_parachains/paras_inherent/pallet/call.dart'
    as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<dynamic> _included = const _i1.StorageValue<dynamic>(
    prefix: 'ParaInherent',
    storage: 'Included',
    valueCodec: _i2.NullCodec.codec,
  );

  final _i1.StorageValue<_i3.ScrapedOnChainVotes> _onChainVotes =
      const _i1.StorageValue<_i3.ScrapedOnChainVotes>(
    prefix: 'ParaInherent',
    storage: 'OnChainVotes',
    valueCodec: _i3.ScrapedOnChainVotes.codec,
  );

  /// Whether the paras inherent was included within this block.
  ///
  /// The `Option<()>` is effectively a `bool`, but it never hits storage in the `None` variant
  /// due to the guarantees of FRAME's storage APIs.
  ///
  /// If this is `None` at the end of the block, we panic and render the block invalid.
  _i4.Future<dynamic> included({_i1.BlockHash? at}) async {
    final hashedKey = _included.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _included.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Scraped on chain data for extracting resolved disputes as well as backing votes.
  _i4.Future<_i3.ScrapedOnChainVotes?> onChainVotes({_i1.BlockHash? at}) async {
    final hashedKey = _onChainVotes.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _onChainVotes.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `included`.
  _i5.Uint8List includedKey() {
    final hashedKey = _included.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `onChainVotes`.
  _i5.Uint8List onChainVotesKey() {
    final hashedKey = _onChainVotes.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Enter the paras inherent. This will process bitfields and backed candidates.
  _i6.RuntimeCall enter({required _i7.InherentData data}) {
    final _call = _i8.Call.values.enter(data: data);
    return _i6.RuntimeCall.values.paraInherent(_call);
  }
}
