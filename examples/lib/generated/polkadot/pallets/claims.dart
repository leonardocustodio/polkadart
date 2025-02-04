// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/polkadot_runtime/runtime_call.dart' as _i9;
import '../types/polkadot_runtime_common/claims/ecdsa_signature.dart' as _i10;
import '../types/polkadot_runtime_common/claims/ethereum_address.dart' as _i2;
import '../types/polkadot_runtime_common/claims/pallet/call.dart' as _i11;
import '../types/polkadot_runtime_common/claims/statement_kind.dart' as _i5;
import '../types/sp_core/crypto/account_id32.dart' as _i6;
import '../types/tuples_2.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.EthereumAddress, BigInt> _claims =
      const _i1.StorageMap<_i2.EthereumAddress, BigInt>(
    prefix: 'Claims',
    storage: 'Claims',
    valueCodec: _i3.U128Codec.codec,
    hasher: _i1.StorageHasher.identity(_i2.EthereumAddressCodec()),
  );

  final _i1.StorageValue<BigInt> _total = const _i1.StorageValue<BigInt>(
    prefix: 'Claims',
    storage: 'Total',
    valueCodec: _i3.U128Codec.codec,
  );

  final _i1.StorageMap<_i2.EthereumAddress, _i4.Tuple3<BigInt, BigInt, int>>
      _vesting = const _i1
          .StorageMap<_i2.EthereumAddress, _i4.Tuple3<BigInt, BigInt, int>>(
    prefix: 'Claims',
    storage: 'Vesting',
    valueCodec: _i4.Tuple3Codec<BigInt, BigInt, int>(
      _i3.U128Codec.codec,
      _i3.U128Codec.codec,
      _i3.U32Codec.codec,
    ),
    hasher: _i1.StorageHasher.identity(_i2.EthereumAddressCodec()),
  );

  final _i1.StorageMap<_i2.EthereumAddress, _i5.StatementKind> _signing =
      const _i1.StorageMap<_i2.EthereumAddress, _i5.StatementKind>(
    prefix: 'Claims',
    storage: 'Signing',
    valueCodec: _i5.StatementKind.codec,
    hasher: _i1.StorageHasher.identity(_i2.EthereumAddressCodec()),
  );

  final _i1.StorageMap<_i6.AccountId32, _i2.EthereumAddress> _preclaims =
      const _i1.StorageMap<_i6.AccountId32, _i2.EthereumAddress>(
    prefix: 'Claims',
    storage: 'Preclaims',
    valueCodec: _i2.EthereumAddressCodec(),
    hasher: _i1.StorageHasher.identity(_i6.AccountId32Codec()),
  );

  _i7.Future<BigInt?> claims(
    _i2.EthereumAddress key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _claims.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _claims.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i7.Future<BigInt> total({_i1.BlockHash? at}) async {
    final hashedKey = _total.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _total.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Vesting schedule for a claim.
  /// First balance is the total amount that should be held for vesting.
  /// Second balance is how much should be unlocked per block.
  /// The block number is when the vesting should start.
  _i7.Future<_i4.Tuple3<BigInt, BigInt, int>?> vesting(
    _i2.EthereumAddress key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _vesting.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _vesting.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The statement kind that must be signed, if any.
  _i7.Future<_i5.StatementKind?> signing(
    _i2.EthereumAddress key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _signing.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _signing.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Pre-claimed Ethereum accounts, by the Account ID that they are claimed to.
  _i7.Future<_i2.EthereumAddress?> preclaims(
    _i6.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _preclaims.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _preclaims.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `claims`.
  _i8.Uint8List claimsKey(_i2.EthereumAddress key1) {
    final hashedKey = _claims.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `total`.
  _i8.Uint8List totalKey() {
    final hashedKey = _total.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `vesting`.
  _i8.Uint8List vestingKey(_i2.EthereumAddress key1) {
    final hashedKey = _vesting.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `signing`.
  _i8.Uint8List signingKey(_i2.EthereumAddress key1) {
    final hashedKey = _signing.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `preclaims`.
  _i8.Uint8List preclaimsKey(_i6.AccountId32 key1) {
    final hashedKey = _preclaims.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `claims`.
  _i8.Uint8List claimsMapPrefix() {
    final hashedKey = _claims.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `vesting`.
  _i8.Uint8List vestingMapPrefix() {
    final hashedKey = _vesting.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `signing`.
  _i8.Uint8List signingMapPrefix() {
    final hashedKey = _signing.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `preclaims`.
  _i8.Uint8List preclaimsMapPrefix() {
    final hashedKey = _preclaims.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Make a claim to collect your DOTs.
  ///
  /// The dispatch origin for this call must be _None_.
  ///
  /// Unsigned Validation:
  /// A call to claim is deemed valid if the signature provided matches
  /// the expected signed message of:
  ///
  /// > Ethereum Signed Message:
  /// > (configured prefix string)(address)
  ///
  /// and `address` matches the `dest` account.
  ///
  /// Parameters:
  /// - `dest`: The destination account to payout the claim.
  /// - `ethereum_signature`: The signature of an ethereum signed message matching the format
  ///  described above.
  ///
  /// <weight>
  /// The weight of this call is invariant over the input parameters.
  /// Weight includes logic to validate unsigned `claim` call.
  ///
  /// Total Complexity: O(1)
  /// </weight>
  _i9.RuntimeCall claim({
    required _i6.AccountId32 dest,
    required _i10.EcdsaSignature ethereumSignature,
  }) {
    final _call = _i11.Call.values.claim(
      dest: dest,
      ethereumSignature: ethereumSignature,
    );
    return _i9.RuntimeCall.values.claims(_call);
  }

  /// Mint a new claim to collect DOTs.
  ///
  /// The dispatch origin for this call must be _Root_.
  ///
  /// Parameters:
  /// - `who`: The Ethereum address allowed to collect this claim.
  /// - `value`: The number of DOTs that will be claimed.
  /// - `vesting_schedule`: An optional vesting schedule for these DOTs.
  ///
  /// <weight>
  /// The weight of this call is invariant over the input parameters.
  /// We assume worst case that both vesting and statement is being inserted.
  ///
  /// Total Complexity: O(1)
  /// </weight>
  _i9.RuntimeCall mintClaim({
    required _i2.EthereumAddress who,
    required BigInt value,
    _i4.Tuple3<BigInt, BigInt, int>? vestingSchedule,
    _i5.StatementKind? statement,
  }) {
    final _call = _i11.Call.values.mintClaim(
      who: who,
      value: value,
      vestingSchedule: vestingSchedule,
      statement: statement,
    );
    return _i9.RuntimeCall.values.claims(_call);
  }

  /// Make a claim to collect your DOTs by signing a statement.
  ///
  /// The dispatch origin for this call must be _None_.
  ///
  /// Unsigned Validation:
  /// A call to `claim_attest` is deemed valid if the signature provided matches
  /// the expected signed message of:
  ///
  /// > Ethereum Signed Message:
  /// > (configured prefix string)(address)(statement)
  ///
  /// and `address` matches the `dest` account; the `statement` must match that which is
  /// expected according to your purchase arrangement.
  ///
  /// Parameters:
  /// - `dest`: The destination account to payout the claim.
  /// - `ethereum_signature`: The signature of an ethereum signed message matching the format
  ///  described above.
  /// - `statement`: The identity of the statement which is being attested to in the
  ///  signature.
  ///
  /// <weight>
  /// The weight of this call is invariant over the input parameters.
  /// Weight includes logic to validate unsigned `claim_attest` call.
  ///
  /// Total Complexity: O(1)
  /// </weight>
  _i9.RuntimeCall claimAttest({
    required _i6.AccountId32 dest,
    required _i10.EcdsaSignature ethereumSignature,
    required List<int> statement,
  }) {
    final _call = _i11.Call.values.claimAttest(
      dest: dest,
      ethereumSignature: ethereumSignature,
      statement: statement,
    );
    return _i9.RuntimeCall.values.claims(_call);
  }

  /// Attest to a statement, needed to finalize the claims process.
  ///
  /// WARNING: Insecure unless your chain includes `PrevalidateAttests` as a
  /// `SignedExtension`.
  ///
  /// Unsigned Validation:
  /// A call to attest is deemed valid if the sender has a `Preclaim` registered
  /// and provides a `statement` which is expected for the account.
  ///
  /// Parameters:
  /// - `statement`: The identity of the statement which is being attested to in the
  ///  signature.
  ///
  /// <weight>
  /// The weight of this call is invariant over the input parameters.
  /// Weight includes logic to do pre-validation on `attest` call.
  ///
  /// Total Complexity: O(1)
  /// </weight>
  _i9.RuntimeCall attest({required List<int> statement}) {
    final _call = _i11.Call.values.attest(statement: statement);
    return _i9.RuntimeCall.values.claims(_call);
  }

  _i9.RuntimeCall moveClaim({
    required _i2.EthereumAddress old,
    required _i2.EthereumAddress new_,
    _i6.AccountId32? maybePreclaim,
  }) {
    final _call = _i11.Call.values.moveClaim(
      old: old,
      new_: new_,
      maybePreclaim: maybePreclaim,
    );
    return _i9.RuntimeCall.values.claims(_call);
  }
}

class Constants {
  Constants();

  final List<int> prefix = const <int>[
    80,
    97,
    121,
    32,
    68,
    79,
    84,
    115,
    32,
    116,
    111,
    32,
    116,
    104,
    101,
    32,
    80,
    111,
    108,
    107,
    97,
    100,
    111,
    116,
    32,
    97,
    99,
    99,
    111,
    117,
    110,
    116,
    58,
  ];
}
