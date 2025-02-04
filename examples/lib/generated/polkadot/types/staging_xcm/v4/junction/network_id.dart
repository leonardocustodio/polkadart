// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

abstract class NetworkId {
  const NetworkId();

  factory NetworkId.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $NetworkIdCodec codec = $NetworkIdCodec();

  static const $NetworkId values = $NetworkId();

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

class $NetworkId {
  const $NetworkId();

  ByGenesis byGenesis(List<int> value0) {
    return ByGenesis(value0);
  }

  ByFork byFork({
    required BigInt blockNumber,
    required List<int> blockHash,
  }) {
    return ByFork(
      blockNumber: blockNumber,
      blockHash: blockHash,
    );
  }

  Polkadot polkadot() {
    return Polkadot();
  }

  Kusama kusama() {
    return Kusama();
  }

  Westend westend() {
    return Westend();
  }

  Rococo rococo() {
    return Rococo();
  }

  Wococo wococo() {
    return Wococo();
  }

  Ethereum ethereum({required BigInt chainId}) {
    return Ethereum(chainId: chainId);
  }

  BitcoinCore bitcoinCore() {
    return BitcoinCore();
  }

  BitcoinCash bitcoinCash() {
    return BitcoinCash();
  }

  PolkadotBulletin polkadotBulletin() {
    return PolkadotBulletin();
  }
}

class $NetworkIdCodec with _i1.Codec<NetworkId> {
  const $NetworkIdCodec();

  @override
  NetworkId decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ByGenesis._decode(input);
      case 1:
        return ByFork._decode(input);
      case 2:
        return const Polkadot();
      case 3:
        return const Kusama();
      case 4:
        return const Westend();
      case 5:
        return const Rococo();
      case 6:
        return const Wococo();
      case 7:
        return Ethereum._decode(input);
      case 8:
        return const BitcoinCore();
      case 9:
        return const BitcoinCash();
      case 10:
        return const PolkadotBulletin();
      default:
        throw Exception('NetworkId: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    NetworkId value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case ByGenesis:
        (value as ByGenesis).encodeTo(output);
        break;
      case ByFork:
        (value as ByFork).encodeTo(output);
        break;
      case Polkadot:
        (value as Polkadot).encodeTo(output);
        break;
      case Kusama:
        (value as Kusama).encodeTo(output);
        break;
      case Westend:
        (value as Westend).encodeTo(output);
        break;
      case Rococo:
        (value as Rococo).encodeTo(output);
        break;
      case Wococo:
        (value as Wococo).encodeTo(output);
        break;
      case Ethereum:
        (value as Ethereum).encodeTo(output);
        break;
      case BitcoinCore:
        (value as BitcoinCore).encodeTo(output);
        break;
      case BitcoinCash:
        (value as BitcoinCash).encodeTo(output);
        break;
      case PolkadotBulletin:
        (value as PolkadotBulletin).encodeTo(output);
        break;
      default:
        throw Exception(
            'NetworkId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(NetworkId value) {
    switch (value.runtimeType) {
      case ByGenesis:
        return (value as ByGenesis)._sizeHint();
      case ByFork:
        return (value as ByFork)._sizeHint();
      case Polkadot:
        return 1;
      case Kusama:
        return 1;
      case Westend:
        return 1;
      case Rococo:
        return 1;
      case Wococo:
        return 1;
      case Ethereum:
        return (value as Ethereum)._sizeHint();
      case BitcoinCore:
        return 1;
      case BitcoinCash:
        return 1;
      case PolkadotBulletin:
        return 1;
      default:
        throw Exception(
            'NetworkId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class ByGenesis extends NetworkId {
  const ByGenesis(this.value0);

  factory ByGenesis._decode(_i1.Input input) {
    return ByGenesis(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// [u8; 32]
  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'ByGenesis': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
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
      other is ByGenesis &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class ByFork extends NetworkId {
  const ByFork({
    required this.blockNumber,
    required this.blockHash,
  });

  factory ByFork._decode(_i1.Input input) {
    return ByFork(
      blockNumber: _i1.U64Codec.codec.decode(input),
      blockHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// u64
  final BigInt blockNumber;

  /// [u8; 32]
  final List<int> blockHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ByFork': {
          'blockNumber': blockNumber,
          'blockHash': blockHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(blockNumber);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(blockHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      blockNumber,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      blockHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ByFork &&
          other.blockNumber == blockNumber &&
          _i3.listsEqual(
            other.blockHash,
            blockHash,
          );

  @override
  int get hashCode => Object.hash(
        blockNumber,
        blockHash,
      );
}

class Polkadot extends NetworkId {
  const Polkadot();

  @override
  Map<String, dynamic> toJson() => {'Polkadot': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Polkadot;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Kusama extends NetworkId {
  const Kusama();

  @override
  Map<String, dynamic> toJson() => {'Kusama': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Kusama;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Westend extends NetworkId {
  const Westend();

  @override
  Map<String, dynamic> toJson() => {'Westend': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Westend;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Rococo extends NetworkId {
  const Rococo();

  @override
  Map<String, dynamic> toJson() => {'Rococo': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Rococo;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Wococo extends NetworkId {
  const Wococo();

  @override
  Map<String, dynamic> toJson() => {'Wococo': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Wococo;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Ethereum extends NetworkId {
  const Ethereum({required this.chainId});

  factory Ethereum._decode(_i1.Input input) {
    return Ethereum(chainId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u64
  final BigInt chainId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Ethereum': {'chainId': chainId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(chainId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      chainId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Ethereum && other.chainId == chainId;

  @override
  int get hashCode => chainId.hashCode;
}

class BitcoinCore extends NetworkId {
  const BitcoinCore();

  @override
  Map<String, dynamic> toJson() => {'BitcoinCore': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is BitcoinCore;

  @override
  int get hashCode => runtimeType.hashCode;
}

class BitcoinCash extends NetworkId {
  const BitcoinCash();

  @override
  Map<String, dynamic> toJson() => {'BitcoinCash': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is BitcoinCash;

  @override
  int get hashCode => runtimeType.hashCode;
}

class PolkadotBulletin extends NetworkId {
  const PolkadotBulletin();

  @override
  Map<String, dynamic> toJson() => {'PolkadotBulletin': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is PolkadotBulletin;

  @override
  int get hashCode => runtimeType.hashCode;
}
