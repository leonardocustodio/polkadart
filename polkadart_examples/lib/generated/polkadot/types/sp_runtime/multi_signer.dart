// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../sp_core/ecdsa/public.dart' as _i5;
import '../sp_core/ed25519/public.dart' as _i3;
import '../sp_core/sr25519/public.dart' as _i4;

abstract class MultiSigner {
  const MultiSigner();

  factory MultiSigner.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $MultiSignerCodec codec = $MultiSignerCodec();

  static const $MultiSigner values = $MultiSigner();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, List<int>> toJson();
}

class $MultiSigner {
  const $MultiSigner();

  Ed25519 ed25519(_i3.Public value0) {
    return Ed25519(value0);
  }

  Sr25519 sr25519(_i4.Public value0) {
    return Sr25519(value0);
  }

  Ecdsa ecdsa(_i5.Public value0) {
    return Ecdsa(value0);
  }
}

class $MultiSignerCodec with _i1.Codec<MultiSigner> {
  const $MultiSignerCodec();

  @override
  MultiSigner decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Ed25519._decode(input);
      case 1:
        return Sr25519._decode(input);
      case 2:
        return Ecdsa._decode(input);
      default:
        throw Exception('MultiSigner: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    MultiSigner value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Ed25519:
        (value as Ed25519).encodeTo(output);
        break;
      case Sr25519:
        (value as Sr25519).encodeTo(output);
        break;
      case Ecdsa:
        (value as Ecdsa).encodeTo(output);
        break;
      default:
        throw Exception(
            'MultiSigner: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(MultiSigner value) {
    switch (value.runtimeType) {
      case Ed25519:
        return (value as Ed25519)._sizeHint();
      case Sr25519:
        return (value as Sr25519)._sizeHint();
      case Ecdsa:
        return (value as Ecdsa)._sizeHint();
      default:
        throw Exception(
            'MultiSigner: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Ed25519 extends MultiSigner {
  const Ed25519(this.value0);

  factory Ed25519._decode(_i1.Input input) {
    return Ed25519(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// ed25519::Public
  final _i3.Public value0;

  @override
  Map<String, List<int>> toJson() => {'Ed25519': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.PublicCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Ed25519 &&
          _i6.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Sr25519 extends MultiSigner {
  const Sr25519(this.value0);

  factory Sr25519._decode(_i1.Input input) {
    return Sr25519(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// sr25519::Public
  final _i4.Public value0;

  @override
  Map<String, List<int>> toJson() => {'Sr25519': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.PublicCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Sr25519 &&
          _i6.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Ecdsa extends MultiSigner {
  const Ecdsa(this.value0);

  factory Ecdsa._decode(_i1.Input input) {
    return Ecdsa(const _i1.U8ArrayCodec(33).decode(input));
  }

  /// ecdsa::Public
  final _i5.Public value0;

  @override
  Map<String, List<int>> toJson() => {'Ecdsa': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.PublicCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(33).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Ecdsa &&
          _i6.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}
