// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../junction/junction.dart' as _i3;

abstract class Junctions {
  const Junctions();

  factory Junctions.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $JunctionsCodec codec = $JunctionsCodec();

  static const $Junctions values = $Junctions();

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

class $Junctions {
  const $Junctions();

  Here here() {
    return Here();
  }

  X1 x1(_i3.Junction value0) {
    return X1(value0);
  }

  X2 x2(
    _i3.Junction value0,
    _i3.Junction value1,
  ) {
    return X2(
      value0,
      value1,
    );
  }

  X3 x3(
    _i3.Junction value0,
    _i3.Junction value1,
    _i3.Junction value2,
  ) {
    return X3(
      value0,
      value1,
      value2,
    );
  }

  X4 x4(
    _i3.Junction value0,
    _i3.Junction value1,
    _i3.Junction value2,
    _i3.Junction value3,
  ) {
    return X4(
      value0,
      value1,
      value2,
      value3,
    );
  }

  X5 x5(
    _i3.Junction value0,
    _i3.Junction value1,
    _i3.Junction value2,
    _i3.Junction value3,
    _i3.Junction value4,
  ) {
    return X5(
      value0,
      value1,
      value2,
      value3,
      value4,
    );
  }

  X6 x6(
    _i3.Junction value0,
    _i3.Junction value1,
    _i3.Junction value2,
    _i3.Junction value3,
    _i3.Junction value4,
    _i3.Junction value5,
  ) {
    return X6(
      value0,
      value1,
      value2,
      value3,
      value4,
      value5,
    );
  }

  X7 x7(
    _i3.Junction value0,
    _i3.Junction value1,
    _i3.Junction value2,
    _i3.Junction value3,
    _i3.Junction value4,
    _i3.Junction value5,
    _i3.Junction value6,
  ) {
    return X7(
      value0,
      value1,
      value2,
      value3,
      value4,
      value5,
      value6,
    );
  }

  X8 x8(
    _i3.Junction value0,
    _i3.Junction value1,
    _i3.Junction value2,
    _i3.Junction value3,
    _i3.Junction value4,
    _i3.Junction value5,
    _i3.Junction value6,
    _i3.Junction value7,
  ) {
    return X8(
      value0,
      value1,
      value2,
      value3,
      value4,
      value5,
      value6,
      value7,
    );
  }
}

class $JunctionsCodec with _i1.Codec<Junctions> {
  const $JunctionsCodec();

