// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i14;
import 'dart:typed_data' as _i15;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/polkadot_parachain_primitives/primitives/head_data.dart'
    as _i7;
import '../types/polkadot_parachain_primitives/primitives/id.dart' as _i5;
import '../types/polkadot_parachain_primitives/primitives/validation_code.dart'
    as _i13;
import '../types/polkadot_parachain_primitives/primitives/validation_code_hash.dart'
    as _i2;
import '../types/polkadot_primitives/v7/pvf_check_statement.dart' as _i18;
import '../types/polkadot_primitives/v7/upgrade_go_ahead.dart' as _i10;
import '../types/polkadot_primitives/v7/upgrade_restriction.dart' as _i11;
import '../types/polkadot_primitives/v7/validator_app/signature.dart' as _i19;
import '../types/polkadot_runtime/runtime_call.dart' as _i16;
import '../types/polkadot_runtime_parachains/paras/pallet/call.dart' as _i17;
import '../types/polkadot_runtime_parachains/paras/para_genesis_args.dart'
    as _i12;
import '../types/polkadot_runtime_parachains/paras/para_lifecycle.dart' as _i6;
import '../types/polkadot_runtime_parachains/paras/para_past_code_meta.dart'
    as _i9;
import '../types/polkadot_runtime_parachains/paras/pvf_check_active_vote_state.dart'
    as _i3;
