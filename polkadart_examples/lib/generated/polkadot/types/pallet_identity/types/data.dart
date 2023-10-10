// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

abstract class Data {
  const Data();

  factory Data.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $DataCodec codec = $DataCodec();

  static const $Data values = $Data();

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

class $Data {
  const $Data();

  None none() {
    return None();
  }

  Raw0 raw0(List<int> value0) {
    return Raw0(value0);
  }

  Raw1 raw1(List<int> value0) {
    return Raw1(value0);
  }

  Raw2 raw2(List<int> value0) {
    return Raw2(value0);
  }

  Raw3 raw3(List<int> value0) {
    return Raw3(value0);
  }

  Raw4 raw4(List<int> value0) {
    return Raw4(value0);
  }

  Raw5 raw5(List<int> value0) {
    return Raw5(value0);
  }

  Raw6 raw6(List<int> value0) {
    return Raw6(value0);
  }

  Raw7 raw7(List<int> value0) {
    return Raw7(value0);
  }

  Raw8 raw8(List<int> value0) {
    return Raw8(value0);
  }

  Raw9 raw9(List<int> value0) {
    return Raw9(value0);
  }

  Raw10 raw10(List<int> value0) {
    return Raw10(value0);
  }

  Raw11 raw11(List<int> value0) {
    return Raw11(value0);
  }

  Raw12 raw12(List<int> value0) {
    return Raw12(value0);
  }

  Raw13 raw13(List<int> value0) {
    return Raw13(value0);
  }

  Raw14 raw14(List<int> value0) {
    return Raw14(value0);
  }

  Raw15 raw15(List<int> value0) {
    return Raw15(value0);
  }

  Raw16 raw16(List<int> value0) {
    return Raw16(value0);
  }

  Raw17 raw17(List<int> value0) {
    return Raw17(value0);
  }

  Raw18 raw18(List<int> value0) {
    return Raw18(value0);
  }

  Raw19 raw19(List<int> value0) {
    return Raw19(value0);
  }

  Raw20 raw20(List<int> value0) {
    return Raw20(value0);
  }

  Raw21 raw21(List<int> value0) {
    return Raw21(value0);
  }

  Raw22 raw22(List<int> value0) {
    return Raw22(value0);
  }

  Raw23 raw23(List<int> value0) {
    return Raw23(value0);
  }

  Raw24 raw24(List<int> value0) {
    return Raw24(value0);
  }

  Raw25 raw25(List<int> value0) {
    return Raw25(value0);
  }

  Raw26 raw26(List<int> value0) {
    return Raw26(value0);
  }

  Raw27 raw27(List<int> value0) {
    return Raw27(value0);
  }

  Raw28 raw28(List<int> value0) {
    return Raw28(value0);
  }

  Raw29 raw29(List<int> value0) {
    return Raw29(value0);
  }

  Raw30 raw30(List<int> value0) {
    return Raw30(value0);
  }

  Raw31 raw31(List<int> value0) {
    return Raw31(value0);
  }

  Raw32 raw32(List<int> value0) {
    return Raw32(value0);
  }

  BlakeTwo256 blakeTwo256(List<int> value0) {
    return BlakeTwo256(value0);
  }

  Sha256 sha256(List<int> value0) {
    return Sha256(value0);
  }

  Keccak256 keccak256(List<int> value0) {
    return Keccak256(value0);
  }

  ShaThree256 shaThree256(List<int> value0) {
    return ShaThree256(value0);
  }
}

class $DataCodec with _i1.Codec<Data> {
  const $DataCodec();

