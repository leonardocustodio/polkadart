// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../body_id.dart' as _i4;
import '../body_part.dart' as _i5;
import '../network_id.dart' as _i3;

abstract class Junction {
  const Junction();

  factory Junction.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $JunctionCodec codec = $JunctionCodec();

  static const $Junction values = $Junction();

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

class $Junction {
  const $Junction();

  Parachain parachain(BigInt value0) {
    return Parachain(value0);
  }

  AccountId32 accountId32({
    required _i3.NetworkId network,
    required List<int> id,
  }) {
    return AccountId32(
      network: network,
      id: id,
    );
  }

  AccountIndex64 accountIndex64({
    required _i3.NetworkId network,
    required BigInt index,
  }) {
    return AccountIndex64(
      network: network,
      index: index,
    );
  }

  AccountKey20 accountKey20({
    required _i3.NetworkId network,
    required List<int> key,
  }) {
    return AccountKey20(
      network: network,
      key: key,
    );
  }

  PalletInstance palletInstance(int value0) {
    return PalletInstance(value0);
  }

  GeneralIndex generalIndex(BigInt value0) {
    return GeneralIndex(value0);
  }

  GeneralKey generalKey(List<int> value0) {
    return GeneralKey(value0);
  }

  OnlyChild onlyChild() {
    return OnlyChild();
  }

  Plurality plurality({
    required _i4.BodyId id,
    required _i5.BodyPart part,
  }) {
    return Plurality(
      id: id,
      part: part,
    );
  }
}

class $JunctionCodec with _i1.Codec<Junction> {
  const $JunctionCodec();

