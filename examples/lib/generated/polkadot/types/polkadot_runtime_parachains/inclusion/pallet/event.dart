// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../../polkadot_parachain_primitives/primitives/head_data.dart'
    as _i4;
import '../../../polkadot_parachain_primitives/primitives/id.dart' as _i7;
import '../../../polkadot_primitives/v7/candidate_receipt.dart' as _i3;
import '../../../polkadot_primitives/v7/core_index.dart' as _i5;
import '../../../polkadot_primitives/v7/group_index.dart' as _i6;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  CandidateBacked candidateBacked(
    _i3.CandidateReceipt value0,
    _i4.HeadData value1,
    _i5.CoreIndex value2,
    _i6.GroupIndex value3,
  ) {
    return CandidateBacked(
      value0,
      value1,
      value2,
      value3,
    );
  }

  CandidateIncluded candidateIncluded(
    _i3.CandidateReceipt value0,
    _i4.HeadData value1,
    _i5.CoreIndex value2,
    _i6.GroupIndex value3,
  ) {
    return CandidateIncluded(
      value0,
      value1,
      value2,
      value3,
    );
  }

  CandidateTimedOut candidateTimedOut(
    _i3.CandidateReceipt value0,
    _i4.HeadData value1,
    _i5.CoreIndex value2,
  ) {
    return CandidateTimedOut(
      value0,
      value1,
      value2,
    );
  }

  UpwardMessagesReceived upwardMessagesReceived({
    required _i7.Id from,
    required int count,
  }) {
    return UpwardMessagesReceived(
      from: from,
      count: count,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return CandidateBacked._decode(input);
      case 1:
        return CandidateIncluded._decode(input);
      case 2:
        return CandidateTimedOut._decode(input);
      case 3:
        return UpwardMessagesReceived._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case CandidateBacked:
        (value as CandidateBacked).encodeTo(output);
        break;
      case CandidateIncluded:
        (value as CandidateIncluded).encodeTo(output);
        break;
      case CandidateTimedOut:
        (value as CandidateTimedOut).encodeTo(output);
        break;
      case UpwardMessagesReceived:
        (value as UpwardMessagesReceived).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case CandidateBacked:
        return (value as CandidateBacked)._sizeHint();
      case CandidateIncluded:
        return (value as CandidateIncluded)._sizeHint();
      case CandidateTimedOut:
        return (value as CandidateTimedOut)._sizeHint();
      case UpwardMessagesReceived:
        return (value as UpwardMessagesReceived)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A candidate was backed. `[candidate, head_data]`
class CandidateBacked extends Event {
  const CandidateBacked(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
  );

  factory CandidateBacked._decode(_i1.Input input) {
    return CandidateBacked(
      _i3.CandidateReceipt.codec.decode(input),
      _i1.U8SequenceCodec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// CandidateReceipt<T::Hash>
  final _i3.CandidateReceipt value0;

  /// HeadData
  final _i4.HeadData value1;

  /// CoreIndex
  final _i5.CoreIndex value2;

  /// GroupIndex
  final _i6.GroupIndex value3;

  @override
  Map<String, List<dynamic>> toJson() => {
        'CandidateBacked': [
          value0.toJson(),
          value1,
          value2,
          value3,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CandidateReceipt.codec.sizeHint(value0);
    size = size + const _i4.HeadDataCodec().sizeHint(value1);
    size = size + const _i5.CoreIndexCodec().sizeHint(value2);
    size = size + const _i6.GroupIndexCodec().sizeHint(value3);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.CandidateReceipt.codec.encodeTo(
      value0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is CandidateBacked &&
          other.value0 == value0 &&
          _i8.listsEqual(
            other.value1,
            value1,
          ) &&
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

/// A candidate was included. `[candidate, head_data]`
class CandidateIncluded extends Event {
  const CandidateIncluded(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
  );

  factory CandidateIncluded._decode(_i1.Input input) {
    return CandidateIncluded(
      _i3.CandidateReceipt.codec.decode(input),
      _i1.U8SequenceCodec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// CandidateReceipt<T::Hash>
  final _i3.CandidateReceipt value0;

  /// HeadData
  final _i4.HeadData value1;

  /// CoreIndex
  final _i5.CoreIndex value2;

  /// GroupIndex
  final _i6.GroupIndex value3;

  @override
  Map<String, List<dynamic>> toJson() => {
        'CandidateIncluded': [
          value0.toJson(),
          value1,
          value2,
          value3,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CandidateReceipt.codec.sizeHint(value0);
    size = size + const _i4.HeadDataCodec().sizeHint(value1);
    size = size + const _i5.CoreIndexCodec().sizeHint(value2);
    size = size + const _i6.GroupIndexCodec().sizeHint(value3);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.CandidateReceipt.codec.encodeTo(
      value0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is CandidateIncluded &&
          other.value0 == value0 &&
          _i8.listsEqual(
            other.value1,
            value1,
          ) &&
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

/// A candidate timed out. `[candidate, head_data]`
class CandidateTimedOut extends Event {
  const CandidateTimedOut(
    this.value0,
    this.value1,
    this.value2,
  );

  factory CandidateTimedOut._decode(_i1.Input input) {
    return CandidateTimedOut(
      _i3.CandidateReceipt.codec.decode(input),
      _i1.U8SequenceCodec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// CandidateReceipt<T::Hash>
  final _i3.CandidateReceipt value0;

  /// HeadData
  final _i4.HeadData value1;

  /// CoreIndex
  final _i5.CoreIndex value2;

  @override
  Map<String, List<dynamic>> toJson() => {
        'CandidateTimedOut': [
          value0.toJson(),
          value1,
          value2,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.CandidateReceipt.codec.sizeHint(value0);
    size = size + const _i4.HeadDataCodec().sizeHint(value1);
    size = size + const _i5.CoreIndexCodec().sizeHint(value2);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.CandidateReceipt.codec.encodeTo(
      value0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is CandidateTimedOut &&
          other.value0 == value0 &&
          _i8.listsEqual(
            other.value1,
            value1,
          ) &&
          other.value2 == value2;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
      );
}

/// Some upward messages have been received and will be processed.
class UpwardMessagesReceived extends Event {
  const UpwardMessagesReceived({
    required this.from,
    required this.count,
  });

  factory UpwardMessagesReceived._decode(_i1.Input input) {
    return UpwardMessagesReceived(
      from: _i1.U32Codec.codec.decode(input),
      count: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i7.Id from;

  /// u32
  final int count;

  @override
  Map<String, Map<String, int>> toJson() => {
        'UpwardMessagesReceived': {
          'from': from,
          'count': count,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i7.IdCodec().sizeHint(from);
    size = size + _i1.U32Codec.codec.sizeHint(count);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      from,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      count,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpwardMessagesReceived &&
          other.from == from &&
          other.count == count;

  @override
  int get hashCode => Object.hash(
        from,
        count,
      );
}
