// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../polkadot_runtime/proxy_type.dart' as _i5;
import '../../primitive_types/h256.dart' as _i6;
import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../sp_runtime/dispatch_error.dart' as _i3;

///
///			The [event](https://docs.substrate.io/main-docs/build/events-errors/) emitted
///			by this pallet.
///
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  ProxyExecuted proxyExecuted(
      {required _i1.Result<dynamic, _i3.DispatchError> result}) {
    return ProxyExecuted(result: result);
  }

  PureCreated pureCreated({
    required _i4.AccountId32 pure,
    required _i4.AccountId32 who,
    required _i5.ProxyType proxyType,
    required int disambiguationIndex,
  }) {
    return PureCreated(
      pure: pure,
      who: who,
      proxyType: proxyType,
      disambiguationIndex: disambiguationIndex,
    );
  }

  Announced announced({
    required _i4.AccountId32 real,
    required _i4.AccountId32 proxy,
    required _i6.H256 callHash,
  }) {
    return Announced(
      real: real,
      proxy: proxy,
      callHash: callHash,
    );
  }

  ProxyAdded proxyAdded({
    required _i4.AccountId32 delegator,
    required _i4.AccountId32 delegatee,
    required _i5.ProxyType proxyType,
    required int delay,
  }) {
    return ProxyAdded(
      delegator: delegator,
      delegatee: delegatee,
      proxyType: proxyType,
      delay: delay,
    );
  }

  ProxyRemoved proxyRemoved({
    required _i4.AccountId32 delegator,
    required _i4.AccountId32 delegatee,
    required _i5.ProxyType proxyType,
    required int delay,
  }) {
    return ProxyRemoved(
      delegator: delegator,
      delegatee: delegatee,
      proxyType: proxyType,
      delay: delay,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ProxyExecuted._decode(input);
      case 1:
        return PureCreated._decode(input);
      case 2:
        return Announced._decode(input);
      case 3:
        return ProxyAdded._decode(input);
      case 4:
        return ProxyRemoved._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case ProxyExecuted:
        (value as ProxyExecuted).encodeTo(output);
        break;
      case PureCreated:
        (value as PureCreated).encodeTo(output);
        break;
      case Announced:
        (value as Announced).encodeTo(output);
        break;
      case ProxyAdded:
        (value as ProxyAdded).encodeTo(output);
        break;
      case ProxyRemoved:
        (value as ProxyRemoved).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case ProxyExecuted:
        return (value as ProxyExecuted)._sizeHint();
      case PureCreated:
        return (value as PureCreated)._sizeHint();
      case Announced:
        return (value as Announced)._sizeHint();
      case ProxyAdded:
        return (value as ProxyAdded)._sizeHint();
      case ProxyRemoved:
        return (value as ProxyRemoved)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A proxy was executed correctly, with the given.
class ProxyExecuted extends Event {
  const ProxyExecuted({required this.result});

  factory ProxyExecuted._decode(_i1.Input input) {
    return ProxyExecuted(
        result: const _i1.ResultCodec<dynamic, _i3.DispatchError>(
      _i1.NullCodec.codec,
      _i3.DispatchError.codec,
    ).decode(input));
  }

  /// DispatchResult
  final _i1.Result<dynamic, _i3.DispatchError> result;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'ProxyExecuted': {'result': result.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.ResultCodec<dynamic, _i3.DispatchError>(
          _i1.NullCodec.codec,
          _i3.DispatchError.codec,
        ).sizeHint(result);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.ResultCodec<dynamic, _i3.DispatchError>(
      _i1.NullCodec.codec,
      _i3.DispatchError.codec,
    ).encodeTo(
      result,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ProxyExecuted && other.result == result;

  @override
  int get hashCode => result.hashCode;
}

/// A pure account has been created by new proxy with given
/// disambiguation index and proxy type.
class PureCreated extends Event {
  const PureCreated({
    required this.pure,
    required this.who,
    required this.proxyType,
    required this.disambiguationIndex,
  });

  factory PureCreated._decode(_i1.Input input) {
    return PureCreated(
      pure: const _i1.U8ArrayCodec(32).decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      proxyType: _i5.ProxyType.codec.decode(input),
      disambiguationIndex: _i1.U16Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 pure;

  /// T::AccountId
  final _i4.AccountId32 who;

  /// T::ProxyType
  final _i5.ProxyType proxyType;

  /// u16
  final int disambiguationIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PureCreated': {
          'pure': pure.toList(),
          'who': who.toList(),
          'proxyType': proxyType.toJson(),
          'disambiguationIndex': disambiguationIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(pure);
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + _i5.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U16Codec.codec.sizeHint(disambiguationIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      pure,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i5.ProxyType.codec.encodeTo(
      proxyType,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      disambiguationIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PureCreated &&
          _i7.listsEqual(
            other.pure,
            pure,
          ) &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          other.proxyType == proxyType &&
          other.disambiguationIndex == disambiguationIndex;

  @override
  int get hashCode => Object.hash(
        pure,
        who,
        proxyType,
        disambiguationIndex,
      );
}

/// An announcement was placed to make a call in the future.
class Announced extends Event {
  const Announced({
    required this.real,
    required this.proxy,
    required this.callHash,
  });

  factory Announced._decode(_i1.Input input) {
    return Announced(
      real: const _i1.U8ArrayCodec(32).decode(input),
      proxy: const _i1.U8ArrayCodec(32).decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 real;

  /// T::AccountId
  final _i4.AccountId32 proxy;

  /// CallHashOf<T>
  final _i6.H256 callHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Announced': {
          'real': real.toList(),
          'proxy': proxy.toList(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(real);
    size = size + const _i4.AccountId32Codec().sizeHint(proxy);
    size = size + const _i6.H256Codec().sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      real,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proxy,
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
      other is Announced &&
          _i7.listsEqual(
            other.real,
            real,
          ) &&
          _i7.listsEqual(
            other.proxy,
            proxy,
          ) &&
          _i7.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => Object.hash(
        real,
        proxy,
        callHash,
      );
}

/// A proxy was added.
class ProxyAdded extends Event {
  const ProxyAdded({
    required this.delegator,
    required this.delegatee,
    required this.proxyType,
    required this.delay,
  });

  factory ProxyAdded._decode(_i1.Input input) {
    return ProxyAdded(
      delegator: const _i1.U8ArrayCodec(32).decode(input),
      delegatee: const _i1.U8ArrayCodec(32).decode(input),
      proxyType: _i5.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 delegator;

  /// T::AccountId
  final _i4.AccountId32 delegatee;

  /// T::ProxyType
  final _i5.ProxyType proxyType;

  /// T::BlockNumber
  final int delay;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ProxyAdded': {
          'delegator': delegator.toList(),
          'delegatee': delegatee.toList(),
          'proxyType': proxyType.toJson(),
          'delay': delay,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(delegator);
    size = size + const _i4.AccountId32Codec().sizeHint(delegatee);
    size = size + _i5.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegator,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegatee,
      output,
    );
    _i5.ProxyType.codec.encodeTo(
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
      other is ProxyAdded &&
          _i7.listsEqual(
            other.delegator,
            delegator,
          ) &&
          _i7.listsEqual(
            other.delegatee,
            delegatee,
          ) &&
          other.proxyType == proxyType &&
          other.delay == delay;

  @override
  int get hashCode => Object.hash(
        delegator,
        delegatee,
        proxyType,
        delay,
      );
}

/// A proxy was removed.
class ProxyRemoved extends Event {
  const ProxyRemoved({
    required this.delegator,
    required this.delegatee,
    required this.proxyType,
    required this.delay,
  });

  factory ProxyRemoved._decode(_i1.Input input) {
    return ProxyRemoved(
      delegator: const _i1.U8ArrayCodec(32).decode(input),
      delegatee: const _i1.U8ArrayCodec(32).decode(input),
      proxyType: _i5.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 delegator;

  /// T::AccountId
  final _i4.AccountId32 delegatee;

  /// T::ProxyType
  final _i5.ProxyType proxyType;

  /// T::BlockNumber
  final int delay;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ProxyRemoved': {
          'delegator': delegator.toList(),
          'delegatee': delegatee.toList(),
          'proxyType': proxyType.toJson(),
          'delay': delay,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(delegator);
    size = size + const _i4.AccountId32Codec().sizeHint(delegatee);
    size = size + _i5.ProxyType.codec.sizeHint(proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegator,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      delegatee,
      output,
    );
    _i5.ProxyType.codec.encodeTo(
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
      other is ProxyRemoved &&
          _i7.listsEqual(
            other.delegator,
            delegator,
          ) &&
          _i7.listsEqual(
            other.delegatee,
            delegatee,
          ) &&
          other.proxyType == proxyType &&
          other.delay == delay;

  @override
  int get hashCode => Object.hash(
        delegator,
        delegatee,
        proxyType,
        delay,
      );
}
