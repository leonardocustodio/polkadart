// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../sp_core/crypto/account_id32.dart' as _i3;

abstract class RawOrigin {
  const RawOrigin();

  factory RawOrigin.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $RawOriginCodec codec = $RawOriginCodec();

  static const $RawOrigin values = $RawOrigin();

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

class $RawOrigin {
  const $RawOrigin();

  Members members(
    int value0,
    int value1,
  ) {
    return Members(
      value0,
      value1,
    );
  }

  Member member(_i3.AccountId32 value0) {
    return Member(value0);
  }

  Phantom phantom() {
    return Phantom();
  }
}

class $RawOriginCodec with _i1.Codec<RawOrigin> {
  const $RawOriginCodec();

  @override
  RawOrigin decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Members._decode(input);
      case 1:
        return Member._decode(input);
      case 2:
        return const Phantom();
      default:
        throw Exception('RawOrigin: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    RawOrigin value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Members:
        (value as Members).encodeTo(output);
        break;
      case Member:
        (value as Member).encodeTo(output);
        break;
      case Phantom:
        (value as Phantom).encodeTo(output);
        break;
      default:
        throw Exception(
            'RawOrigin: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(RawOrigin value) {
    switch (value.runtimeType) {
      case Members:
        return (value as Members)._sizeHint();
      case Member:
        return (value as Member)._sizeHint();
      case Phantom:
        return 1;
      default:
        throw Exception(
            'RawOrigin: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Members extends RawOrigin {
  const Members(
    this.value0,
    this.value1,
  );

  factory Members._decode(_i1.Input input) {
    return Members(
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// MemberCount
  final int value0;

  /// MemberCount
  final int value1;

  @override
  Map<String, List<int>> toJson() => {
        'Members': [
          value0,
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    size = size + _i1.U32Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is Members && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class Member extends RawOrigin {
  const Member(this.value0);

  factory Member._decode(_i1.Input input) {
    return Member(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// AccountId
  final _i3.AccountId32 value0;

  @override
  Map<String, List<int>> toJson() => {'Member': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(value0);
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
      other is Member &&
          _i4.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Phantom extends RawOrigin {
  const Phantom();

  @override
  Map<String, dynamic> toJson() => {'_Phantom': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Phantom;

  @override
  int get hashCode => runtimeType.hashCode;
}
