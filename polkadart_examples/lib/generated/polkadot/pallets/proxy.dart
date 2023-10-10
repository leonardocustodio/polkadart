// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i5;

import '../types/pallet_proxy/announcement.dart' as _i6;
import '../types/pallet_proxy/pallet/call.dart' as _i9;
import '../types/pallet_proxy/proxy_definition.dart' as _i4;
import '../types/polkadot_runtime/runtime_call.dart' as _i8;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/tuples.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.AccountId32,
          _i3.Tuple2<List<_i4.ProxyDefinition>, BigInt>> _proxies =
      const _i1.StorageMap<_i2.AccountId32,
          _i3.Tuple2<List<_i4.ProxyDefinition>, BigInt>>(
    prefix: 'Proxy',
    storage: 'Proxies',
    valueCodec: _i3.Tuple2Codec<List<_i4.ProxyDefinition>, BigInt>(
      _i5.SequenceCodec<_i4.ProxyDefinition>(_i4.ProxyDefinition.codec),
      _i5.U128Codec.codec,
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
  );

  final _i1
      .StorageMap<_i2.AccountId32, _i3.Tuple2<List<_i6.Announcement>, BigInt>>
      _announcements = const _i1.StorageMap<_i2.AccountId32,
          _i3.Tuple2<List<_i6.Announcement>, BigInt>>(
    prefix: 'Proxy',
    storage: 'Announcements',
    valueCodec: _i3.Tuple2Codec<List<_i6.Announcement>, BigInt>(
      _i5.SequenceCodec<_i6.Announcement>(_i6.Announcement.codec),
      _i5.U128Codec.codec,
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
  );

  /// The set of account proxies. Maps the account which has delegated to the accounts
  /// which are being delegated to, together with the amount held on deposit.
  _i7.Future<_i3.Tuple2<List<_i4.ProxyDefinition>, BigInt>> proxies(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _proxies.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proxies.decodeValue(bytes);
    }
    return _i3.Tuple2<List<_i4.ProxyDefinition>, BigInt>(
      [],
      BigInt.zero,
    ); /* Default */
  }

  /// The announcements made by the proxy (key).
  _i7.Future<_i3.Tuple2<List<_i6.Announcement>, BigInt>> announcements(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _announcements.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _announcements.decodeValue(bytes);
    }
    return _i3.Tuple2<List<_i6.Announcement>, BigInt>(
      [],
      BigInt.zero,
    ); /* Default */
  }
}

class Txs {
  const Txs();

  /// Dispatch the given `call` from an account that the sender is authorised for through
  /// `add_proxy`.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// Parameters:
  /// - `real`: The account that the proxy will make a call on behalf of.
  /// - `force_proxy_type`: Specify the exact proxy type to be used and checked for this call.
  /// - `call`: The call to be made by the `real` account.
  _i8.RuntimeCall proxy({
    required real,
    forceProxyType,
    required call,
  }) {
    final _call = _i9.Call.values.proxy(
      real: real,
      forceProxyType: forceProxyType,
      call: call,
    );
    return _i8.RuntimeCall.values.proxy(_call);
  }

  /// Register a proxy account for the sender that is able to make calls on its behalf.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// Parameters:
  /// - `proxy`: The account that the `caller` would like to make a proxy.
  /// - `proxy_type`: The permissions allowed for this proxy account.
  /// - `delay`: The announcement period required of the initial proxy. Will generally be
  /// zero.
  _i8.RuntimeCall addProxy({
    required delegate,
    required proxyType,
    required delay,
  }) {
    final _call = _i9.Call.values.addProxy(
      delegate: delegate,
      proxyType: proxyType,
      delay: delay,
    );
    return _i8.RuntimeCall.values.proxy(_call);
  }

  /// Unregister a proxy account for the sender.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// Parameters:
  /// - `proxy`: The account that the `caller` would like to remove as a proxy.
  /// - `proxy_type`: The permissions currently enabled for the removed proxy account.
  _i8.RuntimeCall removeProxy({
    required delegate,
    required proxyType,
    required delay,
  }) {
    final _call = _i9.Call.values.removeProxy(
      delegate: delegate,
      proxyType: proxyType,
      delay: delay,
    );
    return _i8.RuntimeCall.values.proxy(_call);
  }

  /// Unregister all proxy accounts for the sender.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// WARNING: This may be called on accounts created by `pure`, however if done, then
  /// the unreserved fees will be inaccessible. **All access to this account will be lost.**
  _i8.RuntimeCall removeProxies() {
    final _call = _i9.Call.values.removeProxies();
    return _i8.RuntimeCall.values.proxy(_call);
  }

  /// Spawn a fresh new account that is guaranteed to be otherwise inaccessible, and
  /// initialize it with a proxy of `proxy_type` for `origin` sender.
  ///
  /// Requires a `Signed` origin.
  ///
  /// - `proxy_type`: The type of the proxy that the sender will be registered as over the
  /// new account. This will almost always be the most permissive `ProxyType` possible to
  /// allow for maximum flexibility.
  /// - `index`: A disambiguation index, in case this is called multiple times in the same
  /// transaction (e.g. with `utility::batch`). Unless you're using `batch` you probably just
  /// want to use `0`.
  /// - `delay`: The announcement period required of the initial proxy. Will generally be
  /// zero.
  ///
  /// Fails with `Duplicate` if this has already been called in this transaction, from the
  /// same sender, with the same parameters.
  ///
  /// Fails if there are insufficient funds to pay for deposit.
  _i8.RuntimeCall createPure({
    required proxyType,
    required delay,
    required index,
  }) {
    final _call = _i9.Call.values.createPure(
      proxyType: proxyType,
      delay: delay,
      index: index,
    );
    return _i8.RuntimeCall.values.proxy(_call);
  }

