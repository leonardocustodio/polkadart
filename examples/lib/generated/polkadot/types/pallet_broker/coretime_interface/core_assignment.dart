// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class CoreAssignment {
  const CoreAssignment();

  factory CoreAssignment.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CoreAssignmentCodec codec = $CoreAssignmentCodec();

  static const $CoreAssignment values = $CoreAssignment();

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

class $CoreAssignment {
  const $CoreAssignment();

  Idle idle() {
    return Idle();
  }

  Pool pool() {
    return Pool();
  }

  Task task(int value0) {
    return Task(value0);
  }
}

class $CoreAssignmentCodec with _i1.Codec<CoreAssignment> {
  const $CoreAssignmentCodec();

  @override
  CoreAssignment decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Idle();
      case 1:
        return const Pool();
      case 2:
        return Task._decode(input);
      default:
        throw Exception('CoreAssignment: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    CoreAssignment value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Idle:
        (value as Idle).encodeTo(output);
        break;
      case Pool:
        (value as Pool).encodeTo(output);
        break;
      case Task:
        (value as Task).encodeTo(output);
        break;
      default:
        throw Exception(
            'CoreAssignment: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(CoreAssignment value) {
    switch (value.runtimeType) {
      case Idle:
        return 1;
      case Pool:
        return 1;
      case Task:
        return (value as Task)._sizeHint();
      default:
        throw Exception(
            'CoreAssignment: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Idle extends CoreAssignment {
  const Idle();

  @override
  Map<String, dynamic> toJson() => {'Idle': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Idle;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Pool extends CoreAssignment {
  const Pool();

  @override
  Map<String, dynamic> toJson() => {'Pool': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Pool;

  @override
  int get hashCode => runtimeType.hashCode;
}

class Task extends CoreAssignment {
  const Task(this.value0);

  factory Task._decode(_i1.Input input) {
    return Task(_i1.U32Codec.codec.decode(input));
  }

  /// TaskId
  final int value0;

  @override
  Map<String, int> toJson() => {'Task': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is Task && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
