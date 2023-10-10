// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/pallet_babe/pallet/call.dart' as _i12;
import '../types/polkadot_runtime/runtime_call.dart' as _i11;
import '../types/sp_consensus_babe/app/public.dart' as _i4;
import '../types/sp_consensus_babe/babe_epoch_configuration.dart' as _i9;
import '../types/sp_consensus_babe/digests/next_config_descriptor.dart' as _i6;
import '../types/sp_consensus_babe/digests/pre_digest.dart' as _i7;
import '../types/sp_consensus_slots/slot.dart' as _i5;
import '../types/tuples.dart' as _i3;
import '../types/tuples_1.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<BigInt> _epochIndex = const _i1.StorageValue<BigInt>(
    prefix: 'Babe',
    storage: 'EpochIndex',
    valueCodec: _i2.U64Codec.codec,
  );

  final _i1.StorageValue<List<_i3.Tuple2<_i4.Public, BigInt>>> _authorities =
      const _i1.StorageValue<List<_i3.Tuple2<_i4.Public, BigInt>>>(
    prefix: 'Babe',
    storage: 'Authorities',
    valueCodec: _i2.SequenceCodec<_i3.Tuple2<_i4.Public, BigInt>>(
        _i3.Tuple2Codec<_i4.Public, BigInt>(
      _i4.PublicCodec(),
      _i2.U64Codec.codec,
    )),
  );

  final _i1.StorageValue<_i5.Slot> _genesisSlot =
      const _i1.StorageValue<_i5.Slot>(
    prefix: 'Babe',
    storage: 'GenesisSlot',
    valueCodec: _i5.SlotCodec(),
  );

  final _i1.StorageValue<_i5.Slot> _currentSlot =
      const _i1.StorageValue<_i5.Slot>(
    prefix: 'Babe',
    storage: 'CurrentSlot',
    valueCodec: _i5.SlotCodec(),
  );

  final _i1.StorageValue<List<int>> _randomness =
      const _i1.StorageValue<List<int>>(
    prefix: 'Babe',
    storage: 'Randomness',
    valueCodec: _i2.U8ArrayCodec(32),
  );

  final _i1.StorageValue<_i6.NextConfigDescriptor> _pendingEpochConfigChange =
      const _i1.StorageValue<_i6.NextConfigDescriptor>(
    prefix: 'Babe',
    storage: 'PendingEpochConfigChange',
    valueCodec: _i6.NextConfigDescriptor.codec,
  );

  final _i1.StorageValue<List<int>> _nextRandomness =
      const _i1.StorageValue<List<int>>(
    prefix: 'Babe',
    storage: 'NextRandomness',
    valueCodec: _i2.U8ArrayCodec(32),
  );

  final _i1.StorageValue<List<_i3.Tuple2<_i4.Public, BigInt>>>
      _nextAuthorities =
      const _i1.StorageValue<List<_i3.Tuple2<_i4.Public, BigInt>>>(
    prefix: 'Babe',
    storage: 'NextAuthorities',
    valueCodec: _i2.SequenceCodec<_i3.Tuple2<_i4.Public, BigInt>>(
        _i3.Tuple2Codec<_i4.Public, BigInt>(
      _i4.PublicCodec(),
      _i2.U64Codec.codec,
    )),
  );

  final _i1.StorageValue<int> _segmentIndex = const _i1.StorageValue<int>(
    prefix: 'Babe',
    storage: 'SegmentIndex',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, List<List<int>>> _underConstruction =
      const _i1.StorageMap<int, List<List<int>>>(
    prefix: 'Babe',
    storage: 'UnderConstruction',
    valueCodec: _i2.SequenceCodec<List<int>>(_i2.U8ArrayCodec(32)),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<_i7.PreDigest?> _initialized =
      const _i1.StorageValue<_i7.PreDigest?>(
    prefix: 'Babe',
    storage: 'Initialized',
    valueCodec: _i2.OptionCodec<_i7.PreDigest>(_i7.PreDigest.codec),
  );

  final _i1.StorageValue<List<int>?> _authorVrfRandomness =
      const _i1.StorageValue<List<int>?>(
    prefix: 'Babe',
    storage: 'AuthorVrfRandomness',
    valueCodec: _i2.OptionCodec<List<int>>(_i2.U8ArrayCodec(32)),
  );

  final _i1.StorageValue<_i8.Tuple2<int, int>> _epochStart =
      const _i1.StorageValue<_i8.Tuple2<int, int>>(
    prefix: 'Babe',
    storage: 'EpochStart',
    valueCodec: _i8.Tuple2Codec<int, int>(
      _i2.U32Codec.codec,
      _i2.U32Codec.codec,
    ),
  );

  final _i1.StorageValue<int> _lateness = const _i1.StorageValue<int>(
    prefix: 'Babe',
    storage: 'Lateness',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i9.BabeEpochConfiguration> _epochConfig =
      const _i1.StorageValue<_i9.BabeEpochConfiguration>(
    prefix: 'Babe',
    storage: 'EpochConfig',
    valueCodec: _i9.BabeEpochConfiguration.codec,
  );

  final _i1.StorageValue<_i9.BabeEpochConfiguration> _nextEpochConfig =
      const _i1.StorageValue<_i9.BabeEpochConfiguration>(
    prefix: 'Babe',
    storage: 'NextEpochConfig',
    valueCodec: _i9.BabeEpochConfiguration.codec,
  );

  final _i1.StorageValue<List<_i3.Tuple2<BigInt, int>>> _skippedEpochs =
      const _i1.StorageValue<List<_i3.Tuple2<BigInt, int>>>(
    prefix: 'Babe',
    storage: 'SkippedEpochs',
    valueCodec:
        _i2.SequenceCodec<_i3.Tuple2<BigInt, int>>(_i3.Tuple2Codec<BigInt, int>(
      _i2.U64Codec.codec,
      _i2.U32Codec.codec,
    )),
  );

  /// Current epoch index.
  _i10.Future<BigInt> epochIndex({_i1.BlockHash? at}) async {
    final hashedKey = _epochIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _epochIndex.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Current epoch authorities.
  _i10.Future<List<_i3.Tuple2<_i4.Public, BigInt>>> authorities(
      {_i1.BlockHash? at}) async {
    final hashedKey = _authorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _authorities.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The slot at which the first epoch actually started. This is 0
  /// until the first block of the chain.
  _i10.Future<_i5.Slot> genesisSlot({_i1.BlockHash? at}) async {
    final hashedKey = _genesisSlot.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _genesisSlot.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Current slot number.
  _i10.Future<_i5.Slot> currentSlot({_i1.BlockHash? at}) async {
    final hashedKey = _currentSlot.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentSlot.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The epoch randomness for the *current* epoch.
  ///
  /// # Security
  ///
  /// This MUST NOT be used for gambling, as it can be influenced by a
  /// malicious validator in the short term. It MAY be used in many
  /// cryptographic protocols, however, so long as one remembers that this
  /// (like everything else on-chain) it is public. For example, it can be
  /// used where a number is needed that cannot have been chosen by an
  /// adversary, for purposes such as public-coin zero-knowledge proofs.
  _i10.Future<List<int>> randomness({_i1.BlockHash? at}) async {
    final hashedKey = _randomness.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _randomness.decodeValue(bytes);
    }
    return List<int>.filled(
      32,
      0,
      growable: false,
    ); /* Default */
  }

  /// Pending epoch configuration change that will be applied when the next epoch is enacted.
  _i10.Future<_i6.NextConfigDescriptor?> pendingEpochConfigChange(
      {_i1.BlockHash? at}) async {
    final hashedKey = _pendingEpochConfigChange.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingEpochConfigChange.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Next epoch randomness.
  _i10.Future<List<int>> nextRandomness({_i1.BlockHash? at}) async {
    final hashedKey = _nextRandomness.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextRandomness.decodeValue(bytes);
    }
    return List<int>.filled(
      32,
      0,
      growable: false,
    ); /* Default */
  }

  /// Next epoch authorities.
  _i10.Future<List<_i3.Tuple2<_i4.Public, BigInt>>> nextAuthorities(
      {_i1.BlockHash? at}) async {
    final hashedKey = _nextAuthorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextAuthorities.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Randomness under construction.
  ///
  /// We make a trade-off between storage accesses and list length.
  /// We store the under-construction randomness in segments of up to
  /// `UNDER_CONSTRUCTION_SEGMENT_LENGTH`.
  ///
  /// Once a segment reaches this length, we begin the next one.
  /// We reset all segments and return to `0` at the beginning of every
  /// epoch.
  _i10.Future<int> segmentIndex({_i1.BlockHash? at}) async {
    final hashedKey = _segmentIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _segmentIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// TWOX-NOTE: `SegmentIndex` is an increasing integer, so this is okay.
  _i10.Future<List<List<int>>> underConstruction(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _underConstruction.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _underConstruction.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Temporary value (cleared at block finalization) which is `Some`
  /// if per-block initialization has already been called for current block.
  _i10.Future<_i7.PreDigest?> initialized({_i1.BlockHash? at}) async {
    final hashedKey = _initialized.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _initialized.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// This field should always be populated during block processing unless
  /// secondary plain slots are enabled (which don't contain a VRF output).
  ///
  /// It is set in `on_finalize`, before it will contain the value from the last block.
  _i10.Future<List<int>?> authorVrfRandomness({_i1.BlockHash? at}) async {
    final hashedKey = _authorVrfRandomness.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _authorVrfRandomness.decodeValue(bytes);
    }
    return null; /* Default */
  }

  /// The block numbers when the last and current epoch have started, respectively `N-1` and
  /// `N`.
  /// NOTE: We track this is in order to annotate the block number when a given pool of
  /// entropy was fixed (i.e. it was known to chain observers). Since epochs are defined in
  /// slots, which may be skipped, the block numbers may not line up with the slot numbers.
  _i10.Future<_i8.Tuple2<int, int>> epochStart({_i1.BlockHash? at}) async {
    final hashedKey = _epochStart.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _epochStart.decodeValue(bytes);
    }
    return _i8.Tuple2<int, int>(
      0,
      0,
    ); /* Default */
  }

  /// How late the current block is compared to its parent.
  ///
  /// This entry is populated as part of block execution and is cleaned up
  /// on block finalization. Querying this storage entry outside of block
  /// execution context should always yield zero.
  _i10.Future<int> lateness({_i1.BlockHash? at}) async {
    final hashedKey = _lateness.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lateness.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The configuration for the current epoch. Should never be `None` as it is initialized in
  /// genesis.
  _i10.Future<_i9.BabeEpochConfiguration?> epochConfig(
      {_i1.BlockHash? at}) async {
    final hashedKey = _epochConfig.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _epochConfig.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The configuration for the next epoch, `None` if the config will not change
  /// (you can fallback to `EpochConfig` instead in that case).
  _i10.Future<_i9.BabeEpochConfiguration?> nextEpochConfig(
      {_i1.BlockHash? at}) async {
    final hashedKey = _nextEpochConfig.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextEpochConfig.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// A list of the last 100 skipped epochs and the corresponding session index
  /// when the epoch was skipped.
  ///
  /// This is only used for validating equivocation proofs. An equivocation proof
  /// must contains a key-ownership proof for a given session, therefore we need a
  /// way to tie together sessions and epoch indices, i.e. we need to validate that
  /// a validator was the owner of a given key on a given session, and what the
  /// active epoch index was during that session.
  _i10.Future<List<_i3.Tuple2<BigInt, int>>> skippedEpochs(
      {_i1.BlockHash? at}) async {
    final hashedKey = _skippedEpochs.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _skippedEpochs.decodeValue(bytes);
    }
    return []; /* Default */
  }
}

class Txs {
  const Txs();

  /// Report authority equivocation/misbehavior. This method will verify
  /// the equivocation proof and validate the given key ownership proof
  /// against the extracted offender. If both are valid, the offence will
  /// be reported.
  _i11.RuntimeCall reportEquivocation({
    required equivocationProof,
    required keyOwnerProof,
  }) {
    final _call = _i12.Call.values.reportEquivocation(
      equivocationProof: equivocationProof,
      keyOwnerProof: keyOwnerProof,
    );
    return _i11.RuntimeCall.values.babe(_call);
  }

  /// Report authority equivocation/misbehavior. This method will verify
  /// the equivocation proof and validate the given key ownership proof
  /// against the extracted offender. If both are valid, the offence will
  /// be reported.
  /// This extrinsic must be called unsigned and it is expected that only
  /// block authors will call it (validated in `ValidateUnsigned`), as such
  /// if the block author is defined it will be defined as the equivocation
  /// reporter.
  _i11.RuntimeCall reportEquivocationUnsigned({
    required equivocationProof,
    required keyOwnerProof,
  }) {
    final _call = _i12.Call.values.reportEquivocationUnsigned(
      equivocationProof: equivocationProof,
      keyOwnerProof: keyOwnerProof,
    );
    return _i11.RuntimeCall.values.babe(_call);
  }

  /// Plan an epoch config change. The epoch config change is recorded and will be enacted on
  /// the next call to `enact_epoch_change`. The config will be activated one epoch after.
  /// Multiple calls to this method will replace any existing planned config change that had
  /// not been enacted yet.
  _i11.RuntimeCall planConfigChange({required config}) {
    final _call = _i12.Call.values.planConfigChange(config: config);
    return _i11.RuntimeCall.values.babe(_call);
  }
}

class Constants {
  Constants();

  /// The amount of time, in slots, that each epoch should last.
  /// NOTE: Currently it is not possible to change the epoch duration after
  /// the chain has started. Attempting to do so will brick block production.
  final BigInt epochDuration = BigInt.from(2400);

  /// The expected average block time at which BABE should be creating
  /// blocks. Since BABE is probabilistic it is not trivial to figure out
  /// what the expected average block time should be based on the slot
  /// duration and the security parameter `c` (where `1 - c` represents
  /// the probability of a slot being empty).
  final BigInt expectedBlockTime = BigInt.from(6000);

  /// Max number of authorities allowed
  final int maxAuthorities = 100000;
}
