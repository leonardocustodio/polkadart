// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_parachain_primitives/primitives/id.dart' as _i3;
import '../../../polkadot_primitives/v7/core_index.dart' as _i4;

abstract class Assignment {
  const Assignment();

  factory Assignment.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AssignmentCodec codec = $AssignmentCodec();

  static const $Assignment values = $Assignment();

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

class $Assignment {
  const $Assignment();

  Pool pool({
    required _i3.Id paraId,
    required _i4.CoreIndex coreIndex,
  }) {
    return Pool(
      paraId: paraId,
      coreIndex: coreIndex,
    );
  }

  Bulk bulk(_i3.Id value0) {
    return Bulk(value0);
  }
}

class $AssignmentCodec with _i1.Codec<Assignment> {
  const $AssignmentCodec();

  @override
  Assignment decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Pool._decode(input);
      case 1:
        return Bulk._decode(input);
      default:
        throw Exception('Assignment: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Assignment value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Pool:
        (value as Pool).encodeTo(output);
        break;
      case Bulk:
        (value as Bulk).encodeTo(output);
        break;
      default:
        throw Exception(
            'Assignment: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Assignment value) {
    switch (value.runtimeType) {
      case Pool:
        return (value as Pool)._sizeHint();
      case Bulk:
        return (value as Bulk)._sizeHint();
      default:
        throw Exception(
            'Assignment: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Pool extends Assignment {
  const Pool({
    required this.paraId,
    required this.coreIndex,
  });

  factory Pool._decode(_i1.Input input) {
    return Pool(
      paraId: _i1.U32Codec.codec.decode(input),
      coreIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id paraId;

  /// CoreIndex
  final _i4.CoreIndex coreIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Pool': {
          'paraId': paraId,
          'coreIndex': coreIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    size = size + const _i4.CoreIndexCodec().sizeHint(coreIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      coreIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Pool && other.paraId == paraId && other.coreIndex == coreIndex;

  @override
  int get hashCode => Object.hash(
        paraId,
        coreIndex,
      );
}

class Bulk extends Assignment {
  const Bulk(this.value0);

  factory Bulk._decode(_i1.Input input) {
    return Bulk(_i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id value0;

  @override
  Map<String, int> toJson() => {'Bulk': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
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
      other is Bulk && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
