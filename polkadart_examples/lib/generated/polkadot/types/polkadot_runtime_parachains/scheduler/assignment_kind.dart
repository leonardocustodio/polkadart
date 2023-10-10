// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_primitives/v4/collator_app/public.dart' as _i3;

abstract class AssignmentKind {
  const AssignmentKind();

  factory AssignmentKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AssignmentKindCodec codec = $AssignmentKindCodec();

  static const $AssignmentKind values = $AssignmentKind();

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

class $AssignmentKind {
  const $AssignmentKind();

  Parachain parachain() {
    return Parachain();
  }

  Parathread parathread(
    _i3.Public value0,
    int value1,
  ) {
    return Parathread(
      value0,
      value1,
    );
  }
}

class $AssignmentKindCodec with _i1.Codec<AssignmentKind> {
  const $AssignmentKindCodec();

  @override
  AssignmentKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Parachain();
      case 1:
        return Parathread._decode(input);
      default:
        throw Exception('AssignmentKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AssignmentKind value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Parachain:
        (value as Parachain).encodeTo(output);
        break;
      case Parathread:
        (value as Parathread).encodeTo(output);
        break;
      default:
        throw Exception(
            'AssignmentKind: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AssignmentKind value) {
    switch (value.runtimeType) {
      case Parachain:
        return 1;
      case Parathread:
        return (value as Parathread)._sizeHint();
      default:
        throw Exception(
            'AssignmentKind: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Parachain extends AssignmentKind {
  const Parachain();

  @override
  Map<String, dynamic> toJson() => {'Parachain': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Parachain;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Parathread extends AssignmentKind {
  const Parathread(
    this.value0,
    this.value1,
  );

  factory Parathread._decode(_i1.Input input) {
    return Parathread(
      const _i1.U8ArrayCodec(32).decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// CollatorId
  final _i3.Public value0;

  /// u32
  final int value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'Parathread': [
          value0.toList(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.PublicCodec().sizeHint(value0);
    size = size + _i1.U32Codec.codec.sizeHint(value1);
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
      other is Parathread && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}
