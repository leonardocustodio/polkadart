// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../polkadot_runtime/proxy_type.dart' as _i4;
import '../../polkadot_runtime/runtime_call.dart' as _i5;
import '../../primitive_types/h256.dart' as _i6;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  Proxy proxy({
    required _i3.MultiAddress real,
    _i4.ProxyType? forceProxyType,
    required _i5.RuntimeCall call,
  }) {
    return Proxy(
      real: real,
      forceProxyType: forceProxyType,
      call: call,
    );
  }

  AddProxy addProxy({
    required _i3.MultiAddress delegate,
    required _i4.ProxyType proxyType,
    required int delay,
  }) {
    return AddProxy(
      delegate: delegate,
      proxyType: proxyType,
      delay: delay,
    );
  }

  RemoveProxy removeProxy({
    required _i3.MultiAddress delegate,
    required _i4.ProxyType proxyType,
    required int delay,
  }) {
    return RemoveProxy(
      delegate: delegate,
      proxyType: proxyType,
      delay: delay,
    );
  }

  RemoveProxies removeProxies() {
    return RemoveProxies();
  }

  CreatePure createPure({
    required _i4.ProxyType proxyType,
    required int delay,
    required int index,
  }) {
    return CreatePure(
      proxyType: proxyType,
      delay: delay,
      index: index,
    );
  }

  KillPure killPure({
    required _i3.MultiAddress spawner,
    required _i4.ProxyType proxyType,
    required int index,
    required BigInt height,
    required BigInt extIndex,
  }) {
    return KillPure(
      spawner: spawner,
      proxyType: proxyType,
      index: index,
      height: height,
      extIndex: extIndex,
    );
  }

  Announce announce({
    required _i3.MultiAddress real,
    required _i6.H256 callHash,
  }) {
    return Announce(
      real: real,
      callHash: callHash,
    );
  }

  RemoveAnnouncement removeAnnouncement({
    required _i3.MultiAddress real,
    required _i6.H256 callHash,
  }) {
    return RemoveAnnouncement(
      real: real,
      callHash: callHash,
    );
  }

  RejectAnnouncement rejectAnnouncement({
    required _i3.MultiAddress delegate,
    required _i6.H256 callHash,
  }) {
    return RejectAnnouncement(
      delegate: delegate,
      callHash: callHash,
    );
  }

  ProxyAnnounced proxyAnnounced({
    required _i3.MultiAddress delegate,
    required _i3.MultiAddress real,
    _i4.ProxyType? forceProxyType,
    required _i5.RuntimeCall call,
  }) {
    return ProxyAnnounced(
      delegate: delegate,
      real: real,
      forceProxyType: forceProxyType,
      call: call,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Proxy._decode(input);
      case 1:
        return AddProxy._decode(input);
      case 2:
        return RemoveProxy._decode(input);
      case 3:
        return const RemoveProxies();
      case 4:
        return CreatePure._decode(input);
      case 5:
        return KillPure._decode(input);
      case 6:
        return Announce._decode(input);
      case 7:
        return RemoveAnnouncement._decode(input);
      case 8:
        return RejectAnnouncement._decode(input);
      case 9:
        return ProxyAnnounced._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Proxy:
        (value as Proxy).encodeTo(output);
        break;
      case AddProxy:
        (value as AddProxy).encodeTo(output);
        break;
      case RemoveProxy:
        (value as RemoveProxy).encodeTo(output);
        break;
      case RemoveProxies:
        (value as RemoveProxies).encodeTo(output);
        break;
      case CreatePure:
        (value as CreatePure).encodeTo(output);
        break;
      case KillPure:
        (value as KillPure).encodeTo(output);
        break;
      case Announce:
        (value as Announce).encodeTo(output);
        break;
      case RemoveAnnouncement:
        (value as RemoveAnnouncement).encodeTo(output);
        break;
      case RejectAnnouncement:
        (value as RejectAnnouncement).encodeTo(output);
        break;
      case ProxyAnnounced:
        (value as ProxyAnnounced).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Proxy:
        return (value as Proxy)._sizeHint();
      case AddProxy:
        return (value as AddProxy)._sizeHint();
      case RemoveProxy:
        return (value as RemoveProxy)._sizeHint();
      case RemoveProxies:
        return 1;
      case CreatePure:
        return (value as CreatePure)._sizeHint();
      case KillPure:
        return (value as KillPure)._sizeHint();
      case Announce:
        return (value as Announce)._sizeHint();
      case RemoveAnnouncement:
        return (value as RemoveAnnouncement)._sizeHint();
      case RejectAnnouncement:
        return (value as RejectAnnouncement)._sizeHint();
      case ProxyAnnounced:
        return (value as ProxyAnnounced)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Dispatch the given `call` from an account that the sender is authorised for through
/// `add_proxy`.
///
/// The dispatch origin for this call must be _Signed_.
///
/// Parameters:
/// - `real`: The account that the proxy will make a call on behalf of.
/// - `force_proxy_type`: Specify the exact proxy type to be used and checked for this call.
/// - `call`: The call to be made by the `real` account.
class Proxy extends Call {
  const Proxy({
    required this.real,
    this.forceProxyType,
    required this.call,
  });

  factory Proxy._decode(_i1.Input input) {
    return Proxy(
      real: _i3.MultiAddress.codec.decode(input),
      forceProxyType: const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec)
          .decode(input),
      call: _i5.RuntimeCall.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress real;

  /// Option<T::ProxyType>
  final _i4.ProxyType? forceProxyType;

  /// Box<<T as Config>::RuntimeCall>
  final _i5.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'proxy': {
          'real': real.toJson(),
          'forceProxyType': forceProxyType?.toJson(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size +
        const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec)
            .sizeHint(forceProxyType);
    size = size + _i5.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      real,
      output,
    );
    const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec).encodeTo(
      forceProxyType,
      output,
    );
    _i5.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Proxy &&
          other.real == real &&
          other.forceProxyType == forceProxyType &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        real,
        forceProxyType,
        call,
      );
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
class AddProxy extends Call {
  const AddProxy({
    required this.delegate,
    required this.proxyType,
    required this.delay,
  });

  factory AddProxy._decode(_i1.Input input) {
    return AddProxy(
      delegate: _i3.MultiAddress.codec.decode(input),
      proxyType: _i4.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress delegate;

  /// T::ProxyType
  final _i4.ProxyType proxyType;

  /// BlockNumberFor<T>
  final int delay;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'add_proxy': {
          'delegate': delegate.toJson(),
          'proxyType': proxyType.toJson(),
          'delay': delay,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + _i4.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    _i4.ProxyType.codec.encodeTo(
      proxyType,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      delay,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddProxy &&
          other.delegate == delegate &&
          other.proxyType == proxyType &&
          other.delay == delay;

  @override
  int get hashCode => Object.hash(
        delegate,
        proxyType,
        delay,
      );
}

/// Unregister a proxy account for the sender.
///
/// The dispatch origin for this call must be _Signed_.
///
/// Parameters:
/// - `proxy`: The account that the `caller` would like to remove as a proxy.
/// - `proxy_type`: The permissions currently enabled for the removed proxy account.
class RemoveProxy extends Call {
  const RemoveProxy({
    required this.delegate,
    required this.proxyType,
    required this.delay,
  });

  factory RemoveProxy._decode(_i1.Input input) {
    return RemoveProxy(
      delegate: _i3.MultiAddress.codec.decode(input),
      proxyType: _i4.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress delegate;

  /// T::ProxyType
  final _i4.ProxyType proxyType;

  /// BlockNumberFor<T>
  final int delay;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remove_proxy': {
          'delegate': delegate.toJson(),
          'proxyType': proxyType.toJson(),
          'delay': delay,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + _i4.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    _i4.ProxyType.codec.encodeTo(
      proxyType,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      delay,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveProxy &&
          other.delegate == delegate &&
          other.proxyType == proxyType &&
          other.delay == delay;

  @override
  int get hashCode => Object.hash(
        delegate,
        proxyType,
        delay,
      );
}

/// Unregister all proxy accounts for the sender.
///
/// The dispatch origin for this call must be _Signed_.
///
/// WARNING: This may be called on accounts created by `pure`, however if done, then
/// the unreserved fees will be inaccessible. **All access to this account will be lost.**
class RemoveProxies extends Call {
  const RemoveProxies();

  @override
  Map<String, dynamic> toJson() => {'remove_proxies': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is RemoveProxies;

  @override
  int get hashCode => runtimeType.hashCode;
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
class CreatePure extends Call {
  const CreatePure({
    required this.proxyType,
    required this.delay,
    required this.index,
  });

  factory CreatePure._decode(_i1.Input input) {
    return CreatePure(
      proxyType: _i4.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
      index: _i1.U16Codec.codec.decode(input),
    );
  }

  /// T::ProxyType
  final _i4.ProxyType proxyType;

  /// BlockNumberFor<T>
  final int delay;

  /// u16
  final int index;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create_pure': {
          'proxyType': proxyType.toJson(),
          'delay': delay,
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    size = size + _i1.U16Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i4.ProxyType.codec.encodeTo(
      proxyType,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      delay,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CreatePure &&
          other.proxyType == proxyType &&
          other.delay == delay &&
          other.index == index;

  @override
  int get hashCode => Object.hash(
        proxyType,
        delay,
        index,
      );
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
class KillPure extends Call {
  const KillPure({
    required this.spawner,
    required this.proxyType,
    required this.index,
    required this.height,
    required this.extIndex,
  });

  factory KillPure._decode(_i1.Input input) {
    return KillPure(
      spawner: _i3.MultiAddress.codec.decode(input),
      proxyType: _i4.ProxyType.codec.decode(input),
      index: _i1.U16Codec.codec.decode(input),
      height: _i1.CompactBigIntCodec.codec.decode(input),
      extIndex: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress spawner;

  /// T::ProxyType
  final _i4.ProxyType proxyType;

  /// u16
  final int index;

  /// BlockNumberFor<T>
  final BigInt height;

  /// u32
  final BigInt extIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'kill_pure': {
          'spawner': spawner.toJson(),
          'proxyType': proxyType.toJson(),
          'index': index,
          'height': height,
          'extIndex': extIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(spawner);
    size = size + _i4.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U16Codec.codec.sizeHint(index);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(height);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(extIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      spawner,
      output,
    );
    _i4.ProxyType.codec.encodeTo(
      proxyType,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      index,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      height,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      extIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is KillPure &&
          other.spawner == spawner &&
          other.proxyType == proxyType &&
          other.index == index &&
          other.height == height &&
          other.extIndex == extIndex;

  @override
  int get hashCode => Object.hash(
        spawner,
        proxyType,
        index,
        height,
        extIndex,
      );
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
class Announce extends Call {
  const Announce({
    required this.real,
    required this.callHash,
  });

  factory Announce._decode(_i1.Input input) {
    return Announce(
      real: _i3.MultiAddress.codec.decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress real;

  /// CallHashOf<T>
  final _i6.H256 callHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'announce': {
          'real': real.toJson(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size + const _i6.H256Codec().sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      real,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Announce &&
          other.real == real &&
          _i7.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => Object.hash(
        real,
        callHash,
      );
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
class RemoveAnnouncement extends Call {
  const RemoveAnnouncement({
    required this.real,
    required this.callHash,
  });

  factory RemoveAnnouncement._decode(_i1.Input input) {
    return RemoveAnnouncement(
      real: _i3.MultiAddress.codec.decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress real;

  /// CallHashOf<T>
  final _i6.H256 callHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remove_announcement': {
          'real': real.toJson(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size + const _i6.H256Codec().sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      real,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveAnnouncement &&
          other.real == real &&
          _i7.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => Object.hash(
        real,
        callHash,
      );
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
class RejectAnnouncement extends Call {
  const RejectAnnouncement({
    required this.delegate,
    required this.callHash,
  });

  factory RejectAnnouncement._decode(_i1.Input input) {
    return RejectAnnouncement(
      delegate: _i3.MultiAddress.codec.decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress delegate;

  /// CallHashOf<T>
  final _i6.H256 callHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'reject_announcement': {
          'delegate': delegate.toJson(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + const _i6.H256Codec().sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RejectAnnouncement &&
          other.delegate == delegate &&
          _i7.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => Object.hash(
        delegate,
        callHash,
      );
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
class ProxyAnnounced extends Call {
  const ProxyAnnounced({
    required this.delegate,
    required this.real,
    this.forceProxyType,
    required this.call,
  });

  factory ProxyAnnounced._decode(_i1.Input input) {
    return ProxyAnnounced(
      delegate: _i3.MultiAddress.codec.decode(input),
      real: _i3.MultiAddress.codec.decode(input),
      forceProxyType: const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec)
          .decode(input),
      call: _i5.RuntimeCall.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress delegate;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress real;

  /// Option<T::ProxyType>
  final _i4.ProxyType? forceProxyType;

  /// Box<<T as Config>::RuntimeCall>
  final _i5.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'proxy_announced': {
          'delegate': delegate.toJson(),
          'real': real.toJson(),
          'forceProxyType': forceProxyType?.toJson(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(delegate);
    size = size + _i3.MultiAddress.codec.sizeHint(real);
    size = size +
        const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec)
            .sizeHint(forceProxyType);
    size = size + _i5.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      delegate,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      real,
      output,
    );
    const _i1.OptionCodec<_i4.ProxyType>(_i4.ProxyType.codec).encodeTo(
      forceProxyType,
      output,
    );
    _i5.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ProxyAnnounced &&
          other.delegate == delegate &&
          other.real == real &&
          other.forceProxyType == forceProxyType &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        delegate,
        real,
        forceProxyType,
        call,
      );
}
