// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class SlashingSpans {
  const SlashingSpans({
    required this.spanIndex,
    required this.lastStart,
    required this.lastNonzeroSlash,
    required this.prior,
  });

  factory SlashingSpans.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// SpanIndex
  final int spanIndex;

  /// EraIndex
  final int lastStart;

  /// EraIndex
  final int lastNonzeroSlash;

  /// Vec<EraIndex>
  final List<int> prior;

  static const $SlashingSpansCodec codec = $SlashingSpansCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'spanIndex': spanIndex,
        'lastStart': lastStart,
        'lastNonzeroSlash': lastNonzeroSlash,
        'prior': prior,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SlashingSpans &&
          other.spanIndex == spanIndex &&
          other.lastStart == lastStart &&
          other.lastNonzeroSlash == lastNonzeroSlash &&
          _i3.listsEqual(
            other.prior,
            prior,
          );

  @override
  int get hashCode => Object.hash(
        spanIndex,
        lastStart,
        lastNonzeroSlash,
        prior,
      );
}

class $SlashingSpansCodec with _i1.Codec<SlashingSpans> {
  const $SlashingSpansCodec();

  @override
  void encodeTo(
    SlashingSpans obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.spanIndex,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.lastStart,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.lastNonzeroSlash,
      output,
    );
    _i1.U32SequenceCodec.codec.encodeTo(
      obj.prior,
      output,
    );
  }

  @override
  SlashingSpans decode(_i1.Input input) {
    return SlashingSpans(
      spanIndex: _i1.U32Codec.codec.decode(input),
      lastStart: _i1.U32Codec.codec.decode(input),
      lastNonzeroSlash: _i1.U32Codec.codec.decode(input),
      prior: _i1.U32SequenceCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(SlashingSpans obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.spanIndex);
    size = size + _i1.U32Codec.codec.sizeHint(obj.lastStart);
    size = size + _i1.U32Codec.codec.sizeHint(obj.lastNonzeroSlash);
    size = size + _i1.U32SequenceCodec.codec.sizeHint(obj.prior);
    return size;
  }
}