import '../types/tuples.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.ValidationCodeHash, _i3.PvfCheckActiveVoteState>
      _pvfActiveVoteMap =
      const _i1.StorageMap<_i2.ValidationCodeHash, _i3.PvfCheckActiveVoteState>(
    prefix: 'Paras',
    storage: 'PvfActiveVoteMap',
    valueCodec: _i3.PvfCheckActiveVoteState.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.ValidationCodeHashCodec()),
  );

  final _i1.StorageValue<List<_i2.ValidationCodeHash>> _pvfActiveVoteList =
      const _i1.StorageValue<List<_i2.ValidationCodeHash>>(
    prefix: 'Paras',
    storage: 'PvfActiveVoteList',
    valueCodec: _i4.SequenceCodec<_i2.ValidationCodeHash>(
        _i2.ValidationCodeHashCodec()),
  );

  final _i1.StorageValue<List<_i5.Id>> _parachains =
      const _i1.StorageValue<List<_i5.Id>>(
    prefix: 'Paras',
    storage: 'Parachains',
    valueCodec: _i4.SequenceCodec<_i5.Id>(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i5.Id, _i6.ParaLifecycle> _paraLifecycles =
      const _i1.StorageMap<_i5.Id, _i6.ParaLifecycle>(
    prefix: 'Paras',
    storage: 'ParaLifecycles',
    valueCodec: _i6.ParaLifecycle.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i5.Id, _i7.HeadData> _heads =
      const _i1.StorageMap<_i5.Id, _i7.HeadData>(
    prefix: 'Paras',
    storage: 'Heads',
    valueCodec: _i7.HeadDataCodec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i5.Id, int> _mostRecentContext =
      const _i1.StorageMap<_i5.Id, int>(
    prefix: 'Paras',
    storage: 'MostRecentContext',
    valueCodec: _i4.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i5.Id, _i2.ValidationCodeHash> _currentCodeHash =
      const _i1.StorageMap<_i5.Id, _i2.ValidationCodeHash>(
    prefix: 'Paras',
    storage: 'CurrentCodeHash',
    valueCodec: _i2.ValidationCodeHashCodec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i8.Tuple2<_i5.Id, int>, _i2.ValidationCodeHash>
      _pastCodeHash =
      const _i1.StorageMap<_i8.Tuple2<_i5.Id, int>, _i2.ValidationCodeHash>(
    prefix: 'Paras',
    storage: 'PastCodeHash',
    valueCodec: _i2.ValidationCodeHashCodec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i8.Tuple2Codec<_i5.Id, int>(
      _i5.IdCodec(),
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<_i5.Id, _i9.ParaPastCodeMeta> _pastCodeMeta =
      const _i1.StorageMap<_i5.Id, _i9.ParaPastCodeMeta>(
    prefix: 'Paras',
    storage: 'PastCodeMeta',
    valueCodec: _i9.ParaPastCodeMeta.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageValue<List<_i8.Tuple2<_i5.Id, int>>> _pastCodePruning =
      const _i1.StorageValue<List<_i8.Tuple2<_i5.Id, int>>>(
    prefix: 'Paras',
    storage: 'PastCodePruning',
    valueCodec:
        _i4.SequenceCodec<_i8.Tuple2<_i5.Id, int>>(_i8.Tuple2Codec<_i5.Id, int>(
      _i5.IdCodec(),
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<_i5.Id, int> _futureCodeUpgrades =
      const _i1.StorageMap<_i5.Id, int>(
    prefix: 'Paras',
    storage: 'FutureCodeUpgrades',
    valueCodec: _i4.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageValue<List<_i8.Tuple2<_i5.Id, int>>> _futureCodeUpgradesAt =
      const _i1.StorageValue<List<_i8.Tuple2<_i5.Id, int>>>(
    prefix: 'Paras',
    storage: 'FutureCodeUpgradesAt',
    valueCodec:
        _i4.SequenceCodec<_i8.Tuple2<_i5.Id, int>>(_i8.Tuple2Codec<_i5.Id, int>(
      _i5.IdCodec(),
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<_i5.Id, _i2.ValidationCodeHash> _futureCodeHash =
      const _i1.StorageMap<_i5.Id, _i2.ValidationCodeHash>(
    prefix: 'Paras',
    storage: 'FutureCodeHash',
    valueCodec: _i2.ValidationCodeHashCodec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i5.Id, _i10.UpgradeGoAhead> _upgradeGoAheadSignal =
      const _i1.StorageMap<_i5.Id, _i10.UpgradeGoAhead>(
    prefix: 'Paras',
    storage: 'UpgradeGoAheadSignal',
    valueCodec: _i10.UpgradeGoAhead.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i5.Id, _i11.UpgradeRestriction>
      _upgradeRestrictionSignal =
      const _i1.StorageMap<_i5.Id, _i11.UpgradeRestriction>(
    prefix: 'Paras',
    storage: 'UpgradeRestrictionSignal',
    valueCodec: _i11.UpgradeRestriction.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageValue<List<_i8.Tuple2<_i5.Id, int>>> _upgradeCooldowns =
      const _i1.StorageValue<List<_i8.Tuple2<_i5.Id, int>>>(
    prefix: 'Paras',
    storage: 'UpgradeCooldowns',
    valueCodec:
        _i4.SequenceCodec<_i8.Tuple2<_i5.Id, int>>(_i8.Tuple2Codec<_i5.Id, int>(
      _i5.IdCodec(),
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageValue<List<_i8.Tuple2<_i5.Id, int>>> _upcomingUpgrades =
      const _i1.StorageValue<List<_i8.Tuple2<_i5.Id, int>>>(
    prefix: 'Paras',
    storage: 'UpcomingUpgrades',
    valueCodec:
        _i4.SequenceCodec<_i8.Tuple2<_i5.Id, int>>(_i8.Tuple2Codec<_i5.Id, int>(
      _i5.IdCodec(),
      _i4.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<int, List<_i5.Id>> _actionsQueue =
      const _i1.StorageMap<int, List<_i5.Id>>(
    prefix: 'Paras',
    storage: 'ActionsQueue',
    valueCodec: _i4.SequenceCodec<_i5.Id>(_i5.IdCodec()),
    hasher: _i1.StorageHasher.twoxx64Concat(_i4.U32Codec.codec),
  );

  final _i1.StorageMap<_i5.Id, _i12.ParaGenesisArgs> _upcomingParasGenesis =
      const _i1.StorageMap<_i5.Id, _i12.ParaGenesisArgs>(
    prefix: 'Paras',
    storage: 'UpcomingParasGenesis',
    valueCodec: _i12.ParaGenesisArgs.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.IdCodec()),
  );

  final _i1.StorageMap<_i2.ValidationCodeHash, int> _codeByHashRefs =
      const _i1.StorageMap<_i2.ValidationCodeHash, int>(
    prefix: 'Paras',
    storage: 'CodeByHashRefs',
    valueCodec: _i4.U32Codec.codec,
    hasher: _i1.StorageHasher.identity(_i2.ValidationCodeHashCodec()),
  );

  final _i1.StorageMap<_i2.ValidationCodeHash, _i13.ValidationCode>
      _codeByHash =
      const _i1.StorageMap<_i2.ValidationCodeHash, _i13.ValidationCode>(
    prefix: 'Paras',
    storage: 'CodeByHash',
    valueCodec: _i13.ValidationCodeCodec(),
    hasher: _i1.StorageHasher.identity(_i2.ValidationCodeHashCodec()),
  );

  /// All currently active PVF pre-checking votes.
  ///
  /// Invariant:
  /// - There are no PVF pre-checking votes that exists in list but not in the set and vice versa.
  _i14.Future<_i3.PvfCheckActiveVoteState?> pvfActiveVoteMap(
    _i2.ValidationCodeHash key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pvfActiveVoteMap.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pvfActiveVoteMap.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The list of all currently active PVF votes. Auxiliary to `PvfActiveVoteMap`.
  _i14.Future<List<_i2.ValidationCodeHash>> pvfActiveVoteList(
      {_i1.BlockHash? at}) async {
    final hashedKey = _pvfActiveVoteList.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pvfActiveVoteList.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// All lease holding parachains. Ordered ascending by `ParaId`. On demand parachains are not
  /// included.
  ///
  /// Consider using the [`ParachainsCache`] type of modifying.
  _i14.Future<List<_i5.Id>> parachains({_i1.BlockHash? at}) async {
    final hashedKey = _parachains.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _parachains.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The current lifecycle of a all known Para IDs.
  _i14.Future<_i6.ParaLifecycle?> paraLifecycles(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _paraLifecycles.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _paraLifecycles.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The head-data of every registered para.
  _i14.Future<_i7.HeadData?> heads(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _heads.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _heads.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The context (relay-chain block number) of the most recent parachain head.
  _i14.Future<int?> mostRecentContext(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _mostRecentContext.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _mostRecentContext.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The validation code hash of every live para.
  ///
  /// Corresponding code can be retrieved with [`CodeByHash`].
  _i14.Future<_i2.ValidationCodeHash?> currentCodeHash(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _currentCodeHash.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentCodeHash.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Actual past code hash, indicated by the para id as well as the block number at which it
  /// became outdated.
  ///
  /// Corresponding code can be retrieved with [`CodeByHash`].
  _i14.Future<_i2.ValidationCodeHash?> pastCodeHash(
    _i8.Tuple2<_i5.Id, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pastCodeHash.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pastCodeHash.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Past code of parachains. The parachains themselves may not be registered anymore,
  /// but we also keep their code on-chain for the same amount of time as outdated code
  /// to keep it available for approval checkers.
  _i14.Future<_i9.ParaPastCodeMeta> pastCodeMeta(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pastCodeMeta.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pastCodeMeta.decodeValue(bytes);
    }
    return _i9.ParaPastCodeMeta(
      upgradeTimes: [],
      lastPruned: null,
    ); /* Default */
  }

  /// Which paras have past code that needs pruning and the relay-chain block at which the code
  /// was replaced. Note that this is the actual height of the included block, not the expected
  /// height at which the code upgrade would be applied, although they may be equal.
  /// This is to ensure the entire acceptance period is covered, not an offset acceptance period
  /// starting from the time at which the parachain perceives a code upgrade as having occurred.
  /// Multiple entries for a single para are permitted. Ordered ascending by block number.
  _i14.Future<List<_i8.Tuple2<_i5.Id, int>>> pastCodePruning(
      {_i1.BlockHash? at}) async {
    final hashedKey = _pastCodePruning.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pastCodePruning.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The block number at which the planned code change is expected for a parachain.
  ///
  /// The change will be applied after the first parablock for this ID included which executes
  /// in the context of a relay chain block with a number >= `expected_at`.
  _i14.Future<int?> futureCodeUpgrades(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _futureCodeUpgrades.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _futureCodeUpgrades.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The list of upcoming future code upgrades.
  ///
  /// Each item is a pair of the parachain and the expected block at which the upgrade should be
  /// applied. The upgrade will be applied at the given relay chain block. In contrast to
  /// [`FutureCodeUpgrades`] this code upgrade will be applied regardless the parachain making any
  /// progress or not.
  ///
  /// Ordered ascending by block number.
  _i14.Future<List<_i8.Tuple2<_i5.Id, int>>> futureCodeUpgradesAt(
      {_i1.BlockHash? at}) async {
    final hashedKey = _futureCodeUpgradesAt.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _futureCodeUpgradesAt.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The actual future code hash of a para.
  ///
  /// Corresponding code can be retrieved with [`CodeByHash`].
  _i14.Future<_i2.ValidationCodeHash?> futureCodeHash(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _futureCodeHash.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _futureCodeHash.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// This is used by the relay-chain to communicate to a parachain a go-ahead with in the upgrade
  /// procedure.
  ///
  /// This value is absent when there are no upgrades scheduled or during the time the relay chain
  /// performs the checks. It is set at the first relay-chain block when the corresponding
  /// parachain can switch its upgrade function. As soon as the parachain's block is included, the
  /// value gets reset to `None`.
  ///
  /// NOTE that this field is used by parachains via merkle storage proofs, therefore changing
  /// the format will require migration of parachains.
  _i14.Future<_i10.UpgradeGoAhead?> upgradeGoAheadSignal(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _upgradeGoAheadSignal.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _upgradeGoAheadSignal.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// This is used by the relay-chain to communicate that there are restrictions for performing
  /// an upgrade for this parachain.
  ///
  /// This may be a because the parachain waits for the upgrade cooldown to expire. Another
  /// potential use case is when we want to perform some maintenance (such as storage migration)
  /// we could restrict upgrades to make the process simpler.
  ///
  /// NOTE that this field is used by parachains via merkle storage proofs, therefore changing
  /// the format will require migration of parachains.
  _i14.Future<_i11.UpgradeRestriction?> upgradeRestrictionSignal(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _upgradeRestrictionSignal.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _upgradeRestrictionSignal.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The list of parachains that are awaiting for their upgrade restriction to cooldown.
  ///
  /// Ordered ascending by block number.
  _i14.Future<List<_i8.Tuple2<_i5.Id, int>>> upgradeCooldowns(
      {_i1.BlockHash? at}) async {
    final hashedKey = _upgradeCooldowns.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _upgradeCooldowns.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The list of upcoming code upgrades.
  ///
  /// Each item is a pair of which para performs a code upgrade and at which relay-chain block it
  /// is expected at.
  ///
  /// Ordered ascending by block number.
  _i14.Future<List<_i8.Tuple2<_i5.Id, int>>> upcomingUpgrades(
      {_i1.BlockHash? at}) async {
    final hashedKey = _upcomingUpgrades.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _upcomingUpgrades.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The actions to perform during the start of a specific session index.
  _i14.Future<List<_i5.Id>> actionsQueue(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _actionsQueue.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _actionsQueue.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Upcoming paras instantiation arguments.
  ///
  /// NOTE that after PVF pre-checking is enabled the para genesis arg will have it's code set
  /// to empty. Instead, the code will be saved into the storage right away via `CodeByHash`.
  _i14.Future<_i12.ParaGenesisArgs?> upcomingParasGenesis(
    _i5.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _upcomingParasGenesis.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _upcomingParasGenesis.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The number of reference on the validation code in [`CodeByHash`] storage.
  _i14.Future<int> codeByHashRefs(
    _i2.ValidationCodeHash key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _codeByHashRefs.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _codeByHashRefs.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Validation code stored by its hash.
  ///
  /// This storage is consistent with [`FutureCodeHash`], [`CurrentCodeHash`] and
  /// [`PastCodeHash`].
  _i14.Future<_i13.ValidationCode?> codeByHash(
    _i2.ValidationCodeHash key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _codeByHash.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _codeByHash.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `pvfActiveVoteMap`.
  _i15.Uint8List pvfActiveVoteMapKey(_i2.ValidationCodeHash key1) {
    final hashedKey = _pvfActiveVoteMap.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `pvfActiveVoteList`.
  _i15.Uint8List pvfActiveVoteListKey() {
    final hashedKey = _pvfActiveVoteList.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `parachains`.
  _i15.Uint8List parachainsKey() {
    final hashedKey = _parachains.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `paraLifecycles`.
  _i15.Uint8List paraLifecyclesKey(_i5.Id key1) {
    final hashedKey = _paraLifecycles.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `heads`.
  _i15.Uint8List headsKey(_i5.Id key1) {
    final hashedKey = _heads.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `mostRecentContext`.
  _i15.Uint8List mostRecentContextKey(_i5.Id key1) {
    final hashedKey = _mostRecentContext.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `currentCodeHash`.
  _i15.Uint8List currentCodeHashKey(_i5.Id key1) {
    final hashedKey = _currentCodeHash.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `pastCodeHash`.
  _i15.Uint8List pastCodeHashKey(_i8.Tuple2<_i5.Id, int> key1) {
    final hashedKey = _pastCodeHash.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `pastCodeMeta`.
  _i15.Uint8List pastCodeMetaKey(_i5.Id key1) {
    final hashedKey = _pastCodeMeta.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `pastCodePruning`.
  _i15.Uint8List pastCodePruningKey() {
    final hashedKey = _pastCodePruning.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `futureCodeUpgrades`.
  _i15.Uint8List futureCodeUpgradesKey(_i5.Id key1) {
    final hashedKey = _futureCodeUpgrades.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `futureCodeUpgradesAt`.
  _i15.Uint8List futureCodeUpgradesAtKey() {
    final hashedKey = _futureCodeUpgradesAt.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `futureCodeHash`.
  _i15.Uint8List futureCodeHashKey(_i5.Id key1) {
    final hashedKey = _futureCodeHash.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `upgradeGoAheadSignal`.
  _i15.Uint8List upgradeGoAheadSignalKey(_i5.Id key1) {
    final hashedKey = _upgradeGoAheadSignal.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `upgradeRestrictionSignal`.
  _i15.Uint8List upgradeRestrictionSignalKey(_i5.Id key1) {
    final hashedKey = _upgradeRestrictionSignal.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `upgradeCooldowns`.
  _i15.Uint8List upgradeCooldownsKey() {
    final hashedKey = _upgradeCooldowns.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `upcomingUpgrades`.
  _i15.Uint8List upcomingUpgradesKey() {
    final hashedKey = _upcomingUpgrades.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `actionsQueue`.
  _i15.Uint8List actionsQueueKey(int key1) {
    final hashedKey = _actionsQueue.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `upcomingParasGenesis`.
  _i15.Uint8List upcomingParasGenesisKey(_i5.Id key1) {
    final hashedKey = _upcomingParasGenesis.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `codeByHashRefs`.
  _i15.Uint8List codeByHashRefsKey(_i2.ValidationCodeHash key1) {
    final hashedKey = _codeByHashRefs.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `codeByHash`.
  _i15.Uint8List codeByHashKey(_i2.ValidationCodeHash key1) {
    final hashedKey = _codeByHash.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pvfActiveVoteMap`.
  _i15.Uint8List pvfActiveVoteMapMapPrefix() {
    final hashedKey = _pvfActiveVoteMap.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `paraLifecycles`.
  _i15.Uint8List paraLifecyclesMapPrefix() {
    final hashedKey = _paraLifecycles.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `heads`.
  _i15.Uint8List headsMapPrefix() {
    final hashedKey = _heads.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `mostRecentContext`.
  _i15.Uint8List mostRecentContextMapPrefix() {
    final hashedKey = _mostRecentContext.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `currentCodeHash`.
  _i15.Uint8List currentCodeHashMapPrefix() {
    final hashedKey = _currentCodeHash.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pastCodeHash`.
  _i15.Uint8List pastCodeHashMapPrefix() {
    final hashedKey = _pastCodeHash.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pastCodeMeta`.
  _i15.Uint8List pastCodeMetaMapPrefix() {
    final hashedKey = _pastCodeMeta.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `futureCodeUpgrades`.
  _i15.Uint8List futureCodeUpgradesMapPrefix() {
    final hashedKey = _futureCodeUpgrades.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `futureCodeHash`.
  _i15.Uint8List futureCodeHashMapPrefix() {
    final hashedKey = _futureCodeHash.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `upgradeGoAheadSignal`.
  _i15.Uint8List upgradeGoAheadSignalMapPrefix() {
    final hashedKey = _upgradeGoAheadSignal.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `upgradeRestrictionSignal`.
  _i15.Uint8List upgradeRestrictionSignalMapPrefix() {
    final hashedKey = _upgradeRestrictionSignal.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `actionsQueue`.
  _i15.Uint8List actionsQueueMapPrefix() {
    final hashedKey = _actionsQueue.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `upcomingParasGenesis`.
  _i15.Uint8List upcomingParasGenesisMapPrefix() {
    final hashedKey = _upcomingParasGenesis.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `codeByHashRefs`.
  _i15.Uint8List codeByHashRefsMapPrefix() {
    final hashedKey = _codeByHashRefs.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `codeByHash`.
  _i15.Uint8List codeByHashMapPrefix() {
    final hashedKey = _codeByHash.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Set the storage for the parachain validation code immediately.
  _i16.RuntimeCall forceSetCurrentCode({
    required _i5.Id para,
    required _i13.ValidationCode newCode,
  }) {
    final _call = _i17.Call.values.forceSetCurrentCode(
      para: para,
      newCode: newCode,
    );
    return _i16.RuntimeCall.values.paras(_call);
  }

  /// Set the storage for the current parachain head data immediately.
  _i16.RuntimeCall forceSetCurrentHead({
    required _i5.Id para,
    required _i7.HeadData newHead,
  }) {
    final _call = _i17.Call.values.forceSetCurrentHead(
      para: para,
      newHead: newHead,
    );
    return _i16.RuntimeCall.values.paras(_call);
  }

  /// Schedule an upgrade as if it was scheduled in the given relay parent block.
  _i16.RuntimeCall forceScheduleCodeUpgrade({
    required _i5.Id para,
    required _i13.ValidationCode newCode,
    required int relayParentNumber,
  }) {
    final _call = _i17.Call.values.forceScheduleCodeUpgrade(
      para: para,
      newCode: newCode,
      relayParentNumber: relayParentNumber,
    );
    return _i16.RuntimeCall.values.paras(_call);
  }

  /// Note a new block head for para within the context of the current block.
  _i16.RuntimeCall forceNoteNewHead({
    required _i5.Id para,
    required _i7.HeadData newHead,
  }) {
    final _call = _i17.Call.values.forceNoteNewHead(
      para: para,
      newHead: newHead,
    );
    return _i16.RuntimeCall.values.paras(_call);
  }

  /// Put a parachain directly into the next session's action queue.
  /// We can't queue it any sooner than this without going into the
  /// initializer...
  _i16.RuntimeCall forceQueueAction({required _i5.Id para}) {
    final _call = _i17.Call.values.forceQueueAction(para: para);
    return _i16.RuntimeCall.values.paras(_call);
  }

  /// Adds the validation code to the storage.
  ///
  /// The code will not be added if it is already present. Additionally, if PVF pre-checking
  /// is running for that code, it will be instantly accepted.
  ///
  /// Otherwise, the code will be added into the storage. Note that the code will be added
  /// into storage with reference count 0. This is to account the fact that there are no users
  /// for this code yet. The caller will have to make sure that this code eventually gets
  /// used by some parachain or removed from the storage to avoid storage leaks. For the
  /// latter prefer to use the `poke_unused_validation_code` dispatchable to raw storage
  /// manipulation.
  ///
  /// This function is mainly meant to be used for upgrading parachains that do not follow
  /// the go-ahead signal while the PVF pre-checking feature is enabled.
  _i16.RuntimeCall addTrustedValidationCode(
      {required _i13.ValidationCode validationCode}) {
    final _call = _i17.Call.values
        .addTrustedValidationCode(validationCode: validationCode);
    return _i16.RuntimeCall.values.paras(_call);
  }

  /// Remove the validation code from the storage iff the reference count is 0.
  ///
  /// This is better than removing the storage directly, because it will not remove the code
  /// that was suddenly got used by some parachain while this dispatchable was pending
  /// dispatching.
  _i16.RuntimeCall pokeUnusedValidationCode(
      {required _i2.ValidationCodeHash validationCodeHash}) {
    final _call = _i17.Call.values
        .pokeUnusedValidationCode(validationCodeHash: validationCodeHash);
    return _i16.RuntimeCall.values.paras(_call);
  }

  /// Includes a statement for a PVF pre-checking vote. Potentially, finalizes the vote and
  /// enacts the results if that was the last vote before achieving the supermajority.
  _i16.RuntimeCall includePvfCheckStatement({
    required _i18.PvfCheckStatement stmt,
    required _i19.Signature signature,
  }) {
    final _call = _i17.Call.values.includePvfCheckStatement(
      stmt: stmt,
      signature: signature,
    );
    return _i16.RuntimeCall.values.paras(_call);
  }

  /// Set the storage for the current parachain head data immediately.
  _i16.RuntimeCall forceSetMostRecentContext({
    required _i5.Id para,
    required int context,
  }) {
    final _call = _i17.Call.values.forceSetMostRecentContext(
      para: para,
      context: context,
    );
    return _i16.RuntimeCall.values.paras(_call);
  }
}

class Constants {
  Constants();

  final BigInt unsignedPriority = BigInt.parse(
    '18446744073709551615',
    radix: 10,
  );
}
