// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'parathread_claim.dart' as _i2;

class ParathreadEntry {
  const ParathreadEntry({
    required this.claim,
    required this.retries,
  });

  factory ParathreadEntry.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// ParathreadClaim
  final _i2.ParathreadClaim claim;

  /// u32
  final int retries;

  static const $ParathreadEntryCodec codec = $ParathreadEntryCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'claim': claim.toJson(),
        'retries': retries,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ParathreadEntry &&
          other.claim == claim &&
          other.retries == retries;

  @override
  int get hashCode => Object.hash(
        claim,
        retries,
      );
}

class $ParathreadEntryCodec with _i1.Codec<ParathreadEntry> {
  const $ParathreadEntryCodec();

  @override
  void encodeTo(
    ParathreadEntry obj,
    _i1.Output output,
  ) {
    _i2.ParathreadClaim.codec.encodeTo(
      obj.claim,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.retries,
      output,
    );
  }

  @override
  ParathreadEntry decode(_i1.Input input) {
    return ParathreadEntry(
      claim: _i2.ParathreadClaim.codec.decode(input),
      retries: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ParathreadEntry obj) {
    int size = 0;
    size = size + _i2.ParathreadClaim.codec.sizeHint(obj.claim);
    size = size + _i1.U32Codec.codec.sizeHint(obj.retries);
    return size;
  }
}
