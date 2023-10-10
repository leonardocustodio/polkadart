// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_primitives/v4/parathread_entry.dart' as _i2;

class QueuedParathread {
  const QueuedParathread({
    required this.claim,
    required this.coreOffset,
  });

  factory QueuedParathread.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// ParathreadEntry
  final _i2.ParathreadEntry claim;

  /// u32
  final int coreOffset;

  static const $QueuedParathreadCodec codec = $QueuedParathreadCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'claim': claim.toJson(),
        'coreOffset': coreOffset,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is QueuedParathread &&
          other.claim == claim &&
          other.coreOffset == coreOffset;

  @override
  int get hashCode => Object.hash(
        claim,
        coreOffset,
      );
}

class $QueuedParathreadCodec with _i1.Codec<QueuedParathread> {
  const $QueuedParathreadCodec();

  @override
  void encodeTo(
    QueuedParathread obj,
    _i1.Output output,
  ) {
    _i2.ParathreadEntry.codec.encodeTo(
      obj.claim,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.coreOffset,
      output,
    );
  }

  @override
  QueuedParathread decode(_i1.Input input) {
    return QueuedParathread(
      claim: _i2.ParathreadEntry.codec.decode(input),
      coreOffset: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(QueuedParathread obj) {
    int size = 0;
    size = size + _i2.ParathreadEntry.codec.sizeHint(obj.claim);
    size = size + _i1.U32Codec.codec.sizeHint(obj.coreOffset);
    return size;
  }
}
