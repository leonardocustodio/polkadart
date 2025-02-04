// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../pvf_exec_kind.dart' as _i4;
import '../pvf_prep_kind.dart' as _i3;

abstract class ExecutorParam {
  const ExecutorParam();

  factory ExecutorParam.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ExecutorParamCodec codec = $ExecutorParamCodec();

  static const $ExecutorParam values = $ExecutorParam();

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

class $ExecutorParam {
  const $ExecutorParam();

  MaxMemoryPages maxMemoryPages(int value0) {
    return MaxMemoryPages(value0);
  }

  StackLogicalMax stackLogicalMax(int value0) {
    return StackLogicalMax(value0);
  }

  StackNativeMax stackNativeMax(int value0) {
    return StackNativeMax(value0);
  }

  PrecheckingMaxMemory precheckingMaxMemory(BigInt value0) {
    return PrecheckingMaxMemory(value0);
  }

  PvfPrepTimeout pvfPrepTimeout(
    _i3.PvfPrepKind value0,
    BigInt value1,
  ) {
    return PvfPrepTimeout(
      value0,
      value1,
    );
  }

  PvfExecTimeout pvfExecTimeout(
    _i4.PvfExecKind value0,
    BigInt value1,
  ) {
    return PvfExecTimeout(
      value0,
      value1,
    );
  }

  WasmExtBulkMemory wasmExtBulkMemory() {
    return WasmExtBulkMemory();
  }
}

class $ExecutorParamCodec with _i1.Codec<ExecutorParam> {
  const $ExecutorParamCodec();

  @override
  ExecutorParam decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return MaxMemoryPages._decode(input);
      case 2:
        return StackLogicalMax._decode(input);
      case 3:
        return StackNativeMax._decode(input);
      case 4:
        return PrecheckingMaxMemory._decode(input);
      case 5:
        return PvfPrepTimeout._decode(input);
      case 6:
        return PvfExecTimeout._decode(input);
      case 7:
        return const WasmExtBulkMemory();
      default:
        throw Exception('ExecutorParam: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ExecutorParam value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case MaxMemoryPages:
        (value as MaxMemoryPages).encodeTo(output);
        break;
      case StackLogicalMax:
        (value as StackLogicalMax).encodeTo(output);
        break;
      case StackNativeMax:
        (value as StackNativeMax).encodeTo(output);
        break;
      case PrecheckingMaxMemory:
        (value as PrecheckingMaxMemory).encodeTo(output);
        break;
      case PvfPrepTimeout:
        (value as PvfPrepTimeout).encodeTo(output);
        break;
      case PvfExecTimeout:
        (value as PvfExecTimeout).encodeTo(output);
        break;
      case WasmExtBulkMemory:
        (value as WasmExtBulkMemory).encodeTo(output);
        break;
      default:
        throw Exception(
            'ExecutorParam: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ExecutorParam value) {
    switch (value.runtimeType) {
      case MaxMemoryPages:
        return (value as MaxMemoryPages)._sizeHint();
      case StackLogicalMax:
        return (value as StackLogicalMax)._sizeHint();
      case StackNativeMax:
        return (value as StackNativeMax)._sizeHint();
      case PrecheckingMaxMemory:
        return (value as PrecheckingMaxMemory)._sizeHint();
      case PvfPrepTimeout:
        return (value as PvfPrepTimeout)._sizeHint();
      case PvfExecTimeout:
        return (value as PvfExecTimeout)._sizeHint();
      case WasmExtBulkMemory:
        return 1;
      default:
        throw Exception(
            'ExecutorParam: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class MaxMemoryPages extends ExecutorParam {
  const MaxMemoryPages(this.value0);

  factory MaxMemoryPages._decode(_i1.Input input) {
    return MaxMemoryPages(_i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int value0;

  @override
  Map<String, int> toJson() => {'MaxMemoryPages': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
      other is MaxMemoryPages && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class StackLogicalMax extends ExecutorParam {
  const StackLogicalMax(this.value0);

  factory StackLogicalMax._decode(_i1.Input input) {
    return StackLogicalMax(_i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int value0;

  @override
  Map<String, int> toJson() => {'StackLogicalMax': value0};

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
      other is StackLogicalMax && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class StackNativeMax extends ExecutorParam {
  const StackNativeMax(this.value0);

  factory StackNativeMax._decode(_i1.Input input) {
    return StackNativeMax(_i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int value0;

  @override
  Map<String, int> toJson() => {'StackNativeMax': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
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
      other is StackNativeMax && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class PrecheckingMaxMemory extends ExecutorParam {
  const PrecheckingMaxMemory(this.value0);

  factory PrecheckingMaxMemory._decode(_i1.Input input) {
    return PrecheckingMaxMemory(_i1.U64Codec.codec.decode(input));
  }

  /// u64
  final BigInt value0;

  @override
  Map<String, BigInt> toJson() => {'PrecheckingMaxMemory': value0};

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U64Codec.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is PrecheckingMaxMemory && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class PvfPrepTimeout extends ExecutorParam {
  const PvfPrepTimeout(
    this.value0,
    this.value1,
  );

  factory PvfPrepTimeout._decode(_i1.Input input) {
    return PvfPrepTimeout(
      _i3.PvfPrepKind.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
    );
  }

  /// PvfPrepKind
  final _i3.PvfPrepKind value0;

  /// u64
  final BigInt value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'PvfPrepTimeout': [
          value0.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.PvfPrepKind.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.PvfPrepKind.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is PvfPrepTimeout &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class PvfExecTimeout extends ExecutorParam {
  const PvfExecTimeout(
    this.value0,
    this.value1,
  );

  factory PvfExecTimeout._decode(_i1.Input input) {
    return PvfExecTimeout(
      _i4.PvfExecKind.codec.decode(input),
      _i1.U64Codec.codec.decode(input),
    );
  }

  /// PvfExecKind
  final _i4.PvfExecKind value0;

  /// u64
  final BigInt value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'PvfExecTimeout': [
          value0.toJson(),
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.PvfExecKind.codec.sizeHint(value0);
    size = size + _i1.U64Codec.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i4.PvfExecKind.codec.encodeTo(
      value0,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
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
      other is PvfExecTimeout &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class WasmExtBulkMemory extends ExecutorParam {
  const WasmExtBulkMemory();

  @override
  Map<String, dynamic> toJson() => {'WasmExtBulkMemory': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is WasmExtBulkMemory;

  @override
  int get hashCode => runtimeType.hashCode;
}
