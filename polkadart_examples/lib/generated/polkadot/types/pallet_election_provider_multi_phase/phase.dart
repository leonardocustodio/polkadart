// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../tuples.dart' as _i3;

abstract class Phase {
  const Phase();

  factory Phase.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $PhaseCodec codec = $PhaseCodec();

  static const $Phase values = $Phase();

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

class $Phase {
  const $Phase();

  Off off() {
    return Off();
  }

  Signed signed() {
    return Signed();
  }

  Unsigned unsigned(_i3.Tuple2<bool, int> value0) {
    return Unsigned(value0);
  }

  Emergency emergency() {
    return Emergency();
  }
}

class $PhaseCodec with _i1.Codec<Phase> {
  const $PhaseCodec();

  @override
  Phase decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Off();
      case 1:
        return const Signed();
      case 2:
        return Unsigned._decode(input);
      case 3:
        return const Emergency();
      default:
        throw Exception('Phase: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Phase value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Off:
        (value as Off).encodeTo(output);
        break;
      case Signed:
        (value as Signed).encodeTo(output);
        break;
      case Unsigned:
        (value as Unsigned).encodeTo(output);
        break;
      case Emergency:
        (value as Emergency).encodeTo(output);
        break;
      default:
        throw Exception(
            'Phase: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Phase value) {
    switch (value.runtimeType) {
      case Off:
        return 1;
      case Signed:
        return 1;
      case Unsigned:
        return (value as Unsigned)._sizeHint();
      case Emergency:
        return 1;
      default:
        throw Exception(
            'Phase: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Off extends Phase {
  const Off();

  @override
  Map<String, dynamic> toJson() => {'Off': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Off;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Signed extends Phase {
  const Signed();

  @override
  Map<String, dynamic> toJson() => {'Signed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Signed;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Unsigned extends Phase {
  const Unsigned(this.value0);

  factory Unsigned._decode(_i1.Input input) {
    return Unsigned(const _i3.Tuple2Codec<bool, int>(
      _i1.BoolCodec.codec,
      _i1.U32Codec.codec,
    ).decode(input));
  }

  /// (bool, Bn)
  final _i3.Tuple2<bool, int> value0;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Unsigned': [
          value0.value0,
          value0.value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i3.Tuple2Codec<bool, int>(
          _i1.BoolCodec.codec,
          _i1.U32Codec.codec,
        ).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i3.Tuple2Codec<bool, int>(
      _i1.BoolCodec.codec,
      _i1.U32Codec.codec,
    ).encodeTo(
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
      other is Unsigned && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Emergency extends Phase {
  const Emergency();

  @override
  Map<String, dynamic> toJson() => {'Emergency': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Emergency;

  @override
  int get hashCode => runtimeType.hashCode;
}
