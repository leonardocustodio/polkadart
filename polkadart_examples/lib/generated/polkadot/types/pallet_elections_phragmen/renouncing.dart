// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class Renouncing {
  const Renouncing();

  factory Renouncing.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RenouncingCodec codec = $RenouncingCodec();

  static const $Renouncing values = $Renouncing();

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

class $Renouncing {
  const $Renouncing();

  Member member() {
    return Member();
  }

  RunnerUp runnerUp() {
    return RunnerUp();
  }

  Candidate candidate(BigInt value0) {
    return Candidate(value0);
  }
}

class $RenouncingCodec with _i1.Codec<Renouncing> {
  const $RenouncingCodec();

  @override
  Renouncing decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Member();
      case 1:
        return const RunnerUp();
      case 2:
        return Candidate._decode(input);
      default:
        throw Exception('Renouncing: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Renouncing value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Member:
        (value as Member).encodeTo(output);
        break;
      case RunnerUp:
        (value as RunnerUp).encodeTo(output);
        break;
      case Candidate:
        (value as Candidate).encodeTo(output);
        break;
      default:
        throw Exception(
            'Renouncing: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Renouncing value) {
    switch (value.runtimeType) {
      case Member:
        return 1;
      case RunnerUp:
        return 1;
      case Candidate:
        return (value as Candidate)._sizeHint();
      default:
        throw Exception(
            'Renouncing: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Member extends Renouncing {
  const Member();

  @override
  Map<String, dynamic> toJson() => {'Member': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Member;

  @override
  int get hashCode => runtimeType.hashCode;
}

class RunnerUp extends Renouncing {
  const RunnerUp();

  @override
  Map<String, dynamic> toJson() => {'RunnerUp': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is RunnerUp;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Candidate extends Renouncing {
  const Candidate(this.value0);

  factory Candidate._decode(_i1.Input input) {
    return Candidate(_i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u32
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'Candidate': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is Candidate && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
