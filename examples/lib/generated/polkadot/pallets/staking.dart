// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i21;
import 'dart:typed_data' as _i22;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/pallet_staking/active_era_info.dart' as _i9;
import '../types/pallet_staking/era_reward_points.dart' as _i13;
import '../types/pallet_staking/forcing.dart' as _i14;
import '../types/pallet_staking/nominations.dart' as _i8;
import '../types/pallet_staking/pallet/pallet/call.dart' as _i24;
import '../types/pallet_staking/pallet/pallet/config_op_1.dart' as _i26;
import '../types/pallet_staking/pallet/pallet/config_op_2.dart' as _i27;
import '../types/pallet_staking/pallet/pallet/config_op_3.dart' as _i28;
import '../types/pallet_staking/pallet/pallet/config_op_4.dart' as _i29;
import '../types/pallet_staking/reward_destination.dart' as _i6;
import '../types/pallet_staking/slashing/slashing_spans.dart' as _i19;
import '../types/pallet_staking/slashing/span_record.dart' as _i20;
import '../types/pallet_staking/staking_ledger.dart' as _i5;
import '../types/pallet_staking/unapplied_slash.dart' as _i16;
import '../types/pallet_staking/unlock_chunk.dart' as _i30;
import '../types/pallet_staking/validator_prefs.dart' as _i7;
import '../types/polkadot_runtime/runtime_call.dart' as _i23;
import '../types/sp_arithmetic/per_things/perbill.dart' as _i4;
import '../types/sp_arithmetic/per_things/percent.dart' as _i15;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i25;
import '../types/sp_staking/exposure.dart' as _i10;
import '../types/sp_staking/exposure_page.dart' as _i12;
import '../types/sp_staking/paged_exposure_metadata.dart' as _i11;
import '../types/tuples.dart' as _i18;
import '../types/tuples_1.dart' as _i17;

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

  final _i1.StorageMap<_i3.AccountId32, dynamic> _virtualStakers =
      const _i1.StorageMap<_i3.AccountId32, dynamic>(
    prefix: 'Staking',
    storage: 'VirtualStakers',
    valueCodec: _i2.NullCodec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageValue<int> _counterForVirtualStakers =
      const _i1.StorageValue<int>(
    prefix: 'Staking',
    storage: 'CounterForVirtualStakers',
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

  final _i1.StorageDoubleMap<int, _i3.AccountId32, _i11.PagedExposureMetadata>
      _erasStakersOverview = const _i1
          .StorageDoubleMap<int, _i3.AccountId32, _i11.PagedExposureMetadata>(
    prefix: 'Staking',
    storage: 'ErasStakersOverview',
    valueCodec: _i11.PagedExposureMetadata.codec,
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

  final _i1.StorageTripleMap<int, _i3.AccountId32, int, _i12.ExposurePage>
      _erasStakersPaged =
      const _i1.StorageTripleMap<int, _i3.AccountId32, int, _i12.ExposurePage>(
    prefix: 'Staking',
    storage: 'ErasStakersPaged',
    valueCodec: _i12.ExposurePage.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
    hasher3: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, _i3.AccountId32, List<int>> _claimedRewards =
      const _i1.StorageDoubleMap<int, _i3.AccountId32, List<int>>(
    prefix: 'Staking',
    storage: 'ClaimedRewards',
    valueCodec: _i2.U32SequenceCodec.codec,
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

  final _i1.StorageMap<int, _i13.EraRewardPoints> _erasRewardPoints =
      const _i1.StorageMap<int, _i13.EraRewardPoints>(
    prefix: 'Staking',
    storage: 'ErasRewardPoints',
    valueCodec: _i13.EraRewardPoints.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<int, BigInt> _erasTotalStake =
      const _i1.StorageMap<int, BigInt>(
    prefix: 'Staking',
    storage: 'ErasTotalStake',
    valueCodec: _i2.U128Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<_i14.Forcing> _forceEra =
      const _i1.StorageValue<_i14.Forcing>(
    prefix: 'Staking',
    storage: 'ForceEra',
    valueCodec: _i14.Forcing.codec,
  );

  final _i1.StorageValue<_i15.Percent> _maxStakedRewards =
      const _i1.StorageValue<_i15.Percent>(
    prefix: 'Staking',
    storage: 'MaxStakedRewards',
    valueCodec: _i15.PercentCodec(),
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

  final _i1.StorageMap<int, List<_i16.UnappliedSlash>> _unappliedSlashes =
      const _i1.StorageMap<int, List<_i16.UnappliedSlash>>(
    prefix: 'Staking',
    storage: 'UnappliedSlashes',
    valueCodec:
        _i2.SequenceCodec<_i16.UnappliedSlash>(_i16.UnappliedSlash.codec),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<List<_i17.Tuple2<int, int>>> _bondedEras =
      const _i1.StorageValue<List<_i17.Tuple2<int, int>>>(
    prefix: 'Staking',
    storage: 'BondedEras',
    valueCodec:
        _i2.SequenceCodec<_i17.Tuple2<int, int>>(_i17.Tuple2Codec<int, int>(
      _i2.U32Codec.codec,
      _i2.U32Codec.codec,
    )),
  );

  final _i1
      .StorageDoubleMap<int, _i3.AccountId32, _i18.Tuple2<_i4.Perbill, BigInt>>
      _validatorSlashInEra = const _i1.StorageDoubleMap<int, _i3.AccountId32,
          _i18.Tuple2<_i4.Perbill, BigInt>>(
    prefix: 'Staking',
    storage: 'ValidatorSlashInEra',
    valueCodec: _i18.Tuple2Codec<_i4.Perbill, BigInt>(
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

  final _i1.StorageMap<_i3.AccountId32, _i19.SlashingSpans> _slashingSpans =
      const _i1.StorageMap<_i3.AccountId32, _i19.SlashingSpans>(
    prefix: 'Staking',
    storage: 'SlashingSpans',
    valueCodec: _i19.SlashingSpans.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageMap<_i18.Tuple2<_i3.AccountId32, int>, _i20.SpanRecord>
      _spanSlash =
      const _i1.StorageMap<_i18.Tuple2<_i3.AccountId32, int>, _i20.SpanRecord>(
    prefix: 'Staking',
    storage: 'SpanSlash',
    valueCodec: _i20.SpanRecord.codec,
    hasher:
        _i1.StorageHasher.twoxx64Concat(_i18.Tuple2Codec<_i3.AccountId32, int>(
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

  final _i1.StorageValue<List<int>> _disabledValidators =
      const _i1.StorageValue<List<int>>(
    prefix: 'Staking',
    storage: 'DisabledValidators',
    valueCodec: _i2.U32SequenceCodec.codec,
  );

  final _i1.StorageValue<_i15.Percent> _chillThreshold =
      const _i1.StorageValue<_i15.Percent>(
    prefix: 'Staking',
    storage: 'ChillThreshold',
    valueCodec: _i15.PercentCodec(),
  );

  /// The ideal number of active validators.
  _i21.Future<int> validatorCount({_i1.BlockHash? at}) async {
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
  _i21.Future<int> minimumValidatorCount({_i1.BlockHash? at}) async {
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
  _i21.Future<List<_i3.AccountId32>> invulnerables({_i1.BlockHash? at}) async {
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
  _i21.Future<_i3.AccountId32?> bonded(
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
  _i21.Future<BigInt> minNominatorBond({_i1.BlockHash? at}) async {
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
  _i21.Future<BigInt> minValidatorBond({_i1.BlockHash? at}) async {
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
  _i21.Future<BigInt> minimumActiveStake({_i1.BlockHash? at}) async {
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
  _i21.Future<_i4.Perbill> minCommission({_i1.BlockHash? at}) async {
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
  ///
  /// Note: All the reads and mutations to this storage *MUST* be done through the methods exposed
  /// by [`StakingLedger`] to ensure data and lock consistency.
  _i21.Future<_i5.StakingLedger?> ledger(
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
  _i21.Future<_i6.RewardDestination?> payee(
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
    return null; /* Nullable */
  }

  /// The map from (wannabe) validator stash key to the preferences of that validator.
  ///
  /// TWOX-NOTE: SAFE since `AccountId` is a secure hash.
  _i21.Future<_i7.ValidatorPrefs> validators(
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
  _i21.Future<int> counterForValidators({_i1.BlockHash? at}) async {
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
  _i21.Future<int?> maxValidatorsCount({_i1.BlockHash? at}) async {
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
  /// account's [`NominationsQuota::MaxNominations`] configuration is decreased.
  /// In this rare case, these nominators
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
  _i21.Future<_i8.Nominations?> nominators(
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
  _i21.Future<int> counterForNominators({_i1.BlockHash? at}) async {
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

  /// Stakers whose funds are managed by other pallets.
  ///
  /// This pallet does not apply any locks on them, therefore they are only virtually bonded. They
  /// are expected to be keyless accounts and hence should not be allowed to mutate their ledger
  /// directly via this pallet. Instead, these accounts are managed by other pallets and accessed
  /// via low level apis. We keep track of them to do minimal integrity checks.
  _i21.Future<dynamic> virtualStakers(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _virtualStakers.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _virtualStakers.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i21.Future<int> counterForVirtualStakers({_i1.BlockHash? at}) async {
    final hashedKey = _counterForVirtualStakers.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForVirtualStakers.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The maximum nominator count before we stop allowing new validators to join.
  ///
  /// When this value is not set, no limits are enforced.
  _i21.Future<int?> maxNominatorsCount({_i1.BlockHash? at}) async {
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
  _i21.Future<int?> currentEra({_i1.BlockHash? at}) async {
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
  _i21.Future<_i9.ActiveEraInfo?> activeEra({_i1.BlockHash? at}) async {
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

  /// The session index at which the era start for the last [`Config::HistoryDepth`] eras.
  ///
  /// Note: This tracks the starting session (i.e. session index when era start being active)
  /// for the eras in `[CurrentEra - HISTORY_DEPTH, CurrentEra]`.
  _i21.Future<int?> erasStartSessionIndex(
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
  /// Is it removed after [`Config::HistoryDepth`] eras.
  /// If stakers hasn't been set or has been removed then empty exposure is returned.
  ///
  /// Note: Deprecated since v14. Use `EraInfo` instead to work with exposures.
  _i21.Future<_i10.Exposure> erasStakers(
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

  /// Summary of validator exposure at a given era.
  ///
  /// This contains the total stake in support of the validator and their own stake. In addition,
  /// it can also be used to get the number of nominators backing this validator and the number of
  /// exposure pages they are divided into. The page count is useful to determine the number of
  /// pages of rewards that needs to be claimed.
  ///
  /// This is keyed first by the era index to allow bulk deletion and then the stash account.
  /// Should only be accessed through `EraInfo`.
  ///
  /// Is it removed after [`Config::HistoryDepth`] eras.
  /// If stakers hasn't been set or has been removed then empty overview is returned.
  _i21.Future<_i11.PagedExposureMetadata?> erasStakersOverview(
    int key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _erasStakersOverview.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasStakersOverview.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Clipped Exposure of validator at era.
  ///
  /// Note: This is deprecated, should be used as read-only and will be removed in the future.
  /// New `Exposure`s are stored in a paged manner in `ErasStakersPaged` instead.
  ///
  /// This is similar to [`ErasStakers`] but number of nominators exposed is reduced to the
  /// `T::MaxExposurePageSize` biggest stakers.
  /// (Note: the field `total` and `own` of the exposure remains unchanged).
  /// This is used to limit the i/o cost for the nominator payout.
  ///
  /// This is keyed fist by the era index to allow bulk deletion and then the stash account.
  ///
  /// It is removed after [`Config::HistoryDepth`] eras.
  /// If stakers hasn't been set or has been removed then empty exposure is returned.
  ///
  /// Note: Deprecated since v14. Use `EraInfo` instead to work with exposures.
  _i21.Future<_i10.Exposure> erasStakersClipped(
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

  /// Paginated exposure of a validator at given era.
  ///
  /// This is keyed first by the era index to allow bulk deletion, then stash account and finally
  /// the page. Should only be accessed through `EraInfo`.
  ///
  /// This is cleared after [`Config::HistoryDepth`] eras.
  _i21.Future<_i12.ExposurePage?> erasStakersPaged(
    int key1,
    _i3.AccountId32 key2,
    int key3, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _erasStakersPaged.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasStakersPaged.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// History of claimed paged rewards by era and validator.
  ///
  /// This is keyed by era and validator stash which maps to the set of page indexes which have
  /// been claimed.
  ///
  /// It is removed after [`Config::HistoryDepth`] eras.
  _i21.Future<List<int>> claimedRewards(
    int key1,
    _i3.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _claimedRewards.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _claimedRewards.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// Similar to `ErasStakers`, this holds the preferences of validators.
  ///
  /// This is keyed first by the era index to allow bulk deletion and then the stash account.
  ///
  /// Is it removed after [`Config::HistoryDepth`] eras.
  _i21.Future<_i7.ValidatorPrefs> erasValidatorPrefs(
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

  /// The total validator era payout for the last [`Config::HistoryDepth`] eras.
  ///
  /// Eras that haven't finished yet or has been removed doesn't have reward.
  _i21.Future<BigInt?> erasValidatorReward(
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

  /// Rewards for the last [`Config::HistoryDepth`] eras.
  /// If reward hasn't been set or has been removed then 0 reward is returned.
  _i21.Future<_i13.EraRewardPoints> erasRewardPoints(
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
    return _i13.EraRewardPoints(
      total: 0,
      individual: <_i3.AccountId32, int>{},
    ); /* Default */
  }

  /// The total amount staked for the last [`Config::HistoryDepth`] eras.
  /// If total hasn't been set or has been removed then 0 stake is returned.
  _i21.Future<BigInt> erasTotalStake(
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
  _i21.Future<_i14.Forcing> forceEra({_i1.BlockHash? at}) async {
    final hashedKey = _forceEra.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _forceEra.decodeValue(bytes);
    }
    return _i14.Forcing.notForcing; /* Default */
  }

  /// Maximum staked rewards, i.e. the percentage of the era inflation that
  /// is used for stake rewards.
  /// See [Era payout](./index.html#era-payout).
  _i21.Future<_i15.Percent?> maxStakedRewards({_i1.BlockHash? at}) async {
    final hashedKey = _maxStakedRewards.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _maxStakedRewards.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The percentage of the slash that is distributed to reporters.
  ///
  /// The rest of the slashed value is handled by the `Slash`.
  _i21.Future<_i4.Perbill> slashRewardFraction({_i1.BlockHash? at}) async {
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
  _i21.Future<BigInt> canceledSlashPayout({_i1.BlockHash? at}) async {
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
  _i21.Future<List<_i16.UnappliedSlash>> unappliedSlashes(
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
  _i21.Future<List<_i17.Tuple2<int, int>>> bondedEras(
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
  _i21.Future<_i18.Tuple2<_i4.Perbill, BigInt>?> validatorSlashInEra(
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
  _i21.Future<BigInt?> nominatorSlashInEra(
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
  _i21.Future<_i19.SlashingSpans?> slashingSpans(
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
  _i21.Future<_i20.SpanRecord> spanSlash(
    _i18.Tuple2<_i3.AccountId32, int> key1, {
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
    return _i20.SpanRecord(
      slashed: BigInt.zero,
      paidOut: BigInt.zero,
    ); /* Default */
  }

  /// The last planned session scheduled by the session pallet.
  ///
  /// This is basically in sync with the call to [`pallet_session::SessionManager::new_session`].
  _i21.Future<int> currentPlannedSession({_i1.BlockHash? at}) async {
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

  /// Indices of validators that have offended in the active era. The offenders are disabled for a
  /// whole era. For this reason they are kept here - only staking pallet knows about eras. The
  /// implementor of [`DisablingStrategy`] defines if a validator should be disabled which
  /// implicitly means that the implementor also controls the max number of disabled validators.
  ///
  /// The vec is always kept sorted so that we can find whether a given validator has previously
  /// offended using binary search.
  _i21.Future<List<int>> disabledValidators({_i1.BlockHash? at}) async {
    final hashedKey = _disabledValidators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _disabledValidators.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The threshold for when users can start calling `chill_other` for other validators /
  /// nominators. The threshold is compared to the actual number of validators / nominators
  /// (`CountFor*`) in the system compared to the configured max (`Max*Count`).
  _i21.Future<_i15.Percent?> chillThreshold({_i1.BlockHash? at}) async {
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

  /// Returns the storage key for `validatorCount`.
  _i22.Uint8List validatorCountKey() {
    final hashedKey = _validatorCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `minimumValidatorCount`.
  _i22.Uint8List minimumValidatorCountKey() {
    final hashedKey = _minimumValidatorCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `invulnerables`.
  _i22.Uint8List invulnerablesKey() {
    final hashedKey = _invulnerables.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `bonded`.
  _i22.Uint8List bondedKey(_i3.AccountId32 key1) {
    final hashedKey = _bonded.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `minNominatorBond`.
  _i22.Uint8List minNominatorBondKey() {
    final hashedKey = _minNominatorBond.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `minValidatorBond`.
  _i22.Uint8List minValidatorBondKey() {
    final hashedKey = _minValidatorBond.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `minimumActiveStake`.
  _i22.Uint8List minimumActiveStakeKey() {
    final hashedKey = _minimumActiveStake.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `minCommission`.
  _i22.Uint8List minCommissionKey() {
    final hashedKey = _minCommission.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `ledger`.
  _i22.Uint8List ledgerKey(_i3.AccountId32 key1) {
    final hashedKey = _ledger.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `payee`.
  _i22.Uint8List payeeKey(_i3.AccountId32 key1) {
    final hashedKey = _payee.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `validators`.
  _i22.Uint8List validatorsKey(_i3.AccountId32 key1) {
    final hashedKey = _validators.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForValidators`.
  _i22.Uint8List counterForValidatorsKey() {
    final hashedKey = _counterForValidators.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `maxValidatorsCount`.
  _i22.Uint8List maxValidatorsCountKey() {
    final hashedKey = _maxValidatorsCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nominators`.
  _i22.Uint8List nominatorsKey(_i3.AccountId32 key1) {
    final hashedKey = _nominators.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForNominators`.
  _i22.Uint8List counterForNominatorsKey() {
    final hashedKey = _counterForNominators.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `virtualStakers`.
  _i22.Uint8List virtualStakersKey(_i3.AccountId32 key1) {
    final hashedKey = _virtualStakers.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForVirtualStakers`.
  _i22.Uint8List counterForVirtualStakersKey() {
    final hashedKey = _counterForVirtualStakers.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `maxNominatorsCount`.
  _i22.Uint8List maxNominatorsCountKey() {
    final hashedKey = _maxNominatorsCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `currentEra`.
  _i22.Uint8List currentEraKey() {
    final hashedKey = _currentEra.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `activeEra`.
  _i22.Uint8List activeEraKey() {
    final hashedKey = _activeEra.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `erasStartSessionIndex`.
  _i22.Uint8List erasStartSessionIndexKey(int key1) {
    final hashedKey = _erasStartSessionIndex.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `erasStakers`.
  _i22.Uint8List erasStakersKey(
    int key1,
    _i3.AccountId32 key2,
  ) {
    final hashedKey = _erasStakers.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `erasStakersOverview`.
  _i22.Uint8List erasStakersOverviewKey(
    int key1,
    _i3.AccountId32 key2,
  ) {
    final hashedKey = _erasStakersOverview.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `erasStakersClipped`.
  _i22.Uint8List erasStakersClippedKey(
    int key1,
    _i3.AccountId32 key2,
  ) {
    final hashedKey = _erasStakersClipped.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `erasStakersPaged`.
  _i22.Uint8List erasStakersPagedKey(
    int key1,
    _i3.AccountId32 key2,
    int key3,
  ) {
    final hashedKey = _erasStakersPaged.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    return hashedKey;
  }

  /// Returns the storage key for `claimedRewards`.
  _i22.Uint8List claimedRewardsKey(
    int key1,
    _i3.AccountId32 key2,
  ) {
    final hashedKey = _claimedRewards.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `erasValidatorPrefs`.
  _i22.Uint8List erasValidatorPrefsKey(
    int key1,
    _i3.AccountId32 key2,
  ) {
    final hashedKey = _erasValidatorPrefs.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `erasValidatorReward`.
  _i22.Uint8List erasValidatorRewardKey(int key1) {
    final hashedKey = _erasValidatorReward.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `erasRewardPoints`.
  _i22.Uint8List erasRewardPointsKey(int key1) {
    final hashedKey = _erasRewardPoints.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `erasTotalStake`.
  _i22.Uint8List erasTotalStakeKey(int key1) {
    final hashedKey = _erasTotalStake.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `forceEra`.
  _i22.Uint8List forceEraKey() {
    final hashedKey = _forceEra.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `maxStakedRewards`.
  _i22.Uint8List maxStakedRewardsKey() {
    final hashedKey = _maxStakedRewards.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `slashRewardFraction`.
  _i22.Uint8List slashRewardFractionKey() {
    final hashedKey = _slashRewardFraction.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `canceledSlashPayout`.
  _i22.Uint8List canceledSlashPayoutKey() {
    final hashedKey = _canceledSlashPayout.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `unappliedSlashes`.
  _i22.Uint8List unappliedSlashesKey(int key1) {
    final hashedKey = _unappliedSlashes.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `bondedEras`.
  _i22.Uint8List bondedErasKey() {
    final hashedKey = _bondedEras.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `validatorSlashInEra`.
  _i22.Uint8List validatorSlashInEraKey(
    int key1,
    _i3.AccountId32 key2,
  ) {
    final hashedKey = _validatorSlashInEra.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `nominatorSlashInEra`.
  _i22.Uint8List nominatorSlashInEraKey(
    int key1,
    _i3.AccountId32 key2,
  ) {
    final hashedKey = _nominatorSlashInEra.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `slashingSpans`.
  _i22.Uint8List slashingSpansKey(_i3.AccountId32 key1) {
    final hashedKey = _slashingSpans.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `spanSlash`.
  _i22.Uint8List spanSlashKey(_i18.Tuple2<_i3.AccountId32, int> key1) {
    final hashedKey = _spanSlash.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `currentPlannedSession`.
  _i22.Uint8List currentPlannedSessionKey() {
    final hashedKey = _currentPlannedSession.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `disabledValidators`.
  _i22.Uint8List disabledValidatorsKey() {
    final hashedKey = _disabledValidators.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `chillThreshold`.
  _i22.Uint8List chillThresholdKey() {
    final hashedKey = _chillThreshold.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `bonded`.
  _i22.Uint8List bondedMapPrefix() {
    final hashedKey = _bonded.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `ledger`.
  _i22.Uint8List ledgerMapPrefix() {
    final hashedKey = _ledger.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `payee`.
  _i22.Uint8List payeeMapPrefix() {
    final hashedKey = _payee.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `validators`.
  _i22.Uint8List validatorsMapPrefix() {
    final hashedKey = _validators.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nominators`.
  _i22.Uint8List nominatorsMapPrefix() {
    final hashedKey = _nominators.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `virtualStakers`.
  _i22.Uint8List virtualStakersMapPrefix() {
    final hashedKey = _virtualStakers.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `erasStartSessionIndex`.
  _i22.Uint8List erasStartSessionIndexMapPrefix() {
    final hashedKey = _erasStartSessionIndex.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `erasStakers`.
  _i22.Uint8List erasStakersMapPrefix(int key1) {
    final hashedKey = _erasStakers.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `erasStakersOverview`.
  _i22.Uint8List erasStakersOverviewMapPrefix(int key1) {
    final hashedKey = _erasStakersOverview.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `erasStakersClipped`.
  _i22.Uint8List erasStakersClippedMapPrefix(int key1) {
    final hashedKey = _erasStakersClipped.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `claimedRewards`.
  _i22.Uint8List claimedRewardsMapPrefix(int key1) {
    final hashedKey = _claimedRewards.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `erasValidatorPrefs`.
  _i22.Uint8List erasValidatorPrefsMapPrefix(int key1) {
    final hashedKey = _erasValidatorPrefs.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `erasValidatorReward`.
  _i22.Uint8List erasValidatorRewardMapPrefix() {
    final hashedKey = _erasValidatorReward.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `erasRewardPoints`.
  _i22.Uint8List erasRewardPointsMapPrefix() {
    final hashedKey = _erasRewardPoints.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `erasTotalStake`.
  _i22.Uint8List erasTotalStakeMapPrefix() {
    final hashedKey = _erasTotalStake.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `unappliedSlashes`.
  _i22.Uint8List unappliedSlashesMapPrefix() {
    final hashedKey = _unappliedSlashes.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `validatorSlashInEra`.
  _i22.Uint8List validatorSlashInEraMapPrefix(int key1) {
    final hashedKey = _validatorSlashInEra.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nominatorSlashInEra`.
  _i22.Uint8List nominatorSlashInEraMapPrefix(int key1) {
    final hashedKey = _nominatorSlashInEra.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `slashingSpans`.
  _i22.Uint8List slashingSpansMapPrefix() {
    final hashedKey = _slashingSpans.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `spanSlash`.
  _i22.Uint8List spanSlashMapPrefix() {
    final hashedKey = _spanSlash.mapPrefix();
    return hashedKey;
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
  /// unless the `origin` falls below _existential deposit_ (or equal to 0) and gets removed
  /// as dust.
  _i23.RuntimeCall bond({
    required BigInt value,
    required _i6.RewardDestination payee,
  }) {
    final _call = _i24.Call.values.bond(
      value: value,
      payee: payee,
    );
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall bondExtra({required BigInt maxAdditional}) {
    final _call = _i24.Call.values.bondExtra(maxAdditional: maxAdditional);
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall unbond({required BigInt value}) {
    final _call = _i24.Call.values.unbond(value: value);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Remove any unlocked chunks from the `unlocking` queue from our management.
  ///
  /// This essentially frees up that balance to be used by the stash account to do whatever
  /// it wants.
  ///
  /// The dispatch origin for this call must be _Signed_ by the controller.
  ///
  /// Emits `Withdrawn`.
  ///
  /// See also [`Call::unbond`].
  ///
  /// ## Parameters
  ///
  /// - `num_slashing_spans` indicates the number of metadata slashing spans to clear when
  /// this call results in a complete removal of all the data related to the stash account.
  /// In this case, the `num_slashing_spans` must be larger or equal to the number of
  /// slashing spans associated with the stash account in the [`SlashingSpans`] storage type,
  /// otherwise the call will fail. The call weight is directly proportional to
  /// `num_slashing_spans`.
  ///
  /// ## Complexity
  /// O(S) where S is the number of slashing spans to remove
  /// NOTE: Weight annotation is the kill scenario, we refund otherwise.
  _i23.RuntimeCall withdrawUnbonded({required int numSlashingSpans}) {
    final _call =
        _i24.Call.values.withdrawUnbonded(numSlashingSpans: numSlashingSpans);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Declare the desire to validate for the origin controller.
  ///
  /// Effects will be felt at the beginning of the next era.
  ///
  /// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
  _i23.RuntimeCall validate({required _i7.ValidatorPrefs prefs}) {
    final _call = _i24.Call.values.validate(prefs: prefs);
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall nominate({required List<_i25.MultiAddress> targets}) {
    final _call = _i24.Call.values.nominate(targets: targets);
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall chill() {
    final _call = _i24.Call.values.chill();
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall setPayee({required _i6.RewardDestination payee}) {
    final _call = _i24.Call.values.setPayee(payee: payee);
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall setController() {
    final _call = _i24.Call.values.setController();
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Sets the ideal number of validators.
  ///
  /// The dispatch origin must be Root.
  ///
  /// ## Complexity
  /// O(1)
  _i23.RuntimeCall setValidatorCount({required BigInt new_}) {
    final _call = _i24.Call.values.setValidatorCount(new_: new_);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Increments the ideal number of validators up to maximum of
  /// `ElectionProviderBase::MaxWinners`.
  ///
  /// The dispatch origin must be Root.
  ///
  /// ## Complexity
  /// Same as [`Self::set_validator_count`].
  _i23.RuntimeCall increaseValidatorCount({required BigInt additional}) {
    final _call =
        _i24.Call.values.increaseValidatorCount(additional: additional);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Scale up the ideal number of validators by a factor up to maximum of
  /// `ElectionProviderBase::MaxWinners`.
  ///
  /// The dispatch origin must be Root.
  ///
  /// ## Complexity
  /// Same as [`Self::set_validator_count`].
  _i23.RuntimeCall scaleValidatorCount({required _i15.Percent factor}) {
    final _call = _i24.Call.values.scaleValidatorCount(factor: factor);
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall forceNoEras() {
    final _call = _i24.Call.values.forceNoEras();
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall forceNewEra() {
    final _call = _i24.Call.values.forceNewEra();
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Set the validators who cannot be slashed (if any).
  ///
  /// The dispatch origin must be Root.
  _i23.RuntimeCall setInvulnerables(
      {required List<_i3.AccountId32> invulnerables}) {
    final _call =
        _i24.Call.values.setInvulnerables(invulnerables: invulnerables);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Force a current staker to become completely unstaked, immediately.
  ///
  /// The dispatch origin must be Root.
  ///
  /// ## Parameters
  ///
  /// - `num_slashing_spans`: Refer to comments on [`Call::withdraw_unbonded`] for more
  /// details.
  _i23.RuntimeCall forceUnstake({
    required _i3.AccountId32 stash,
    required int numSlashingSpans,
  }) {
    final _call = _i24.Call.values.forceUnstake(
      stash: stash,
      numSlashingSpans: numSlashingSpans,
    );
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall forceNewEraAlways() {
    final _call = _i24.Call.values.forceNewEraAlways();
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Cancel enactment of a deferred slash.
  ///
  /// Can be called by the `T::AdminOrigin`.
  ///
  /// Parameters: era and indices of the slashes for that era to kill.
  _i23.RuntimeCall cancelDeferredSlash({
    required int era,
    required List<int> slashIndices,
  }) {
    final _call = _i24.Call.values.cancelDeferredSlash(
      era: era,
      slashIndices: slashIndices,
    );
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Pay out next page of the stakers behind a validator for the given era.
  ///
  /// - `validator_stash` is the stash account of the validator.
  /// - `era` may be any era between `[current_era - history_depth; current_era]`.
  ///
  /// The origin of this call must be _Signed_. Any account can call this function, even if
  /// it is not one of the stakers.
  ///
  /// The reward payout could be paged in case there are too many nominators backing the
  /// `validator_stash`. This call will payout unpaid pages in an ascending order. To claim a
  /// specific page, use `payout_stakers_by_page`.`
  ///
  /// If all pages are claimed, it returns an error `InvalidPage`.
  _i23.RuntimeCall payoutStakers({
    required _i3.AccountId32 validatorStash,
    required int era,
  }) {
    final _call = _i24.Call.values.payoutStakers(
      validatorStash: validatorStash,
      era: era,
    );
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Rebond a portion of the stash scheduled to be unlocked.
  ///
  /// The dispatch origin must be signed by the controller.
  ///
  /// ## Complexity
  /// - Time complexity: O(L), where L is unlocking chunks
  /// - Bounded by `MaxUnlockingChunks`.
  _i23.RuntimeCall rebond({required BigInt value}) {
    final _call = _i24.Call.values.rebond(value: value);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Remove all data structures concerning a staker/stash once it is at a state where it can
  /// be considered `dust` in the staking system. The requirements are:
  ///
  /// 1. the `total_balance` of the stash is below existential deposit.
  /// 2. or, the `ledger.total` of the stash is below existential deposit.
  /// 3. or, existential deposit is zero and either `total_balance` or `ledger.total` is zero.
  ///
  /// The former can happen in cases like a slash; the latter when a fully unbonded account
  /// is still receiving staking rewards in `RewardDestination::Staked`.
  ///
  /// It can be called by anyone, as long as `stash` meets the above requirements.
  ///
  /// Refunds the transaction fees upon successful execution.
  ///
  /// ## Parameters
  ///
  /// - `num_slashing_spans`: Refer to comments on [`Call::withdraw_unbonded`] for more
  /// details.
  _i23.RuntimeCall reapStash({
    required _i3.AccountId32 stash,
    required int numSlashingSpans,
  }) {
    final _call = _i24.Call.values.reapStash(
      stash: stash,
      numSlashingSpans: numSlashingSpans,
    );
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall kick({required List<_i25.MultiAddress> who}) {
    final _call = _i24.Call.values.kick(who: who);
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall setStakingConfigs({
    required _i26.ConfigOp minNominatorBond,
    required _i26.ConfigOp minValidatorBond,
    required _i27.ConfigOp maxNominatorCount,
    required _i27.ConfigOp maxValidatorCount,
    required _i28.ConfigOp chillThreshold,
    required _i29.ConfigOp minCommission,
    required _i28.ConfigOp maxStakedRewards,
  }) {
    final _call = _i24.Call.values.setStakingConfigs(
      minNominatorBond: minNominatorBond,
      minValidatorBond: minValidatorBond,
      maxNominatorCount: maxNominatorCount,
      maxValidatorCount: maxValidatorCount,
      chillThreshold: chillThreshold,
      minCommission: minCommission,
      maxStakedRewards: maxStakedRewards,
    );
    return _i23.RuntimeCall.values.staking(_call);
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
  _i23.RuntimeCall chillOther({required _i3.AccountId32 stash}) {
    final _call = _i24.Call.values.chillOther(stash: stash);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Force a validator to have at least the minimum commission. This will not affect a
  /// validator who already has a commission greater than or equal to the minimum. Any account
  /// can call this.
  _i23.RuntimeCall forceApplyMinCommission(
      {required _i3.AccountId32 validatorStash}) {
    final _call = _i24.Call.values
        .forceApplyMinCommission(validatorStash: validatorStash);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Sets the minimum amount of commission that each validators must maintain.
  ///
  /// This call has lower privilege requirements than `set_staking_config` and can be called
  /// by the `T::AdminOrigin`. Root can always call this.
  _i23.RuntimeCall setMinCommission({required _i4.Perbill new_}) {
    final _call = _i24.Call.values.setMinCommission(new_: new_);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Pay out a page of the stakers behind a validator for the given era and page.
  ///
  /// - `validator_stash` is the stash account of the validator.
  /// - `era` may be any era between `[current_era - history_depth; current_era]`.
  /// - `page` is the page index of nominators to pay out with value between 0 and
  ///  `num_nominators / T::MaxExposurePageSize`.
  ///
  /// The origin of this call must be _Signed_. Any account can call this function, even if
  /// it is not one of the stakers.
  ///
  /// If a validator has more than [`Config::MaxExposurePageSize`] nominators backing
  /// them, then the list of nominators is paged, with each page being capped at
  /// [`Config::MaxExposurePageSize`.] If a validator has more than one page of nominators,
  /// the call needs to be made for each page separately in order for all the nominators
  /// backing a validator to receive the reward. The nominators are not sorted across pages
  /// and so it should not be assumed the highest staker would be on the topmost page and vice
  /// versa. If rewards are not claimed in [`Config::HistoryDepth`] eras, they are lost.
  _i23.RuntimeCall payoutStakersByPage({
    required _i3.AccountId32 validatorStash,
    required int era,
    required int page,
  }) {
    final _call = _i24.Call.values.payoutStakersByPage(
      validatorStash: validatorStash,
      era: era,
      page: page,
    );
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Migrates an account's `RewardDestination::Controller` to
  /// `RewardDestination::Account(controller)`.
  ///
  /// Effects will be felt instantly (as soon as this function is completed successfully).
  ///
  /// This will waive the transaction fee if the `payee` is successfully migrated.
  _i23.RuntimeCall updatePayee({required _i3.AccountId32 controller}) {
    final _call = _i24.Call.values.updatePayee(controller: controller);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Updates a batch of controller accounts to their corresponding stash account if they are
  /// not the same. Ignores any controller accounts that do not exist, and does not operate if
  /// the stash and controller are already the same.
  ///
  /// Effects will be felt instantly (as soon as this function is completed successfully).
  ///
  /// The dispatch origin must be `T::AdminOrigin`.
  _i23.RuntimeCall deprecateControllerBatch(
      {required List<_i3.AccountId32> controllers}) {
    final _call =
        _i24.Call.values.deprecateControllerBatch(controllers: controllers);
    return _i23.RuntimeCall.values.staking(_call);
  }

  /// Restores the state of a ledger which is in an inconsistent state.
  ///
  /// The requirements to restore a ledger are the following:
  /// * The stash is bonded; or
  /// * The stash is not bonded but it has a staking lock left behind; or
  /// * If the stash has an associated ledger and its state is inconsistent; or
  /// * If the ledger is not corrupted *but* its staking lock is out of sync.
  ///
  /// The `maybe_*` input parameters will overwrite the corresponding data and metadata of the
  /// ledger associated with the stash. If the input parameters are not set, the ledger will
  /// be reset values from on-chain state.
  _i23.RuntimeCall restoreLedger({
    required _i3.AccountId32 stash,
    _i3.AccountId32? maybeController,
    BigInt? maybeTotal,
    List<_i30.UnlockChunk>? maybeUnlocking,
  }) {
    final _call = _i24.Call.values.restoreLedger(
      stash: stash,
      maybeController: maybeController,
      maybeTotal: maybeTotal,
      maybeUnlocking: maybeUnlocking,
    );
    return _i23.RuntimeCall.values.staking(_call);
  }
}

class Constants {
  Constants();

  /// Number of eras to keep in history.
  ///
  /// Following information is kept for eras in `[current_era -
  /// HistoryDepth, current_era]`: `ErasStakers`, `ErasStakersClipped`,
  /// `ErasValidatorPrefs`, `ErasValidatorReward`, `ErasRewardPoints`,
  /// `ErasTotalStake`, `ErasStartSessionIndex`, `ClaimedRewards`, `ErasStakersPaged`,
  /// `ErasStakersOverview`.
  ///
  /// Must be more than the number of eras delayed by session.
  /// I.e. active era must always be in history. I.e. `active_era >
  /// current_era - history_depth` must be guaranteed.
  ///
  /// If migrating an existing pallet from storage value to config value,
  /// this should be set to same value or greater as in storage.
  ///
  /// Note: `HistoryDepth` is used as the upper bound for the `BoundedVec`
  /// item `StakingLedger.legacy_claimed_rewards`. Setting this value lower than
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

  /// The maximum size of each `T::ExposurePage`.
  ///
  /// An `ExposurePage` is weakly bounded to a maximum of `MaxExposurePageSize`
  /// nominators.
  ///
  /// For older non-paged exposure, a reward payout was restricted to the top
  /// `MaxExposurePageSize` nominators. This is to limit the i/o cost for the
  /// nominator payout.
  ///
  /// Note: `MaxExposurePageSize` is used to bound `ClaimedRewards` and is unsafe to reduce
  /// without handling it in a migration.
  final int maxExposurePageSize = 512;

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
