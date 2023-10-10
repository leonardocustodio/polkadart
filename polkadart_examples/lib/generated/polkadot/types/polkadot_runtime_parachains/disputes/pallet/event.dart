// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_core_primitives/candidate_hash.dart' as _i3;
import '../dispute_location.dart' as _i4;
import '../dispute_result.dart' as _i5;

///
///			The [event](https://docs.substrate.io/main-docs/build/events-errors/) emitted
///			by this pallet.
///
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

  DisputeInitiated disputeInitiated(
    _i3.CandidateHash value0,
    _i4.DisputeLocation value1,
  ) {
    return DisputeInitiated(
      value0,
      value1,
    );
  }

  DisputeConcluded disputeConcluded(
    _i3.CandidateHash value0,
    _i5.DisputeResult value1,
  ) {
    return DisputeConcluded(
      value0,
      value1,
    );
  }

  Revert revert(int value0) {
    return Revert(value0);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return DisputeInitiated._decode(input);
      case 1:
        return DisputeConcluded._decode(input);
      case 2:
        return Revert._decode(input);
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
      case DisputeInitiated:
        (value as DisputeInitiated).encodeTo(output);
        break;
      case DisputeConcluded:
        (value as DisputeConcluded).encodeTo(output);
        break;
      case Revert:
        (value as Revert).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case DisputeInitiated:
        return (value as DisputeInitiated)._sizeHint();
      case DisputeConcluded:
        return (value as DisputeConcluded)._sizeHint();
      case Revert:
        return (value as Revert)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A dispute has been initiated. \[candidate hash, dispute location\]
class DisputeInitiated extends Event {
  const DisputeInitiated(
    this.value0,
    this.value1,
  );

  factory DisputeInitiated._decode(_i1.Input input) {
    return DisputeInitiated(
      const _i1.U8ArrayCodec(32).decode(input),
      _i4.DisputeLocation.codec.decode(input),
    );
  }

  /// CandidateHash
  final _i3.CandidateHash value0;

  /// DisputeLocation
  final _i4.DisputeLocation value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'DisputeInitiated': [
          value0.toList(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.CandidateHashCodec().sizeHint(value0);
    size = size + _i4.DisputeLocation.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      value0,
      output,
    );
    _i4.DisputeLocation.codec.encodeTo(
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
      other is DisputeInitiated &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// A dispute has concluded for or against a candidate.
/// `\[para id, candidate hash, dispute result\]`
class DisputeConcluded extends Event {
  const DisputeConcluded(
    this.value0,
    this.value1,
  );

  factory DisputeConcluded._decode(_i1.Input input) {
    return DisputeConcluded(
      const _i1.U8ArrayCodec(32).decode(input),
      _i5.DisputeResult.codec.decode(input),
    );
  }

  /// CandidateHash
  final _i3.CandidateHash value0;

  /// DisputeResult
  final _i5.DisputeResult value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'DisputeConcluded': [
          value0.toList(),
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.CandidateHashCodec().sizeHint(value0);
    size = size + _i5.DisputeResult.codec.sizeHint(value1);
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
    _i5.DisputeResult.codec.encodeTo(
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
      other is DisputeConcluded &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// A dispute has concluded with supermajority against a candidate.
/// Block authors should no longer build on top of this head and should
/// instead revert the block at the given height. This should be the
/// number of the child of the last known valid block in the chain.
class Revert extends Event {
  const Revert(this.value0);

  factory Revert._decode(_i1.Input input) {
    return Revert(_i1.U32Codec.codec.decode(input));
  }

  /// T::BlockNumber
  final int value0;

  @override
  Map<String, int> toJson() => {'Revert': value0};

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
      other is Revert && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
