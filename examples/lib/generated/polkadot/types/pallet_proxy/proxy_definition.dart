// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../polkadot_runtime/proxy_type.dart' as _i3;
import '../sp_core/crypto/account_id32.dart' as _i2;

class ProxyDefinition {
  const ProxyDefinition({
    required this.delegate,
    required this.proxyType,
    required this.delay,
  });

  factory ProxyDefinition.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 delegate;

  /// ProxyType
  final _i3.ProxyType proxyType;

  /// BlockNumber
  final int delay;

  static const $ProxyDefinitionCodec codec = $ProxyDefinitionCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'delegate': delegate.toList(),
        'proxyType': proxyType.toJson(),
        'delay': delay,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ProxyDefinition &&
          _i5.listsEqual(
            other.delegate,
            delegate,
          ) &&
          other.proxyType == proxyType &&
          other.delay == delay;

  @override
  int get hashCode => Object.hash(
        delegate,
        proxyType,
        delay,
      );
}

class $ProxyDefinitionCodec with _i1.Codec<ProxyDefinition> {
  const $ProxyDefinitionCodec();

  @override
  void encodeTo(
    ProxyDefinition obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.delegate,
      output,
    );
    _i3.ProxyType.codec.encodeTo(
      obj.proxyType,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.delay,
      output,
    );
  }

  @override
  ProxyDefinition decode(_i1.Input input) {
    return ProxyDefinition(
      delegate: const _i1.U8ArrayCodec(32).decode(input),
      proxyType: _i3.ProxyType.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ProxyDefinition obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.delegate);
    size = size + _i3.ProxyType.codec.sizeHint(obj.proxyType);
    size = size + _i1.U32Codec.codec.sizeHint(obj.delay);
    return size;
  }
}
