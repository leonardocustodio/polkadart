// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_parachain/primitives/id.dart' as _i3;
import '../../polkadot_primitives/v4/core_index.dart' as _i2;
import '../../polkadot_primitives/v4/group_index.dart' as _i5;
import 'assignment_kind.dart' as _i4;

class CoreAssignment {
  const CoreAssignment({
    required this.core,
    required this.paraId,
    required this.kind,
    required this.groupIdx,
  });

  factory CoreAssignment.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CoreIndex
  final _i2.CoreIndex core;

  /// ParaId
  final _i3.Id paraId;

  /// AssignmentKind
  final _i4.AssignmentKind kind;

  /// GroupIndex
  final _i5.GroupIndex groupIdx;

  static const $CoreAssignmentCodec codec = $CoreAssignmentCodec();

  _i6.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'core': core,
        'paraId': paraId,
        'kind': kind.toJson(),
        'groupIdx': groupIdx,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CoreAssignment &&
          other.core == core &&
          other.paraId == paraId &&
          other.kind == kind &&
          other.groupIdx == groupIdx;

  @override
  int get hashCode => Object.hash(
        core,
        paraId,
        kind,
        groupIdx,
      );
}

class $CoreAssignmentCodec with _i1.Codec<CoreAssignment> {
  const $CoreAssignmentCodec();

  @override
  void encodeTo(
    CoreAssignment obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.core,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.paraId,
      output,
    );
    _i4.AssignmentKind.codec.encodeTo(
      obj.kind,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.groupIdx,
      output,
    );
  }

  @override
  CoreAssignment decode(_i1.Input input) {
    return CoreAssignment(
      core: _i1.U32Codec.codec.decode(input),
      paraId: _i1.U32Codec.codec.decode(input),
      kind: _i4.AssignmentKind.codec.decode(input),
      groupIdx: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CoreAssignment obj) {
    int size = 0;
    size = size + const _i2.CoreIndexCodec().sizeHint(obj.core);
    size = size + const _i3.IdCodec().sizeHint(obj.paraId);
    size = size + _i4.AssignmentKind.codec.sizeHint(obj.kind);
    size = size + const _i5.GroupIndexCodec().sizeHint(obj.groupIdx);
    return size;
  }
}
