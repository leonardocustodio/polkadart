// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../primitive_types/h256.dart' as _i3;

abstract class ValidDisputeStatementKind {
  const ValidDisputeStatementKind();

  factory ValidDisputeStatementKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ValidDisputeStatementKindCodec codec =
      $ValidDisputeStatementKindCodec();

  static const $ValidDisputeStatementKind values = $ValidDisputeStatementKind();

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

class $ValidDisputeStatementKind {
  const $ValidDisputeStatementKind();

  Explicit explicit() {
    return Explicit();
  }

  BackingSeconded backingSeconded(_i3.H256 value0) {
    return BackingSeconded(value0);
  }

  BackingValid backingValid(_i3.H256 value0) {
    return BackingValid(value0);
  }

  ApprovalChecking approvalChecking() {
    return ApprovalChecking();
  }
}

class $ValidDisputeStatementKindCodec
    with _i1.Codec<ValidDisputeStatementKind> {
  const $ValidDisputeStatementKindCodec();

  @override
  ValidDisputeStatementKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Explicit();
      case 1:
        return BackingSeconded._decode(input);
      case 2:
        return BackingValid._decode(input);
      case 3:
        return const ApprovalChecking();
      default:
        throw Exception(
            'ValidDisputeStatementKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ValidDisputeStatementKind value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Explicit:
        (value as Explicit).encodeTo(output);
        break;
      case BackingSeconded:
        (value as BackingSeconded).encodeTo(output);
        break;
      case BackingValid:
        (value as BackingValid).encodeTo(output);
        break;
      case ApprovalChecking:
        (value as ApprovalChecking).encodeTo(output);
        break;
      default:
        throw Exception(
            'ValidDisputeStatementKind: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ValidDisputeStatementKind value) {
    switch (value.runtimeType) {
      case Explicit:
        return 1;
      case BackingSeconded:
        return (value as BackingSeconded)._sizeHint();
      case BackingValid:
        return (value as BackingValid)._sizeHint();
      case ApprovalChecking:
        return 1;
      default:
        throw Exception(
            'ValidDisputeStatementKind: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Explicit extends ValidDisputeStatementKind {
  const Explicit();

  @override
  Map<String, dynamic> toJson() => {'Explicit': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Explicit;

  @override
  int get hashCode => runtimeType.hashCode;
}

class BackingSeconded extends ValidDisputeStatementKind {
  const BackingSeconded(this.value0);

  factory BackingSeconded._decode(_i1.Input input) {
    return BackingSeconded(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// Hash
  final _i3.H256 value0;

  @override
  Map<String, List<int>> toJson() => {'BackingSeconded': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(value0);
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
      other is BackingSeconded &&
          _i4.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class BackingValid extends ValidDisputeStatementKind {
  const BackingValid(this.value0);

  factory BackingValid._decode(_i1.Input input) {
    return BackingValid(const _i1.U8ArrayCodec(32).decode(input));
  }

  /// Hash
  final _i3.H256 value0;

  @override
  Map<String, List<int>> toJson() => {'BackingValid': value0.toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is BackingValid &&
          _i4.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class ApprovalChecking extends ValidDisputeStatementKind {
  const ApprovalChecking();

  @override
  Map<String, dynamic> toJson() => {'ApprovalChecking': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ApprovalChecking;

  @override
  int get hashCode => runtimeType.hashCode;
}
