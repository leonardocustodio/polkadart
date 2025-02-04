// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class SolutionOrSnapshotSize {
  const SolutionOrSnapshotSize({
    required this.voters,
    required this.targets,
  });

  factory SolutionOrSnapshotSize.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final BigInt voters;

  /// u32
  final BigInt targets;

  static const $SolutionOrSnapshotSizeCodec codec =
      $SolutionOrSnapshotSizeCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'voters': voters,
        'targets': targets,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SolutionOrSnapshotSize &&
          other.voters == voters &&
          other.targets == targets;

  @override
  int get hashCode => Object.hash(
        voters,
        targets,
      );
}

class $SolutionOrSnapshotSizeCodec with _i1.Codec<SolutionOrSnapshotSize> {
  const $SolutionOrSnapshotSizeCodec();

  @override
  void encodeTo(
    SolutionOrSnapshotSize obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.voters,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.targets,
      output,
    );
  }

  @override
  SolutionOrSnapshotSize decode(_i1.Input input) {
    return SolutionOrSnapshotSize(
      voters: _i1.CompactBigIntCodec.codec.decode(input),
      targets: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(SolutionOrSnapshotSize obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.voters);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.targets);
    return size;
  }
}
