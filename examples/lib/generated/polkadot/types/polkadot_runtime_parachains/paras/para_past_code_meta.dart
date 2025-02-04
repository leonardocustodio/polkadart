// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import 'replacement_times.dart' as _i2;

class ParaPastCodeMeta {
  const ParaPastCodeMeta({
    required this.upgradeTimes,
    this.lastPruned,
  });

  factory ParaPastCodeMeta.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<ReplacementTimes<N>>
  final List<_i2.ReplacementTimes> upgradeTimes;

  /// Option<N>
  final int? lastPruned;

  static const $ParaPastCodeMetaCodec codec = $ParaPastCodeMetaCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'upgradeTimes': upgradeTimes.map((value) => value.toJson()).toList(),
        'lastPruned': lastPruned,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ParaPastCodeMeta &&
          _i4.listsEqual(
            other.upgradeTimes,
            upgradeTimes,
          ) &&
          other.lastPruned == lastPruned;

  @override
  int get hashCode => Object.hash(
        upgradeTimes,
        lastPruned,
      );
}

class $ParaPastCodeMetaCodec with _i1.Codec<ParaPastCodeMeta> {
  const $ParaPastCodeMetaCodec();

  @override
  void encodeTo(
    ParaPastCodeMeta obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.ReplacementTimes>(_i2.ReplacementTimes.codec)
        .encodeTo(
      obj.upgradeTimes,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.lastPruned,
      output,
    );
  }

  @override
  ParaPastCodeMeta decode(_i1.Input input) {
    return ParaPastCodeMeta(
      upgradeTimes: const _i1.SequenceCodec<_i2.ReplacementTimes>(
              _i2.ReplacementTimes.codec)
          .decode(input),
      lastPruned: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(ParaPastCodeMeta obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.ReplacementTimes>(
                _i2.ReplacementTimes.codec)
            .sizeHint(obj.upgradeTimes);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.lastPruned);
    return size;
  }
}