  @override
  Data decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const None();
      case 1:
        return Raw0._decode(input);
      case 2:
        return Raw1._decode(input);
      case 3:
        return Raw2._decode(input);
      case 4:
        return Raw3._decode(input);
      case 5:
        return Raw4._decode(input);
      case 6:
        return Raw5._decode(input);
      case 7:
        return Raw6._decode(input);
      case 8:
        return Raw7._decode(input);
      case 9:
        return Raw8._decode(input);
      case 10:
        return Raw9._decode(input);
      case 11:
        return Raw10._decode(input);
      case 12:
        return Raw11._decode(input);
      case 13:
        return Raw12._decode(input);
      case 14:
        return Raw13._decode(input);
      case 15:
        return Raw14._decode(input);
      case 16:
        return Raw15._decode(input);
      case 17:
        return Raw16._decode(input);
      case 18:
        return Raw17._decode(input);
      case 19:
        return Raw18._decode(input);
      case 20:
        return Raw19._decode(input);
      case 21:
        return Raw20._decode(input);
      case 22:
        return Raw21._decode(input);
      case 23:
        return Raw22._decode(input);
      case 24:
        return Raw23._decode(input);
      case 25:
        return Raw24._decode(input);
      case 26:
        return Raw25._decode(input);
      case 27:
        return Raw26._decode(input);
      case 28:
        return Raw27._decode(input);
      case 29:
        return Raw28._decode(input);
      case 30:
        return Raw29._decode(input);
      case 31:
        return Raw30._decode(input);
      case 32:
        return Raw31._decode(input);
      case 33:
        return Raw32._decode(input);
      case 34:
        return BlakeTwo256._decode(input);
      case 35:
        return Sha256._decode(input);
      case 36:
        return Keccak256._decode(input);
      case 37:
        return ShaThree256._decode(input);
      default:
        throw Exception('Data: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Data value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case None:
        (value as None).encodeTo(output);
        break;
      case Raw0:
        (value as Raw0).encodeTo(output);
        break;
      case Raw1:
        (value as Raw1).encodeTo(output);
        break;
      case Raw2:
        (value as Raw2).encodeTo(output);
        break;
      case Raw3:
        (value as Raw3).encodeTo(output);
        break;
      case Raw4:
        (value as Raw4).encodeTo(output);
        break;
      case Raw5:
        (value as Raw5).encodeTo(output);
        break;
      case Raw6:
        (value as Raw6).encodeTo(output);
        break;
      case Raw7:
        (value as Raw7).encodeTo(output);
        break;
      case Raw8:
        (value as Raw8).encodeTo(output);
        break;
      case Raw9:
        (value as Raw9).encodeTo(output);
        break;
      case Raw10:
        (value as Raw10).encodeTo(output);
        break;
      case Raw11:
        (value as Raw11).encodeTo(output);
        break;
      case Raw12:
        (value as Raw12).encodeTo(output);
        break;
      case Raw13:
        (value as Raw13).encodeTo(output);
        break;
      case Raw14:
        (value as Raw14).encodeTo(output);
        break;
      case Raw15:
        (value as Raw15).encodeTo(output);
        break;
      case Raw16:
        (value as Raw16).encodeTo(output);
        break;
      case Raw17:
        (value as Raw17).encodeTo(output);
        break;
      case Raw18:
        (value as Raw18).encodeTo(output);
        break;
      case Raw19:
        (value as Raw19).encodeTo(output);
        break;
      case Raw20:
        (value as Raw20).encodeTo(output);
        break;
      case Raw21:
        (value as Raw21).encodeTo(output);
        break;
      case Raw22:
        (value as Raw22).encodeTo(output);
        break;
      case Raw23:
        (value as Raw23).encodeTo(output);
        break;
      case Raw24:
        (value as Raw24).encodeTo(output);
        break;
      case Raw25:
        (value as Raw25).encodeTo(output);
        break;
      case Raw26:
        (value as Raw26).encodeTo(output);
        break;
      case Raw27:
        (value as Raw27).encodeTo(output);
        break;
      case Raw28:
        (value as Raw28).encodeTo(output);
        break;
      case Raw29:
        (value as Raw29).encodeTo(output);
        break;
      case Raw30:
        (value as Raw30).encodeTo(output);
        break;
      case Raw31:
        (value as Raw31).encodeTo(output);
        break;
      case Raw32:
        (value as Raw32).encodeTo(output);
        break;
      case BlakeTwo256:
        (value as BlakeTwo256).encodeTo(output);
        break;
      case Sha256:
        (value as Sha256).encodeTo(output);
        break;
      case Keccak256:
        (value as Keccak256).encodeTo(output);
        break;
      case ShaThree256:
        (value as ShaThree256).encodeTo(output);
        break;
      default:
        throw Exception(
            'Data: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Data value) {
    switch (value.runtimeType) {
      case None:
        return 1;
      case Raw0:
        return (value as Raw0)._sizeHint();
      case Raw1:
        return (value as Raw1)._sizeHint();
      case Raw2:
        return (value as Raw2)._sizeHint();
      case Raw3:
        return (value as Raw3)._sizeHint();
      case Raw4:
        return (value as Raw4)._sizeHint();
      case Raw5:
        return (value as Raw5)._sizeHint();
      case Raw6:
        return (value as Raw6)._sizeHint();
      case Raw7:
        return (value as Raw7)._sizeHint();
      case Raw8:
        return (value as Raw8)._sizeHint();
      case Raw9:
        return (value as Raw9)._sizeHint();
      case Raw10:
        return (value as Raw10)._sizeHint();
      case Raw11:
        return (value as Raw11)._sizeHint();
      case Raw12:
        return (value as Raw12)._sizeHint();
      case Raw13:
        return (value as Raw13)._sizeHint();
      case Raw14:
        return (value as Raw14)._sizeHint();
      case Raw15:
        return (value as Raw15)._sizeHint();
      case Raw16:
        return (value as Raw16)._sizeHint();
      case Raw17:
        return (value as Raw17)._sizeHint();
      case Raw18:
        return (value as Raw18)._sizeHint();
      case Raw19:
        return (value as Raw19)._sizeHint();
      case Raw20:
        return (value as Raw20)._sizeHint();
      case Raw21:
        return (value as Raw21)._sizeHint();
      case Raw22:
        return (value as Raw22)._sizeHint();
      case Raw23:
        return (value as Raw23)._sizeHint();
      case Raw24:
        return (value as Raw24)._sizeHint();
      case Raw25:
        return (value as Raw25)._sizeHint();
      case Raw26:
        return (value as Raw26)._sizeHint();
      case Raw27:
        return (value as Raw27)._sizeHint();
      case Raw28:
        return (value as Raw28)._sizeHint();
      case Raw29:
        return (value as Raw29)._sizeHint();
      case Raw30:
        return (value as Raw30)._sizeHint();
      case Raw31:
        return (value as Raw31)._sizeHint();
      case Raw32:
        return (value as Raw32)._sizeHint();
      case BlakeTwo256:
        return (value as BlakeTwo256)._sizeHint();
      case Sha256:
        return (value as Sha256)._sizeHint();
      case Keccak256:
        return (value as Keccak256)._sizeHint();
      case ShaThree256:
        return (value as ShaThree256)._sizeHint();
      default:
        throw Exception(
            'Data: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class None extends Data {
  const None();

  @override
  Map<String, dynamic> toJson() => {'None': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is None;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Raw0 extends Data {
  const Raw0(this.value0);

  factory Raw0._decode(_i1.Input input) {
    return Raw0(const _i1.U8ArrayCodec(0).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw0': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(0).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(0).encodeTo(
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
      other is Raw0 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw1 extends Data {
  const Raw1(this.value0);

  factory Raw1._decode(_i1.Input input) {
    return Raw1(const _i1.U8ArrayCodec(1).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw1': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(1).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(1).encodeTo(
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
      other is Raw1 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw2 extends Data {
  const Raw2(this.value0);

  factory Raw2._decode(_i1.Input input) {
    return Raw2(const _i1.U8ArrayCodec(2).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw2': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(2).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(2).encodeTo(
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
      other is Raw2 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw3 extends Data {
  const Raw3(this.value0);

  factory Raw3._decode(_i1.Input input) {
    return Raw3(const _i1.U8ArrayCodec(3).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw3': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(3).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(3).encodeTo(
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
      other is Raw3 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw4 extends Data {
  const Raw4(this.value0);

  factory Raw4._decode(_i1.Input input) {
    return Raw4(const _i1.U8ArrayCodec(4).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw4': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(4).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(4).encodeTo(
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
      other is Raw4 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw5 extends Data {
  const Raw5(this.value0);

  factory Raw5._decode(_i1.Input input) {
    return Raw5(const _i1.U8ArrayCodec(5).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw5': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(5).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(5).encodeTo(
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
      other is Raw5 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw6 extends Data {
  const Raw6(this.value0);

  factory Raw6._decode(_i1.Input input) {
    return Raw6(const _i1.U8ArrayCodec(6).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw6': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(6).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.U8ArrayCodec(6).encodeTo(
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
      other is Raw6 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw7 extends Data {
  const Raw7(this.value0);

  factory Raw7._decode(_i1.Input input) {
    return Raw7(const _i1.U8ArrayCodec(7).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw7': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(7).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    const _i1.U8ArrayCodec(7).encodeTo(
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
      other is Raw7 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw8 extends Data {
  const Raw8(this.value0);

  factory Raw8._decode(_i1.Input input) {
    return Raw8(const _i1.U8ArrayCodec(8).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw8': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(8).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    const _i1.U8ArrayCodec(8).encodeTo(
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
      other is Raw8 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw9 extends Data {
  const Raw9(this.value0);

  factory Raw9._decode(_i1.Input input) {
    return Raw9(const _i1.U8ArrayCodec(9).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw9': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(9).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    const _i1.U8ArrayCodec(9).encodeTo(
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
      other is Raw9 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw10 extends Data {
  const Raw10(this.value0);

  factory Raw10._decode(_i1.Input input) {
    return Raw10(const _i1.U8ArrayCodec(10).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw10': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(10).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    const _i1.U8ArrayCodec(10).encodeTo(
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
      other is Raw10 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw11 extends Data {
  const Raw11(this.value0);

  factory Raw11._decode(_i1.Input input) {
    return Raw11(const _i1.U8ArrayCodec(11).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw11': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(11).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    const _i1.U8ArrayCodec(11).encodeTo(
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
      other is Raw11 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw12 extends Data {
  const Raw12(this.value0);

  factory Raw12._decode(_i1.Input input) {
    return Raw12(const _i1.U8ArrayCodec(12).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw12': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(12).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    const _i1.U8ArrayCodec(12).encodeTo(
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
      other is Raw12 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw13 extends Data {
  const Raw13(this.value0);

  factory Raw13._decode(_i1.Input input) {
    return Raw13(const _i1.U8ArrayCodec(13).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw13': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(13).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    const _i1.U8ArrayCodec(13).encodeTo(
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
      other is Raw13 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw14 extends Data {
  const Raw14(this.value0);

  factory Raw14._decode(_i1.Input input) {
    return Raw14(const _i1.U8ArrayCodec(14).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw14': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(14).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    const _i1.U8ArrayCodec(14).encodeTo(
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
      other is Raw14 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw15 extends Data {
  const Raw15(this.value0);

  factory Raw15._decode(_i1.Input input) {
    return Raw15(const _i1.U8ArrayCodec(15).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw15': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(15).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    const _i1.U8ArrayCodec(15).encodeTo(
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
      other is Raw15 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw16 extends Data {
  const Raw16(this.value0);

  factory Raw16._decode(_i1.Input input) {
    return Raw16(const _i1.U8ArrayCodec(16).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw16': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(16).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    const _i1.U8ArrayCodec(16).encodeTo(
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
      other is Raw16 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw17 extends Data {
  const Raw17(this.value0);

  factory Raw17._decode(_i1.Input input) {
    return Raw17(const _i1.U8ArrayCodec(17).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw17': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(17).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    const _i1.U8ArrayCodec(17).encodeTo(
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
      other is Raw17 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw18 extends Data {
  const Raw18(this.value0);

  factory Raw18._decode(_i1.Input input) {
    return Raw18(const _i1.U8ArrayCodec(18).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw18': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(18).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    const _i1.U8ArrayCodec(18).encodeTo(
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
      other is Raw18 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw19 extends Data {
  const Raw19(this.value0);

  factory Raw19._decode(_i1.Input input) {
    return Raw19(const _i1.U8ArrayCodec(19).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw19': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(19).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    const _i1.U8ArrayCodec(19).encodeTo(
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
      other is Raw19 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw20 extends Data {
  const Raw20(this.value0);

  factory Raw20._decode(_i1.Input input) {
    return Raw20(const _i1.U8ArrayCodec(20).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw20': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(20).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
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
      other is Raw20 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw21 extends Data {
  const Raw21(this.value0);

  factory Raw21._decode(_i1.Input input) {
    return Raw21(const _i1.U8ArrayCodec(21).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw21': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(21).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    const _i1.U8ArrayCodec(21).encodeTo(
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
      other is Raw21 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw22 extends Data {
  const Raw22(this.value0);

  factory Raw22._decode(_i1.Input input) {
    return Raw22(const _i1.U8ArrayCodec(22).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw22': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(22).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
    const _i1.U8ArrayCodec(22).encodeTo(
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
      other is Raw22 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw23 extends Data {
  const Raw23(this.value0);

  factory Raw23._decode(_i1.Input input) {
    return Raw23(const _i1.U8ArrayCodec(23).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw23': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(23).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    const _i1.U8ArrayCodec(23).encodeTo(
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
      other is Raw23 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw24 extends Data {
  const Raw24(this.value0);

  factory Raw24._decode(_i1.Input input) {
    return Raw24(const _i1.U8ArrayCodec(24).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw24': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(24).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    const _i1.U8ArrayCodec(24).encodeTo(
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
      other is Raw24 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw25 extends Data {
  const Raw25(this.value0);

  factory Raw25._decode(_i1.Input input) {
    return Raw25(const _i1.U8ArrayCodec(25).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw25': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(25).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
    const _i1.U8ArrayCodec(25).encodeTo(
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
      other is Raw25 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw26 extends Data {
  const Raw26(this.value0);

  factory Raw26._decode(_i1.Input input) {
    return Raw26(const _i1.U8ArrayCodec(26).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw26': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(26).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
    const _i1.U8ArrayCodec(26).encodeTo(
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
      other is Raw26 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw27 extends Data {
  const Raw27(this.value0);

  factory Raw27._decode(_i1.Input input) {
    return Raw27(const _i1.U8ArrayCodec(27).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw27': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(27).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
    const _i1.U8ArrayCodec(27).encodeTo(
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
      other is Raw27 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw28 extends Data {
  const Raw28(this.value0);

  factory Raw28._decode(_i1.Input input) {
    return Raw28(const _i1.U8ArrayCodec(28).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw28': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(28).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
    const _i1.U8ArrayCodec(28).encodeTo(
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
      other is Raw28 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw29 extends Data {
  const Raw29(this.value0);

  factory Raw29._decode(_i1.Input input) {
    return Raw29(const _i1.U8ArrayCodec(29).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw29': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(29).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    const _i1.U8ArrayCodec(29).encodeTo(
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
      other is Raw29 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw30 extends Data {
  const Raw30(this.value0);

  factory Raw30._decode(_i1.Input input) {
    return Raw30(const _i1.U8ArrayCodec(30).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw30': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(30).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    const _i1.U8ArrayCodec(30).encodeTo(
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
      other is Raw30 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw31 extends Data {
  const Raw31(this.value0);

  factory Raw31._decode(_i1.Input input) {
    return Raw31(const _i1.U8ArrayCodec(31).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw31': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(31).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    const _i1.U8ArrayCodec(31).encodeTo(
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
      other is Raw31 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Raw32 extends Data {
  const Raw32(this.value0);

  factory Raw32._decode(_i1.Input input) {
    return Raw32(const _i1.U8ArrayCodec(32).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Raw32': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
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
      other is Raw32 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class BlakeTwo256 extends Data {
  const BlakeTwo256(this.value0);

  factory BlakeTwo256._decode(_i1.Input input) {
    return BlakeTwo256(const _i1.U8ArrayCodec(32).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'BlakeTwo256': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
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
      other is BlakeTwo256 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Sha256 extends Data {
  const Sha256(this.value0);

  factory Sha256._decode(_i1.Input input) {
    return Sha256(const _i1.U8ArrayCodec(32).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Sha256': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
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
      other is Sha256 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Keccak256 extends Data {
  const Keccak256(this.value0);

  factory Keccak256._decode(_i1.Input input) {
    return Keccak256(const _i1.U8ArrayCodec(32).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'Keccak256': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      36,
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
      other is Keccak256 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class ShaThree256 extends Data {
  const ShaThree256(this.value0);

  factory ShaThree256._decode(_i1.Input input) {
    return ShaThree256(const _i1.U8ArrayCodec(32).decode(input));
  }

  final List<int> value0;

  @override
  Map<String, List<int>> toJson() => {'ShaThree256': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      37,
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
      other is ShaThree256 &&
          _i3.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}
