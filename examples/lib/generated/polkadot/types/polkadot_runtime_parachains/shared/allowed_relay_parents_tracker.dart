// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../primitive_types/h256.dart' as _i3;
import '../../tuples.dart' as _i2;

class AllowedRelayParentsTracker {
  const AllowedRelayParentsTracker({
    required this.buffer,
    required this.latestNumber,
  });

  factory AllowedRelayParentsTracker.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// VecDeque<(Hash, Hash)>
  final List<_i2.Tuple2<_i3.H256, _i3.H256>> buffer;

  /// BlockNumber
  final int latestNumber;

  static const $AllowedRelayParentsTrackerCodec codec =
      $AllowedRelayParentsTrackerCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'buffer': buffer
            .map((value) => [
                  value.value0.toList(),
                  value.value1.toList(),
                ])
            .toList(),
        'latestNumber': latestNumber,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AllowedRelayParentsTracker &&
          _i5.listsEqual(
            other.buffer,
            buffer,
          ) &&
          other.latestNumber == latestNumber;

  @override
  int get hashCode => Object.hash(
        buffer,
        latestNumber,
      );
}

class $AllowedRelayParentsTrackerCodec
    with _i1.Codec<AllowedRelayParentsTracker> {
  const $AllowedRelayParentsTrackerCodec();

  @override
  void encodeTo(
    AllowedRelayParentsTracker obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.Tuple2<_i3.H256, _i3.H256>>(
        _i2.Tuple2Codec<_i3.H256, _i3.H256>(
      _i3.H256Codec(),
      _i3.H256Codec(),
    )).encodeTo(
      obj.buffer,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.latestNumber,
      output,
    );
  }

  @override
  AllowedRelayParentsTracker decode(_i1.Input input) {
    return AllowedRelayParentsTracker(
      buffer: const _i1.SequenceCodec<_i2.Tuple2<_i3.H256, _i3.H256>>(
          _i2.Tuple2Codec<_i3.H256, _i3.H256>(
        _i3.H256Codec(),
        _i3.H256Codec(),
      )).decode(input),
      latestNumber: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AllowedRelayParentsTracker obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<_i3.H256, _i3.H256>>(
            _i2.Tuple2Codec<_i3.H256, _i3.H256>(
          _i3.H256Codec(),
          _i3.H256Codec(),
        )).sizeHint(obj.buffer);
    size = size + _i1.U32Codec.codec.sizeHint(obj.latestNumber);
    return size;
  }
}
