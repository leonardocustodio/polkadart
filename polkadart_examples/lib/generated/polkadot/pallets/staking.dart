// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i19;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/pallet_staking/active_era_info.dart' as _i9;
import '../types/pallet_staking/era_reward_points.dart' as _i11;
import '../types/pallet_staking/exposure.dart' as _i10;
import '../types/pallet_staking/forcing.dart' as _i12;
import '../types/pallet_staking/nominations.dart' as _i8;
import '../types/pallet_staking/pallet/pallet/call.dart' as _i21;
import '../types/pallet_staking/reward_destination.dart' as _i6;
import '../types/pallet_staking/slashing/slashing_spans.dart' as _i16;
import '../types/pallet_staking/slashing/span_record.dart' as _i17;
import '../types/pallet_staking/staking_ledger.dart' as _i5;
import '../types/pallet_staking/unapplied_slash.dart' as _i13;
import '../types/pallet_staking/validator_prefs.dart' as _i7;
import '../types/polkadot_runtime/runtime_call.dart' as _i20;
import '../types/sp_arithmetic/per_things/perbill.dart' as _i4;
import '../types/sp_arithmetic/per_things/percent.dart' as _i18;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/tuples.dart' as _i15;
import '../types/tuples_1.dart' as _i14;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _validatorCount = const _i1.StorageValue<int>(
    prefix: 'Staking',
    storage: 'ValidatorCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _minimumValidatorCount =
      const _i1.StorageValue<int>(
    prefix: 'Staking',
    storage: 'MinimumValidatorCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i3.AccountId32>> _invulnerables =
      const _i1.StorageValue<List<_i3.AccountId32>>(
    prefix: 'Staking',
    storage: 'Invulnerables',
    valueCodec: _i2.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i3.AccountId32, _i3.AccountId32> _bonded =
      const _i1.StorageMap<_i3.AccountId32, _i3.AccountId32>(
    prefix: 'Staking',
    storage: 'Bonded',
    valueCodec: _i3.AccountId32Codec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageValue<BigInt> _minNominatorBond =
      const _i1.StorageValue<BigInt>(
    prefix: 'Staking',
    storage: 'MinNominatorBond',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageValue<BigInt> _minValidatorBond =
      const _i1.StorageValue<BigInt>(
    prefix: 'Staking',
    storage: 'MinValidatorBond',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageValue<BigInt> _minimumActiveStake =
      const _i1.StorageValue<BigInt>(
    prefix: 'Staking',
    storage: 'MinimumActiveStake',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageValue<_i4.Perbill> _minCommission =
      const _i1.StorageValue<_i4.Perbill>(
    prefix: 'Staking',
    storage: 'MinCommission',
    valueCodec: _i4.PerbillCodec(),
  );

  final _i1.StorageMap<_i3.AccountId32, _i5.StakingLedger> _ledger =
      const _i1.StorageMap<_i3.AccountId32, _i5.StakingLedger>(
    prefix: 'Staking',
    storage: 'Ledger',
    valueCodec: _i5.StakingLedger.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i3.AccountId32, _i6.RewardDestination> _payee =
      const _i1.StorageMap<_i3.AccountId32, _i6.RewardDestination>(
    prefix: 'Staking',
    storage: 'Payee',
    valueCodec: _i6.RewardDestination.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i3.AccountId32, _i7.ValidatorPrefs> _validators =
      const _i1.StorageMap<_i3.AccountId32, _i7.ValidatorPrefs>(
    prefix: 'Staking',
    storage: 'Validators',
    valueCodec: _i7.ValidatorPrefs.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageValue<int> _counterForValidators =
      const _i1.StorageValue<int>(
    prefix: 'Staking',
    storage: 'CounterForValidators',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _maxValidatorsCount = const _i1.StorageValue<int>(
    prefix: 'Staking',
    storage: 'MaxValidatorsCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<_i3.AccountId32, _i8.Nominations> _nominators =
      const _i1.StorageMap<_i3.AccountId32, _i8.Nominations>(
    prefix: 'Staking',
    storage: 'Nominators',
    valueCodec: _i8.Nominations.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageValue<int> _counterForNominators =
      const _i1.StorageValue<int>(
    prefix: 'Staking',
    storage: 'CounterForNominators',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _maxNominatorsCount = const _i1.StorageValue<int>(
    prefix: 'Staking',
    storage: 'MaxNominatorsCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _currentEra = const _i1.StorageValue<int>(
    prefix: 'Staking',
    storage: 'CurrentEra',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i9.ActiveEraInfo> _activeEra =
      const _i1.StorageValue<_i9.ActiveEraInfo>(
    prefix: 'Staking',
    storage: 'ActiveEra',
    valueCodec: _i9.ActiveEraInfo.codec,
  );

  final _i1.StorageMap<int, int> _erasStartSessionIndex =
      const _i1.StorageMap<int, int>(
    prefix: 'Staking',
    storage: 'ErasStartSessionIndex',
    valueCodec: _i2.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, _i3.AccountId32, _i10.Exposure> _erasStakers =
      const _i1.StorageDoubleMap<int, _i3.AccountId32, _i10.Exposure>(
    prefix: 'Staking',
    storage: 'ErasStakers',
    valueCodec: _i10.Exposure.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageDoubleMap<int, _i3.AccountId32, _i10.Exposure>
      _erasStakersClipped =
      const _i1.StorageDoubleMap<int, _i3.AccountId32, _i10.Exposure>(
    prefix: 'Staking',
    storage: 'ErasStakersClipped',
    valueCodec: _i10.Exposure.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageDoubleMap<int, _i3.AccountId32, _i7.ValidatorPrefs>
      _erasValidatorPrefs =
      const _i1.StorageDoubleMap<int, _i3.AccountId32, _i7.ValidatorPrefs>(
    prefix: 'Staking',
    storage: 'ErasValidatorPrefs',
    valueCodec: _i7.ValidatorPrefs.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<int, BigInt> _erasValidatorReward =
      const _i1.StorageMap<int, BigInt>(
    prefix: 'Staking',
    storage: 'ErasValidatorReward',
    valueCodec: _i2.U128Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<int, _i11.EraRewardPoints> _erasRewardPoints =
      const _i1.StorageMap<int, _i11.EraRewardPoints>(
    prefix: 'Staking',
    storage: 'ErasRewardPoints',
    valueCodec: _i11.EraRewardPoints.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<int, BigInt> _erasTotalStake =
      const _i1.StorageMap<int, BigInt>(
    prefix: 'Staking',
    storage: 'ErasTotalStake',
    valueCodec: _i2.U128Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<_i12.Forcing> _forceEra =
      const _i1.StorageValue<_i12.Forcing>(
    prefix: 'Staking',
    storage: 'ForceEra',
    valueCodec: _i12.Forcing.codec,
  );

  final _i1.StorageValue<_i4.Perbill> _slashRewardFraction =
      const _i1.StorageValue<_i4.Perbill>(
    prefix: 'Staking',
    storage: 'SlashRewardFraction',
    valueCodec: _i4.PerbillCodec(),
  );

  final _i1.StorageValue<BigInt> _canceledSlashPayout =
      const _i1.StorageValue<BigInt>(
    prefix: 'Staking',
    storage: 'CanceledSlashPayout',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageMap<int, List<_i13.UnappliedSlash>> _unappliedSlashes =
      const _i1.StorageMap<int, List<_i13.UnappliedSlash>>(
    prefix: 'Staking',
    storage: 'UnappliedSlashes',
    valueCodec:
        _i2.SequenceCodec<_i13.UnappliedSlash>(_i13.UnappliedSlash.codec),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<List<_i14.Tuple2<int, int>>> _bondedEras =
      const _i1.StorageValue<List<_i14.Tuple2<int, int>>>(
    prefix: 'Staking',
    storage: 'BondedEras',
    valueCodec:
        _i2.SequenceCodec<_i14.Tuple2<int, int>>(_i14.Tuple2Codec<int, int>(
      _i2.U32Codec.codec,
      _i2.U32Codec.codec,
    )),
  );

  final _i1
      .StorageDoubleMap<int, _i3.AccountId32, _i15.Tuple2<_i4.Perbill, BigInt>>
      _validatorSlashInEra = const _i1.StorageDoubleMap<int, _i3.AccountId32,
          _i15.Tuple2<_i4.Perbill, BigInt>>(
    prefix: 'Staking',
    storage: 'ValidatorSlashInEra',
    valueCodec: _i15.Tuple2Codec<_i4.Perbill, BigInt>(
      _i4.PerbillCodec(),
      _i2.U128Codec.codec,
    ),
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageDoubleMap<int, _i3.AccountId32, BigInt>
      _nominatorSlashInEra =
      const _i1.StorageDoubleMap<int, _i3.AccountId32, BigInt>(
    prefix: 'Staking',
    storage: 'NominatorSlashInEra',
    valueCodec: _i2.U128Codec.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i3.AccountId32, _i16.SlashingSpans> _slashingSpans =
      const _i1.StorageMap<_i3.AccountId32, _i16.SlashingSpans>(
    prefix: 'Staking',
    storage: 'SlashingSpans',
    valueCodec: _i16.SlashingSpans.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i15.Tuple2<_i3.AccountId32, int>, _i17.SpanRecord>
      _spanSlash =
      const _i1.StorageMap<_i15.Tuple2<_i3.AccountId32, int>, _i17.SpanRecord>(
    prefix: 'Staking',
    storage: 'SpanSlash',
    valueCodec: _i17.SpanRecord.codec,
    hasher:
        _i1.StorageHasher.twoxx64Concat(_i15.Tuple2Codec<_i3.AccountId32, int>(
      _i3.AccountId32Codec(),
      _i2.U32Codec.codec,
    )),
  );

  final _i1.StorageValue<int> _currentPlannedSession =
      const _i1.StorageValue<int>(
    prefix: 'Staking',
    storage: 'CurrentPlannedSession',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i15.Tuple2<int, bool>>> _offendingValidators =
      const _i1.StorageValue<List<_i15.Tuple2<int, bool>>>(
    prefix: 'Staking',
    storage: 'OffendingValidators',
    valueCodec:
        _i2.SequenceCodec<_i15.Tuple2<int, bool>>(_i15.Tuple2Codec<int, bool>(
      _i2.U32Codec.codec,
      _i2.BoolCodec.codec,
    )),
  );

  final _i1.StorageValue<_i18.Percent> _chillThreshold =
      const _i1.StorageValue<_i18.Percent>(
    prefix: 'Staking',
    storage: 'ChillThreshold',
    valueCodec: _i18.PercentCodec(),
  );

  /// The ideal number of active validators.
  _i19.Future<int> validatorCount({_i1.BlockHash? at}) async {
    final hashedKey = _validatorCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validatorCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Minimum number of staking participants before emergency conditions are imposed.
  _i19.Future<int> minimumValidatorCount({_i1.BlockHash? at}) async {
    final hashedKey = _minimumValidatorCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minimumValidatorCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Any validators that may never be slashed or forcibly kicked. It's a Vec since they're
  /// easy to initialize and the performance hit is minimal (we expect no more than four
  /// invulnerables) and restricted to testnets.
  _i19.Future<List<_i3.AccountId32>> invulnerables({_i1.BlockHash? at}) async {
    final hashedKey = _invulnerables.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _invulnerables.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Map from all locked "stash" accounts to the controller account.
  ///
  /// TWOX-NOTE: SAFE since `AccountId` is a secure hash.
  _i19.Future<_i3.AccountId32?> bonded(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bonded.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bonded.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The minimum active bond to become and maintain the role of a nominator.
  _i19.Future<BigInt> minNominatorBond({_i1.BlockHash? at}) async {
    final hashedKey = _minNominatorBond.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minNominatorBond.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The minimum active bond to become and maintain the role of a validator.
  _i19.Future<BigInt> minValidatorBond({_i1.BlockHash? at}) async {
    final hashedKey = _minValidatorBond.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minValidatorBond.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The minimum active nominator stake of the last successful election.
  _i19.Future<BigInt> minimumActiveStake({_i1.BlockHash? at}) async {
    final hashedKey = _minimumActiveStake.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minimumActiveStake.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The minimum amount of commission that validators can set.
  ///
  /// If set to `0`, no limit exists.
  _i19.Future<_i4.Perbill> minCommission({_i1.BlockHash? at}) async {
    final hashedKey = _minCommission.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minCommission.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Map from all (unlocked) "controller" accounts to the info regarding the staking.
  _i19.Future<_i5.StakingLedger?> ledger(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _ledger.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _ledger.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Where the reward payment should be made. Keyed by stash.
  ///
  /// TWOX-NOTE: SAFE since `AccountId` is a secure hash.
  _i19.Future<_i6.RewardDestination> payee(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _payee.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _payee.decodeValue(bytes);
    }
    return _i6.Staked(); /* Default */
  }

  /// The map from (wannabe) validator stash key to the preferences of that validator.
  ///
  /// TWOX-NOTE: SAFE since `AccountId` is a secure hash.
  _i19.Future<_i7.ValidatorPrefs> validators(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _validators.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validators.decodeValue(bytes);
    }
    return _i7.ValidatorPrefs(
      commission: BigInt.zero,
      blocked: false,
    ); /* Default */
  }

  /// Counter for the related counted storage map
  _i19.Future<int> counterForValidators({_i1.BlockHash? at}) async {
    final hashedKey = _counterForValidators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForValidators.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The maximum validator count before we stop allowing new validators to join.
  ///
  /// When this value is not set, no limits are enforced.
  _i19.Future<int?> maxValidatorsCount({_i1.BlockHash? at}) async {
    final hashedKey = _maxValidatorsCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _maxValidatorsCount.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The map from nominator stash key to their nomination preferences, namely the validators that
  /// they wish to support.
  ///
  /// Note that the keys of this storage map might become non-decodable in case the
  /// [`Config::MaxNominations`] configuration is decreased. In this rare case, these nominators
  /// are still existent in storage, their key is correct and retrievable (i.e. `contains_key`
  /// indicates that they exist), but their value cannot be decoded. Therefore, the non-decodable
  /// nominators will effectively not-exist, until they re-submit their preferences such that it
  /// is within the bounds of the newly set `Config::MaxNominations`.
  ///
  /// This implies that `::iter_keys().count()` and `::iter().count()` might return different
  /// values for this map. Moreover, the main `::count()` is aligned with the former, namely the
  /// number of keys that exist.
  ///
  /// Lastly, if any of the nominators become non-decodable, they can be chilled immediately via
  /// [`Call::chill_other`] dispatchable by anyone.
  ///
  /// TWOX-NOTE: SAFE since `AccountId` is a secure hash.
  _i19.Future<_i8.Nominations?> nominators(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nominators.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nominators.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i19.Future<int> counterForNominators({_i1.BlockHash? at}) async {
    final hashedKey = _counterForNominators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForNominators.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The maximum nominator count before we stop allowing new validators to join.
  ///
  /// When this value is not set, no limits are enforced.
  _i19.Future<int?> maxNominatorsCount({_i1.BlockHash? at}) async {
    final hashedKey = _maxNominatorsCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _maxNominatorsCount.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The current era index.
  ///
  /// This is the latest planned era, depending on how the Session pallet queues the validator
  /// set, it might be active or not.
  _i19.Future<int?> currentEra({_i1.BlockHash? at}) async {
    final hashedKey = _currentEra.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentEra.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The active era information, it holds index and start.
  ///
  /// The active era is the era being currently rewarded. Validator set of this era must be
  /// equal to [`SessionInterface::validators`].
  _i19.Future<_i9.ActiveEraInfo?> activeEra({_i1.BlockHash? at}) async {
    final hashedKey = _activeEra.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _activeEra.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The session index at which the era start for the last `HISTORY_DEPTH` eras.
  ///
  /// Note: This tracks the starting session (i.e. session index when era start being active)
  /// for the eras in `[CurrentEra - HISTORY_DEPTH, CurrentEra]`.
  _i19.Future<int?> erasStartSessionIndex(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _erasStartSessionIndex.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasStartSessionIndex.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Exposure of validator at era.
  ///
  /// This is keyed first by the era index to allow bulk deletion and then the stash account.
  ///
  /// Is it removed after `HISTORY_DEPTH` eras.
  /// If stakers hasn't been set or has been removed then empty exposure is returned.
  _i19.Future<_i10.Exposure> erasStakers(
    int key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _erasStakers.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasStakers.decodeValue(bytes);
    }
    return _i10.Exposure(
      total: BigInt.zero,
      own: BigInt.zero,
      others: [],
    ); /* Default */
  }

  /// Clipped Exposure of validator at era.
  ///
  /// This is similar to [`ErasStakers`] but number of nominators exposed is reduced to the
  /// `T::MaxNominatorRewardedPerValidator` biggest stakers.
  /// (Note: the field `total` and `own` of the exposure remains unchanged).
  /// This is used to limit the i/o cost for the nominator payout.
  ///
  /// This is keyed fist by the era index to allow bulk deletion and then the stash account.
  ///
  /// Is it removed after `HISTORY_DEPTH` eras.
  /// If stakers hasn't been set or has been removed then empty exposure is returned.
  _i19.Future<_i10.Exposure> erasStakersClipped(
    int key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _erasStakersClipped.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasStakersClipped.decodeValue(bytes);
    }
    return _i10.Exposure(
      total: BigInt.zero,
      own: BigInt.zero,
      others: [],
    ); /* Default */
  }

  /// Similar to `ErasStakers`, this holds the preferences of validators.
  ///
  /// This is keyed first by the era index to allow bulk deletion and then the stash account.
  ///
  /// Is it removed after `HISTORY_DEPTH` eras.
  _i19.Future<_i7.ValidatorPrefs> erasValidatorPrefs(
    int key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _erasValidatorPrefs.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasValidatorPrefs.decodeValue(bytes);
    }
    return _i7.ValidatorPrefs(
      commission: BigInt.zero,
      blocked: false,
    ); /* Default */
  }

  /// The total validator era payout for the last `HISTORY_DEPTH` eras.
  ///
  /// Eras that haven't finished yet or has been removed doesn't have reward.
  _i19.Future<BigInt?> erasValidatorReward(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _erasValidatorReward.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasValidatorReward.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Rewards for the last `HISTORY_DEPTH` eras.
  /// If reward hasn't been set or has been removed then 0 reward is returned.
  _i19.Future<_i11.EraRewardPoints> erasRewardPoints(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _erasRewardPoints.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasRewardPoints.decodeValue(bytes);
    }
    return _i11.EraRewardPoints(
      total: 0,
      individual: <_i3.AccountId32, int>{},
    ); /* Default */
  }

  /// The total amount staked for the last `HISTORY_DEPTH` eras.
  /// If total hasn't been set or has been removed then 0 stake is returned.
  _i19.Future<BigInt> erasTotalStake(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _erasTotalStake.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasTotalStake.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Mode of era forcing.
  _i19.Future<_i12.Forcing> forceEra({_i1.BlockHash? at}) async {
    final hashedKey = _forceEra.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _forceEra.decodeValue(bytes);
    }
    return _i12.Forcing.notForcing; /* Default */
  }

  /// The percentage of the slash that is distributed to reporters.
  ///
  /// The rest of the slashed value is handled by the `Slash`.
  _i19.Future<_i4.Perbill> slashRewardFraction({_i1.BlockHash? at}) async {
    final hashedKey = _slashRewardFraction.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _slashRewardFraction.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The amount of currency given to reporters of a slash event which was
  /// canceled by extraordinary circumstances (e.g. governance).
  _i19.Future<BigInt> canceledSlashPayout({_i1.BlockHash? at}) async {
    final hashedKey = _canceledSlashPayout.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _canceledSlashPayout.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// All unapplied slashes that are queued for later.
  _i19.Future<List<_i13.UnappliedSlash>> unappliedSlashes(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _unappliedSlashes.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _unappliedSlashes.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// A mapping from still-bonded eras to the first session index of that era.
  ///
  /// Must contains information for eras for the range:
  /// `[active_era - bounding_duration; active_era]`
  _i19.Future<List<_i14.Tuple2<int, int>>> bondedEras(
      {_i1.BlockHash? at}) async {
    final hashedKey = _bondedEras.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bondedEras.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// All slashing events on validators, mapped by era to the highest slash proportion
  /// and slash value of the era.
  _i19.Future<_i15.Tuple2<_i4.Perbill, BigInt>?> validatorSlashInEra(
    int key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _validatorSlashInEra.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validatorSlashInEra.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// All slashing events on nominators, mapped by era to the highest slash value of the era.
  _i19.Future<BigInt?> nominatorSlashInEra(
    int key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nominatorSlashInEra.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nominatorSlashInEra.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Slashing spans for stash accounts.
  _i19.Future<_i16.SlashingSpans?> slashingSpans(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _slashingSpans.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _slashingSpans.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Records information about the maximum slash of a stash within a slashing span,
  /// as well as how much reward has been paid out.
  _i19.Future<_i17.SpanRecord> spanSlash(
    _i15.Tuple2<_i3.AccountId32, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _spanSlash.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _spanSlash.decodeValue(bytes);
    }
    return _i17.SpanRecord(
      slashed: BigInt.zero,
      paidOut: BigInt.zero,
    ); /* Default */
  }

  /// The last planned session scheduled by the session pallet.
  ///
  /// This is basically in sync with the call to [`pallet_session::SessionManager::new_session`].
  _i19.Future<int> currentPlannedSession({_i1.BlockHash? at}) async {
    final hashedKey = _currentPlannedSession.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentPlannedSession.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Indices of validators that have offended in the active era and whether they are currently
  /// disabled.
  ///
  /// This value should be a superset of disabled validators since not all offences lead to the
  /// validator being disabled (if there was no slash). This is needed to track the percentage of
  /// validators that have offended in the current era, ensuring a new era is forced if
  /// `OffendingValidatorsThreshold` is reached. The vec is always kept sorted so that we can find
  /// whether a given validator has previously offended using binary search. It gets cleared when
  /// the era ends.
  _i19.Future<List<_i15.Tuple2<int, bool>>> offendingValidators(
      {_i1.BlockHash? at}) async {
    final hashedKey = _offendingValidators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _offendingValidators.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The threshold for when users can start calling `chill_other` for other validators /
  /// nominators. The threshold is compared to the actual number of validators / nominators
  /// (`CountFor*`) in the system compared to the configured max (`Max*Count`).
  _i19.Future<_i18.Percent?> chillThreshold({_i1.BlockHash? at}) async {
    final hashedKey = _chillThreshold.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _chillThreshold.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}

class Txs {
  const Txs();

  /// Take the origin account as a stash and lock up `value` of its balance. `controller` will
  /// be the account that controls it.
  ///
  /// `value` must be more than the `minimum_balance` specified by `T::Currency`.
  ///
  /// The dispatch origin for this call must be _Signed_ by the stash account.
  ///
  /// Emits `Bonded`.
  /// ## Complexity
  /// - Independent of the arguments. Moderate complexity.
  /// - O(1).
  /// - Three extra DB entries.
  ///
  /// NOTE: Two of the storage writes (`Self::bonded`, `Self::payee`) are _never_ cleaned
  /// unless the `origin` falls below _existential deposit_ and gets removed as dust.
  _i20.RuntimeCall bond({
    required value,
    required payee,
  }) {
    final _call = _i21.Call.values.bond(
      value: value,
      payee: payee,
    );
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Add some extra amount that have appeared in the stash `free_balance` into the balance up
  /// for staking.
  ///
  /// The dispatch origin for this call must be _Signed_ by the stash, not the controller.
  ///
  /// Use this if there are additional funds in your stash account that you wish to bond.
  /// Unlike [`bond`](Self::bond) or [`unbond`](Self::unbond) this function does not impose
  /// any limitation on the amount that can be added.
  ///
  /// Emits `Bonded`.
  ///
  /// ## Complexity
  /// - Independent of the arguments. Insignificant complexity.
  /// - O(1).
  _i20.RuntimeCall bondExtra({required maxAdditional}) {
    final _call = _i21.Call.values.bondExtra(maxAdditional: maxAdditional);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Schedule a portion of the stash to be unlocked ready for transfer out after the bond
  /// period ends. If this leaves an amount actively bonded less than
  /// T::Currency::minimum_balance(), then it is increased to the full amount.
  ///
  /// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
  ///
  /// Once the unlock period is done, you can call `withdraw_unbonded` to actually move
  /// the funds out of management ready for transfer.
  ///
  /// No more than a limited number of unlocking chunks (see `MaxUnlockingChunks`)
  /// can co-exists at the same time. If there are no unlocking chunks slots available
  /// [`Call::withdraw_unbonded`] is called to remove some of the chunks (if possible).
  ///
  /// If a user encounters the `InsufficientBond` error when calling this extrinsic,
  /// they should call `chill` first in order to free up their bonded funds.
  ///
  /// Emits `Unbonded`.
  ///
  /// See also [`Call::withdraw_unbonded`].
  _i20.RuntimeCall unbond({required value}) {
    final _call = _i21.Call.values.unbond(value: value);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Remove any unlocked chunks from the `unlocking` queue from our management.
  ///
  /// This essentially frees up that balance to be used by the stash account to do
  /// whatever it wants.
  ///
  /// The dispatch origin for this call must be _Signed_ by the controller.
  ///
  /// Emits `Withdrawn`.
  ///
  /// See also [`Call::unbond`].
  ///
  /// ## Complexity
  /// O(S) where S is the number of slashing spans to remove
  /// NOTE: Weight annotation is the kill scenario, we refund otherwise.
  _i20.RuntimeCall withdrawUnbonded({required numSlashingSpans}) {
    final _call =
        _i21.Call.values.withdrawUnbonded(numSlashingSpans: numSlashingSpans);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Declare the desire to validate for the origin controller.
  ///
  /// Effects will be felt at the beginning of the next era.
  ///
  /// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
  _i20.RuntimeCall validate({required prefs}) {
    final _call = _i21.Call.values.validate(prefs: prefs);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Declare the desire to nominate `targets` for the origin controller.
  ///
  /// Effects will be felt at the beginning of the next era.
  ///
  /// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
  ///
  /// ## Complexity
  /// - The transaction's complexity is proportional to the size of `targets` (N)
  /// which is capped at CompactAssignments::LIMIT (T::MaxNominations).
  /// - Both the reads and writes follow a similar pattern.
  _i20.RuntimeCall nominate({required targets}) {
    final _call = _i21.Call.values.nominate(targets: targets);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Declare no desire to either validate or nominate.
  ///
  /// Effects will be felt at the beginning of the next era.
  ///
  /// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
  ///
  /// ## Complexity
  /// - Independent of the arguments. Insignificant complexity.
  /// - Contains one read.
  /// - Writes are limited to the `origin` account key.
  _i20.RuntimeCall chill() {
    final _call = _i21.Call.values.chill();
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// (Re-)set the payment target for a controller.
  ///
  /// Effects will be felt instantly (as soon as this function is completed successfully).
  ///
  /// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
  ///
  /// ## Complexity
  /// - O(1)
  /// - Independent of the arguments. Insignificant complexity.
  /// - Contains a limited number of reads.
  /// - Writes are limited to the `origin` account key.
  /// ---------
  _i20.RuntimeCall setPayee({required payee}) {
    final _call = _i21.Call.values.setPayee(payee: payee);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// (Re-)sets the controller of a stash to the stash itself. This function previously
  /// accepted a `controller` argument to set the controller to an account other than the
  /// stash itself. This functionality has now been removed, now only setting the controller
  /// to the stash, if it is not already.
  ///
  /// Effects will be felt instantly (as soon as this function is completed successfully).
  ///
  /// The dispatch origin for this call must be _Signed_ by the stash, not the controller.
  ///
  /// ## Complexity
  /// O(1)
  /// - Independent of the arguments. Insignificant complexity.
  /// - Contains a limited number of reads.
  /// - Writes are limited to the `origin` account key.
  _i20.RuntimeCall setController() {
    final _call = _i21.Call.values.setController();
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Sets the ideal number of validators.
  ///
  /// The dispatch origin must be Root.
  ///
  /// ## Complexity
  /// O(1)
  _i20.RuntimeCall setValidatorCount({required new_}) {
    final _call = _i21.Call.values.setValidatorCount(new_: new_);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Increments the ideal number of validators upto maximum of
  /// `ElectionProviderBase::MaxWinners`.
  ///
  /// The dispatch origin must be Root.
  ///
  /// ## Complexity
  /// Same as [`Self::set_validator_count`].
  _i20.RuntimeCall increaseValidatorCount({required additional}) {
    final _call =
        _i21.Call.values.increaseValidatorCount(additional: additional);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Scale up the ideal number of validators by a factor upto maximum of
  /// `ElectionProviderBase::MaxWinners`.
  ///
  /// The dispatch origin must be Root.
  ///
  /// ## Complexity
  /// Same as [`Self::set_validator_count`].
  _i20.RuntimeCall scaleValidatorCount({required factor}) {
    final _call = _i21.Call.values.scaleValidatorCount(factor: factor);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Force there to be no new eras indefinitely.
  ///
  /// The dispatch origin must be Root.
  ///
  /// # Warning
  ///
  /// The election process starts multiple blocks before the end of the era.
  /// Thus the election process may be ongoing when this is called. In this case the
  /// election will continue until the next era is triggered.
  ///
  /// ## Complexity
  /// - No arguments.
  /// - Weight: O(1)
  _i20.RuntimeCall forceNoEras() {
    final _call = _i21.Call.values.forceNoEras();
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Force there to be a new era at the end of the next session. After this, it will be
  /// reset to normal (non-forced) behaviour.
  ///
  /// The dispatch origin must be Root.
  ///
  /// # Warning
  ///
  /// The election process starts multiple blocks before the end of the era.
  /// If this is called just before a new era is triggered, the election process may not
  /// have enough blocks to get a result.
  ///
  /// ## Complexity
  /// - No arguments.
  /// - Weight: O(1)
  _i20.RuntimeCall forceNewEra() {
    final _call = _i21.Call.values.forceNewEra();
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Set the validators who cannot be slashed (if any).
  ///
  /// The dispatch origin must be Root.
  _i20.RuntimeCall setInvulnerables({required invulnerables}) {
    final _call =
        _i21.Call.values.setInvulnerables(invulnerables: invulnerables);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Force a current staker to become completely unstaked, immediately.
  ///
  /// The dispatch origin must be Root.
  _i20.RuntimeCall forceUnstake({
    required stash,
    required numSlashingSpans,
  }) {
    final _call = _i21.Call.values.forceUnstake(
      stash: stash,
      numSlashingSpans: numSlashingSpans,
    );
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Force there to be a new era at the end of sessions indefinitely.
  ///
  /// The dispatch origin must be Root.
  ///
  /// # Warning
  ///
  /// The election process starts multiple blocks before the end of the era.
  /// If this is called just before a new era is triggered, the election process may not
  /// have enough blocks to get a result.
  _i20.RuntimeCall forceNewEraAlways() {
    final _call = _i21.Call.values.forceNewEraAlways();
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Cancel enactment of a deferred slash.
  ///
  /// Can be called by the `T::AdminOrigin`.
  ///
  /// Parameters: era and indices of the slashes for that era to kill.
  _i20.RuntimeCall cancelDeferredSlash({
    required era,
    required slashIndices,
  }) {
    final _call = _i21.Call.values.cancelDeferredSlash(
      era: era,
      slashIndices: slashIndices,
    );
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Pay out all the stakers behind a single validator for a single era.
  ///
  /// - `validator_stash` is the stash account of the validator. Their nominators, up to
  ///  `T::MaxNominatorRewardedPerValidator`, will also receive their rewards.
  /// - `era` may be any era between `[current_era - history_depth; current_era]`.
  ///
  /// The origin of this call must be _Signed_. Any account can call this function, even if
  /// it is not one of the stakers.
  ///
  /// ## Complexity
  /// - At most O(MaxNominatorRewardedPerValidator).
  _i20.RuntimeCall payoutStakers({
    required validatorStash,
    required era,
  }) {
    final _call = _i21.Call.values.payoutStakers(
      validatorStash: validatorStash,
      era: era,
    );
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Rebond a portion of the stash scheduled to be unlocked.
  ///
  /// The dispatch origin must be signed by the controller.
  ///
  /// ## Complexity
  /// - Time complexity: O(L), where L is unlocking chunks
  /// - Bounded by `MaxUnlockingChunks`.
  _i20.RuntimeCall rebond({required value}) {
    final _call = _i21.Call.values.rebond(value: value);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Remove all data structures concerning a staker/stash once it is at a state where it can
  /// be considered `dust` in the staking system. The requirements are:
  ///
  /// 1. the `total_balance` of the stash is below existential deposit.
  /// 2. or, the `ledger.total` of the stash is below existential deposit.
  ///
  /// The former can happen in cases like a slash; the latter when a fully unbonded account
  /// is still receiving staking rewards in `RewardDestination::Staked`.
  ///
  /// It can be called by anyone, as long as `stash` meets the above requirements.
  ///
  /// Refunds the transaction fees upon successful execution.
  _i20.RuntimeCall reapStash({
    required stash,
    required numSlashingSpans,
  }) {
    final _call = _i21.Call.values.reapStash(
      stash: stash,
      numSlashingSpans: numSlashingSpans,
    );
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Remove the given nominations from the calling validator.
  ///
  /// Effects will be felt at the beginning of the next era.
  ///
  /// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
  ///
  /// - `who`: A list of nominator stash accounts who are nominating this validator which
  ///  should no longer be nominating this validator.
  ///
  /// Note: Making this call only makes sense if you first set the validator preferences to
  /// block any further nominations.
  _i20.RuntimeCall kick({required who}) {
    final _call = _i21.Call.values.kick(who: who);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Update the various staking configurations .
  ///
  /// * `min_nominator_bond`: The minimum active bond needed to be a nominator.
  /// * `min_validator_bond`: The minimum active bond needed to be a validator.
  /// * `max_nominator_count`: The max number of users who can be a nominator at once. When
  ///  set to `None`, no limit is enforced.
  /// * `max_validator_count`: The max number of users who can be a validator at once. When
  ///  set to `None`, no limit is enforced.
  /// * `chill_threshold`: The ratio of `max_nominator_count` or `max_validator_count` which
  ///  should be filled in order for the `chill_other` transaction to work.
  /// * `min_commission`: The minimum amount of commission that each validators must maintain.
  ///  This is checked only upon calling `validate`. Existing validators are not affected.
  ///
  /// RuntimeOrigin must be Root to call this function.
  ///
  /// NOTE: Existing nominators and validators will not be affected by this update.
  /// to kick people under the new limits, `chill_other` should be called.
  _i20.RuntimeCall setStakingConfigs({
    required minNominatorBond,
    required minValidatorBond,
    required maxNominatorCount,
    required maxValidatorCount,
    required chillThreshold,
    required minCommission,
  }) {
    final _call = _i21.Call.values.setStakingConfigs(
      minNominatorBond: minNominatorBond,
      minValidatorBond: minValidatorBond,
      maxNominatorCount: maxNominatorCount,
      maxValidatorCount: maxValidatorCount,
      chillThreshold: chillThreshold,
      minCommission: minCommission,
    );
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Declare a `controller` to stop participating as either a validator or nominator.
  ///
  /// Effects will be felt at the beginning of the next era.
  ///
  /// The dispatch origin for this call must be _Signed_, but can be called by anyone.
  ///
  /// If the caller is the same as the controller being targeted, then no further checks are
  /// enforced, and this function behaves just like `chill`.
  ///
  /// If the caller is different than the controller being targeted, the following conditions
  /// must be met:
  ///
  /// * `controller` must belong to a nominator who has become non-decodable,
  ///
  /// Or:
  ///
  /// * A `ChillThreshold` must be set and checked which defines how close to the max
  ///  nominators or validators we must reach before users can start chilling one-another.
  /// * A `MaxNominatorCount` and `MaxValidatorCount` must be set which is used to determine
  ///  how close we are to the threshold.
  /// * A `MinNominatorBond` and `MinValidatorBond` must be set and checked, which determines
  ///  if this is a person that should be chilled because they have not met the threshold
  ///  bond required.
  ///
  /// This can be helpful if bond requirements are updated, and we need to remove old users
  /// who do not satisfy these requirements.
  _i20.RuntimeCall chillOther({required controller}) {
    final _call = _i21.Call.values.chillOther(controller: controller);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Force a validator to have at least the minimum commission. This will not affect a
  /// validator who already has a commission greater than or equal to the minimum. Any account
  /// can call this.
  _i20.RuntimeCall forceApplyMinCommission({required validatorStash}) {
    final _call = _i21.Call.values
        .forceApplyMinCommission(validatorStash: validatorStash);
    return _i20.RuntimeCall.values.staking(_call);
  }

  /// Sets the minimum amount of commission that each validators must maintain.
  ///
  /// This call has lower privilege requirements than `set_staking_config` and can be called
  /// by the `T::AdminOrigin`. Root can always call this.
  _i20.RuntimeCall setMinCommission({required new_}) {
    final _call = _i21.Call.values.setMinCommission(new_: new_);
    return _i20.RuntimeCall.values.staking(_call);
  }
}

class Constants {
  Constants();

  /// Maximum number of nominations per nominator.
  final int maxNominations = 16;

  /// Number of eras to keep in history.
  ///
  /// Following information is kept for eras in `[current_era -
  /// HistoryDepth, current_era]`: `ErasStakers`, `ErasStakersClipped`,
  /// `ErasValidatorPrefs`, `ErasValidatorReward`, `ErasRewardPoints`,
  /// `ErasTotalStake`, `ErasStartSessionIndex`,
  /// `StakingLedger.claimed_rewards`.
  ///
  /// Must be more than the number of eras delayed by session.
  /// I.e. active era must always be in history. I.e. `active_era >
  /// current_era - history_depth` must be guaranteed.
  ///
  /// If migrating an existing pallet from storage value to config value,
  /// this should be set to same value or greater as in storage.
  ///
  /// Note: `HistoryDepth` is used as the upper bound for the `BoundedVec`
  /// item `StakingLedger.claimed_rewards`. Setting this value lower than
  /// the existing value can lead to inconsistencies in the
  /// `StakingLedger` and will need to be handled properly in a migration.
  /// The test `reducing_history_depth_abrupt` shows this effect.
  final int historyDepth = 84;

  /// Number of sessions per era.
  final int sessionsPerEra = 6;

  /// Number of eras that staked funds must remain bonded for.
  final int bondingDuration = 28;

  /// Number of eras that slashes are deferred by, after computation.
  ///
  /// This should be less than the bonding duration. Set to 0 if slashes
  /// should be applied immediately, without opportunity for intervention.
  final int slashDeferDuration = 27;

  /// The maximum number of nominators rewarded for each validator.
  ///
  /// For each validator only the `$MaxNominatorRewardedPerValidator` biggest stakers can
  /// claim their reward. This used to limit the i/o cost for the nominator payout.
  final int maxNominatorRewardedPerValidator = 512;

  /// The maximum number of `unlocking` chunks a [`StakingLedger`] can
  /// have. Effectively determines how many unique eras a staker may be
  /// unbonding in.
  ///
  /// Note: `MaxUnlockingChunks` is used as the upper bound for the
  /// `BoundedVec` item `StakingLedger.unlocking`. Setting this value
  /// lower than the existing value can lead to inconsistencies in the
  /// `StakingLedger` and will need to be handled properly in a runtime
  /// migration. The test `reducing_max_unlocking_chunks_abrupt` shows
  /// this effect.
  final int maxUnlockingChunks = 32;
}