  /// Removes a previously spawned pure proxy.
  ///
  /// WARNING: **All access to this account will be lost.** Any funds held in it will be
  /// inaccessible.
  ///
  /// Requires a `Signed` origin, and the sender account must have been created by a call to
  /// `pure` with corresponding parameters.
  ///
  /// - `spawner`: The account that originally called `pure` to create this account.
  /// - `index`: The disambiguation index originally passed to `pure`. Probably `0`.
  /// - `proxy_type`: The proxy type originally passed to `pure`.
  /// - `height`: The height of the chain when the call to `pure` was processed.
  /// - `ext_index`: The extrinsic index in which the call to `pure` was processed.
  ///
  /// Fails with `NoPermission` in case the caller is not a previously created pure
  /// account whose `pure` call has corresponding parameters.
  _i8.RuntimeCall killPure({
    required spawner,
    required proxyType,
    required index,
    required height,
    required extIndex,
  }) {
    final _call = _i9.Call.values.killPure(
      spawner: spawner,
      proxyType: proxyType,
      index: index,
      height: height,
      extIndex: extIndex,
    );
    return _i8.RuntimeCall.values.proxy(_call);
  }

  /// Publish the hash of a proxy-call that will be made in the future.
  ///
  /// This must be called some number of blocks before the corresponding `proxy` is attempted
  /// if the delay associated with the proxy relationship is greater than zero.
  ///
  /// No more than `MaxPending` announcements may be made at any one time.
  ///
  /// This will take a deposit of `AnnouncementDepositFactor` as well as
  /// `AnnouncementDepositBase` if there are no other pending announcements.
  ///
  /// The dispatch origin for this call must be _Signed_ and a proxy of `real`.
  ///
  /// Parameters:
  /// - `real`: The account that the proxy will make a call on behalf of.
  /// - `call_hash`: The hash of the call to be made by the `real` account.
  _i8.RuntimeCall announce({
    required real,
    required callHash,
  }) {
    final _call = _i9.Call.values.announce(
      real: real,
      callHash: callHash,
    );
    return _i8.RuntimeCall.values.proxy(_call);
  }

  /// Remove a given announcement.
  ///
  /// May be called by a proxy account to remove a call they previously announced and return
  /// the deposit.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// Parameters:
  /// - `real`: The account that the proxy will make a call on behalf of.
  /// - `call_hash`: The hash of the call to be made by the `real` account.
  _i8.RuntimeCall removeAnnouncement({
    required real,
    required callHash,
  }) {
    final _call = _i9.Call.values.removeAnnouncement(
      real: real,
      callHash: callHash,
    );
    return _i8.RuntimeCall.values.proxy(_call);
  }

  /// Remove the given announcement of a delegate.
  ///
  /// May be called by a target (proxied) account to remove a call that one of their delegates
  /// (`delegate`) has announced they want to execute. The deposit is returned.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// Parameters:
  /// - `delegate`: The account that previously announced the call.
  /// - `call_hash`: The hash of the call to be made.
  _i8.RuntimeCall rejectAnnouncement({
    required delegate,
    required callHash,
  }) {
    final _call = _i9.Call.values.rejectAnnouncement(
      delegate: delegate,
      callHash: callHash,
    );
    return _i8.RuntimeCall.values.proxy(_call);
  }

  /// Dispatch the given `call` from an account that the sender is authorized for through
  /// `add_proxy`.
  ///
  /// Removes any corresponding announcement(s).
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// Parameters:
  /// - `real`: The account that the proxy will make a call on behalf of.
  /// - `force_proxy_type`: Specify the exact proxy type to be used and checked for this call.
  /// - `call`: The call to be made by the `real` account.
  _i8.RuntimeCall proxyAnnounced({
    required delegate,
    required real,
    forceProxyType,
    required call,
  }) {
    final _call = _i9.Call.values.proxyAnnounced(
      delegate: delegate,
      real: real,
      forceProxyType: forceProxyType,
      call: call,
    );
    return _i8.RuntimeCall.values.proxy(_call);
  }
}

class Constants {
  Constants();

  /// The base amount of currency needed to reserve for creating a proxy.
  ///
  /// This is held for an additional storage item whose value size is
  /// `sizeof(Balance)` bytes and whose key size is `sizeof(AccountId)` bytes.
  final BigInt proxyDepositBase = BigInt.from(200080000000);

  /// The amount of currency needed per proxy added.
  ///
  /// This is held for adding 32 bytes plus an instance of `ProxyType` more into a
  /// pre-existing storage value. Thus, when configuring `ProxyDepositFactor` one should take
  /// into account `32 + proxy_type.encode().len()` bytes of data.
  final BigInt proxyDepositFactor = BigInt.from(330000000);

  /// The maximum amount of proxies allowed for a single account.
  final int maxProxies = 32;

  /// The maximum amount of time-delayed announcements that are allowed to be pending.
  final int maxPending = 32;

  /// The base amount of currency needed to reserve for creating an announcement.
  ///
  /// This is held when a new storage item holding a `Balance` is created (typically 16
  /// bytes).
  final BigInt announcementDepositBase = BigInt.from(200080000000);

  /// The amount of currency needed per announcement made.
  ///
  /// This is held for adding an `AccountId`, `Hash` and `BlockNumber` (typically 68 bytes)
  /// into a pre-existing storage value.
  final BigInt announcementDepositFactor = BigInt.from(660000000);
}
