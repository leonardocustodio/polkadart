// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class DecidingStatus {
  const DecidingStatus({
    required this.since,
    this.confirming,
  });

  factory DecidingStatus.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BlockNumber
  final int since;

  /// Option<BlockNumber>
  final int? confirming;

  static const $DecidingStatusCodec codec = $DecidingStatusCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int?> toJson() => {
        'since': since,
        'confirming': confirming,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DecidingStatus &&
          other.since == since &&
          other.confirming == confirming;

  @override
  int get hashCode => Object.hash(
        since,
        confirming,
      );
}

class $DecidingStatusCodec with _i1.Codec<DecidingStatus> {
  const $DecidingStatusCodec();

  @override
  void encodeTo(
    DecidingStatus obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.since,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.confirming,
      output,
    );
  }

  @override
  DecidingStatus decode(_i1.Input input) {
    return DecidingStatus(
      since: _i1.U32Codec.codec.decode(input),
      confirming: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(DecidingStatus obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.since);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.confirming);
    return size;
  }
}