  @override
  Junction decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Parachain._decode(input);
      case 1:
        return AccountId32._decode(input);
      case 2:
        return AccountIndex64._decode(input);
      case 3:
        return AccountKey20._decode(input);
      case 4:
        return PalletInstance._decode(input);
      case 5:
        return GeneralIndex._decode(input);
      case 6:
        return GeneralKey._decode(input);
      case 7:
        return const OnlyChild();
      case 8:
        return Plurality._decode(input);
      default:
        throw Exception('Junction: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Junction value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Parachain:
        (value as Parachain).encodeTo(output);
        break;
      case AccountId32:
        (value as AccountId32).encodeTo(output);
        break;
      case AccountIndex64:
        (value as AccountIndex64).encodeTo(output);
        break;
      case AccountKey20:
        (value as AccountKey20).encodeTo(output);
        break;
      case PalletInstance:
        (value as PalletInstance).encodeTo(output);
        break;
      case GeneralIndex:
        (value as GeneralIndex).encodeTo(output);
        break;
      case GeneralKey:
        (value as GeneralKey).encodeTo(output);
        break;
      case OnlyChild:
        (value as OnlyChild).encodeTo(output);
        break;
      case Plurality:
        (value as Plurality).encodeTo(output);
        break;
      default:
        throw Exception(
            'Junction: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Junction value) {
    switch (value.runtimeType) {
      case Parachain:
        return (value as Parachain)._sizeHint();
      case AccountId32:
        return (value as AccountId32)._sizeHint();
      case AccountIndex64:
        return (value as AccountIndex64)._sizeHint();
      case AccountKey20:
        return (value as AccountKey20)._sizeHint();
      case PalletInstance:
        return (value as PalletInstance)._sizeHint();
      case GeneralIndex:
        return (value as GeneralIndex)._sizeHint();
      case GeneralKey:
        return (value as GeneralKey)._sizeHint();
      case OnlyChild:
        return 1;
      case Plurality:
        return (value as Plurality)._sizeHint();
      default:
        throw Exception(
            'Junction: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Parachain extends Junction {
  const Parachain(this.value0);

  factory Parachain._decode(_i1.Input input) {
    return Parachain(_i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u32
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'Parachain': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
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
      other is Parachain && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class AccountId32 extends Junction {
  const AccountId32({
    required this.network,
    required this.id,
  });

  factory AccountId32._decode(_i1.Input input) {
    return AccountId32(
      network: _i3.NetworkId.codec.decode(input),
      id: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// NetworkId
  final _i3.NetworkId network;

  /// [u8; 32]
  final List<int> id;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AccountId32': {
          'network': network.toJson(),
          'id': id.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.NetworkId.codec.sizeHint(network);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.NetworkId.codec.encodeTo(
      network,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AccountId32 &&
          other.network == network &&
          _i6.listsEqual(
            other.id,
            id,
          );

  @override
  int get hashCode => Object.hash(
        network,
        id,
      );
}

class AccountIndex64 extends Junction {
  const AccountIndex64({
    required this.network,
    required this.index,
  });

  factory AccountIndex64._decode(_i1.Input input) {
    return AccountIndex64(
      network: _i3.NetworkId.codec.decode(input),
      index: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// NetworkId
  final _i3.NetworkId network;

  /// u64
  final BigInt index;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AccountIndex64': {
          'network': network.toJson(),
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.NetworkId.codec.sizeHint(network);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.NetworkId.codec.encodeTo(
      network,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
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
      other is AccountIndex64 &&
          other.network == network &&
          other.index == index;

  @override
  int get hashCode => Object.hash(
        network,
        index,
      );
}

class AccountKey20 extends Junction {
  const AccountKey20({
    required this.network,
    required this.key,
  });

  factory AccountKey20._decode(_i1.Input input) {
    return AccountKey20(
      network: _i3.NetworkId.codec.decode(input),
      key: const _i1.U8ArrayCodec(20).decode(input),
    );
  }

  /// NetworkId
  final _i3.NetworkId network;

  /// [u8; 20]
  final List<int> key;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AccountKey20': {
          'network': network.toJson(),
          'key': key.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.NetworkId.codec.sizeHint(network);
    size = size + const _i1.U8ArrayCodec(20).sizeHint(key);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.NetworkId.codec.encodeTo(
      network,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      key,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AccountKey20 &&
          other.network == network &&
          _i6.listsEqual(
            other.key,
            key,
          );

  @override
  int get hashCode => Object.hash(
        network,
        key,
      );
}

class PalletInstance extends Junction {
  const PalletInstance(this.value0);

  factory PalletInstance._decode(_i1.Input input) {
    return PalletInstance(_i1.U8Codec.codec.decode(input));
  }

  /// u8
  final int value0;

  @override
  Map<String, int> toJson() => {'PalletInstance': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
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
      other is PalletInstance && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class GeneralIndex extends Junction {
  const GeneralIndex(this.value0);

  factory GeneralIndex._decode(_i1.Input input) {
    return GeneralIndex(_i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u128
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'GeneralIndex': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
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
      other is GeneralIndex && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class GeneralKey extends Junction {
  const GeneralKey(this.value0);

  factory GeneralKey._decode(_i1.Input input) {
    return GeneralKey(_i1.U8SequenceCodec.codec.decode(input));
  }

  /// WeakBoundedVec<u8, ConstU32<32>>
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'GeneralKey': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
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
      other is GeneralKey &&
          _i6.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class OnlyChild extends Junction {
  const OnlyChild();

  @override
  Map<String, dynamic> toJson() => {'OnlyChild': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is OnlyChild;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Plurality extends Junction {
  const Plurality({
    required this.id,
    required this.part,
  });

  factory Plurality._decode(_i1.Input input) {
    return Plurality(
      id: _i4.BodyId.codec.decode(input),
      part: _i5.BodyPart.codec.decode(input),
    );
  }

  /// BodyId
  final _i4.BodyId id;

  /// BodyPart
  final _i5.BodyPart part;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'Plurality': {
          'id': id.toJson(),
          'part': part.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.BodyId.codec.sizeHint(id);
    size = size + _i5.BodyPart.codec.sizeHint(part);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i4.BodyId.codec.encodeTo(
      id,
      output,
    );
    _i5.BodyPart.codec.encodeTo(
      part,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Plurality && other.id == id && other.part == part;

  @override
  int get hashCode => Object.hash(
        id,
        part,
      );
}