  @override
  Junctions decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Here();
      case 1:
        return X1._decode(input);
      case 2:
        return X2._decode(input);
      case 3:
        return X3._decode(input);
      case 4:
        return X4._decode(input);
      case 5:
        return X5._decode(input);
      case 6:
        return X6._decode(input);
      case 7:
        return X7._decode(input);
      case 8:
        return X8._decode(input);
      default:
        throw Exception('Junctions: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Junctions value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Here:
        (value as Here).encodeTo(output);
        break;
      case X1:
        (value as X1).encodeTo(output);
        break;
      case X2:
        (value as X2).encodeTo(output);
        break;
      case X3:
        (value as X3).encodeTo(output);
        break;
      case X4:
        (value as X4).encodeTo(output);
        break;
      case X5:
        (value as X5).encodeTo(output);
        break;
      case X6:
        (value as X6).encodeTo(output);
        break;
      case X7:
        (value as X7).encodeTo(output);
        break;
      case X8:
        (value as X8).encodeTo(output);
        break;
      default:
        throw Exception(
            'Junctions: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Junctions value) {
    switch (value.runtimeType) {
      case Here:
        return 1;
      case X1:
        return (value as X1)._sizeHint();
      case X2:
        return (value as X2)._sizeHint();
      case X3:
        return (value as X3)._sizeHint();
      case X4:
        return (value as X4)._sizeHint();
      case X5:
        return (value as X5)._sizeHint();
      case X6:
        return (value as X6)._sizeHint();
      case X7:
        return (value as X7)._sizeHint();
      case X8:
        return (value as X8)._sizeHint();
      default:
        throw Exception(
            'Junctions: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Here extends Junctions {
  const Here();

  @override
  Map<String, dynamic> toJson() => {'Here': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Here;

  @override
  int get hashCode => runtimeType.hashCode;
}

class X1 extends Junctions {
  const X1(this.value0);

  factory X1._decode(_i1.Input input) {
    return X1(_i3.Junction.codec.decode(input));
  }

  /// Junction
  final _i3.Junction value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'X1': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Junction.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.Junction.codec.encodeTo(
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
      other is X1 && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class X2 extends Junctions {
  const X2(
    this.value0,
    this.value1,
  );

  factory X2._decode(_i1.Input input) {
    return X2(
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
    );
  }

  /// Junction
  final _i3.Junction value0;

  /// Junction
  final _i3.Junction value1;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'X2': [
          value0.toJson(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Junction.codec.sizeHint(value0);
    size = size + _i3.Junction.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value0,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is X2 && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class X3 extends Junctions {
  const X3(
    this.value0,
    this.value1,
    this.value2,
  );

  factory X3._decode(_i1.Input input) {
    return X3(
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
    );
  }

  /// Junction
  final _i3.Junction value0;

  /// Junction
  final _i3.Junction value1;

  /// Junction
  final _i3.Junction value2;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'X3': [
          value0.toJson(),
          value1.toJson(),
          value2.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Junction.codec.sizeHint(value0);
    size = size + _i3.Junction.codec.sizeHint(value1);
    size = size + _i3.Junction.codec.sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value0,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value1,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value2,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is X3 &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

class X4 extends Junctions {
  const X4(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
  );

  factory X4._decode(_i1.Input input) {
    return X4(
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
    );
  }

  /// Junction
  final _i3.Junction value0;

  /// Junction
  final _i3.Junction value1;

  /// Junction
  final _i3.Junction value2;

  /// Junction
  final _i3.Junction value3;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'X4': [
          value0.toJson(),
          value1.toJson(),
          value2.toJson(),
          value3.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Junction.codec.sizeHint(value0);
    size = size + _i3.Junction.codec.sizeHint(value1);
    size = size + _i3.Junction.codec.sizeHint(value2);
    size = size + _i3.Junction.codec.sizeHint(value3);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value0,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value1,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value2,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value3,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is X4 &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          other.value3 == value3;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
      );
}

class X5 extends Junctions {
  const X5(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  );

  factory X5._decode(_i1.Input input) {
    return X5(
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
    );
  }

  /// Junction
  final _i3.Junction value0;

  /// Junction
  final _i3.Junction value1;

  /// Junction
  final _i3.Junction value2;

  /// Junction
  final _i3.Junction value3;

  /// Junction
  final _i3.Junction value4;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'X5': [
          value0.toJson(),
          value1.toJson(),
          value2.toJson(),
          value3.toJson(),
          value4.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Junction.codec.sizeHint(value0);
    size = size + _i3.Junction.codec.sizeHint(value1);
    size = size + _i3.Junction.codec.sizeHint(value2);
    size = size + _i3.Junction.codec.sizeHint(value3);
    size = size + _i3.Junction.codec.sizeHint(value4);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value0,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value1,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value2,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value3,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value4,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is X5 &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          other.value3 == value3 &&
          other.value4 == value4;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
        value4,
      );
}

class X6 extends Junctions {
  const X6(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
    this.value5,
  );

  factory X6._decode(_i1.Input input) {
    return X6(
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
    );
  }

  /// Junction
  final _i3.Junction value0;

  /// Junction
  final _i3.Junction value1;

  /// Junction
  final _i3.Junction value2;

  /// Junction
  final _i3.Junction value3;

  /// Junction
  final _i3.Junction value4;

  /// Junction
  final _i3.Junction value5;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'X6': [
          value0.toJson(),
          value1.toJson(),
          value2.toJson(),
          value3.toJson(),
          value4.toJson(),
          value5.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Junction.codec.sizeHint(value0);
    size = size + _i3.Junction.codec.sizeHint(value1);
    size = size + _i3.Junction.codec.sizeHint(value2);
    size = size + _i3.Junction.codec.sizeHint(value3);
    size = size + _i3.Junction.codec.sizeHint(value4);
    size = size + _i3.Junction.codec.sizeHint(value5);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value0,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value1,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value2,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value3,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value4,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value5,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is X6 &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          other.value3 == value3 &&
          other.value4 == value4 &&
          other.value5 == value5;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
        value4,
        value5,
      );
}

class X7 extends Junctions {
  const X7(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
    this.value5,
    this.value6,
  );

  factory X7._decode(_i1.Input input) {
    return X7(
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
    );
  }

  /// Junction
  final _i3.Junction value0;

  /// Junction
  final _i3.Junction value1;

  /// Junction
  final _i3.Junction value2;

  /// Junction
  final _i3.Junction value3;

  /// Junction
  final _i3.Junction value4;

  /// Junction
  final _i3.Junction value5;

  /// Junction
  final _i3.Junction value6;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'X7': [
          value0.toJson(),
          value1.toJson(),
          value2.toJson(),
          value3.toJson(),
          value4.toJson(),
          value5.toJson(),
          value6.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Junction.codec.sizeHint(value0);
    size = size + _i3.Junction.codec.sizeHint(value1);
    size = size + _i3.Junction.codec.sizeHint(value2);
    size = size + _i3.Junction.codec.sizeHint(value3);
    size = size + _i3.Junction.codec.sizeHint(value4);
    size = size + _i3.Junction.codec.sizeHint(value5);
    size = size + _i3.Junction.codec.sizeHint(value6);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value0,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value1,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value2,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value3,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value4,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value5,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value6,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is X7 &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          other.value3 == value3 &&
          other.value4 == value4 &&
          other.value5 == value5 &&
          other.value6 == value6;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
        value4,
        value5,
        value6,
      );
}

class X8 extends Junctions {
  const X8(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
    this.value5,
    this.value6,
    this.value7,
  );

  factory X8._decode(_i1.Input input) {
    return X8(
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
      _i3.Junction.codec.decode(input),
    );
  }

  /// Junction
  final _i3.Junction value0;

  /// Junction
  final _i3.Junction value1;

  /// Junction
  final _i3.Junction value2;

  /// Junction
  final _i3.Junction value3;

  /// Junction
  final _i3.Junction value4;

  /// Junction
  final _i3.Junction value5;

  /// Junction
  final _i3.Junction value6;

  /// Junction
  final _i3.Junction value7;

  @override
  Map<String, List<Map<String, dynamic>>> toJson() => {
        'X8': [
          value0.toJson(),
          value1.toJson(),
          value2.toJson(),
          value3.toJson(),
          value4.toJson(),
          value5.toJson(),
          value6.toJson(),
          value7.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Junction.codec.sizeHint(value0);
    size = size + _i3.Junction.codec.sizeHint(value1);
    size = size + _i3.Junction.codec.sizeHint(value2);
    size = size + _i3.Junction.codec.sizeHint(value3);
    size = size + _i3.Junction.codec.sizeHint(value4);
    size = size + _i3.Junction.codec.sizeHint(value5);
    size = size + _i3.Junction.codec.sizeHint(value6);
    size = size + _i3.Junction.codec.sizeHint(value7);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value0,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value1,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value2,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value3,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value4,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value5,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value6,
      output,
    );
    _i3.Junction.codec.encodeTo(
      value7,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is X8 &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          other.value3 == value3 &&
          other.value4 == value4 &&
          other.value5 == value5 &&
          other.value6 == value6 &&
          other.value7 == value7;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
        value4,
        value5,
        value6,
        value7,
      );
}
