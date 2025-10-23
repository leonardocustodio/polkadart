part of metadata;

/// Deprecation information for pallets, calls, events, constants, etc. (new in V16)
class DeprecationInfo {
  /// Deprecation message/note
  final String note;

  /// Since version (optional)
  final String? since;

  const DeprecationInfo({
    required this.note,
    this.since,
  });

  static const $DeprecationInfo codec = $DeprecationInfo._();

  Map<String, dynamic> toJson() => {
        'note': note,
        if (since != null) 'since': since,
      };
}

class $DeprecationInfo with Codec<DeprecationInfo> {
  const $DeprecationInfo._();

  @override
  DeprecationInfo decode(Input input) {
    final note = StrCodec.codec.decode(input);
    final hasSince = BoolCodec.codec.decode(input);
    final since = hasSince ? StrCodec.codec.decode(input) : null;

    return DeprecationInfo(
      note: note,
      since: since,
    );
  }

  @override
  void encodeTo(DeprecationInfo value, Output output) {
    StrCodec.codec.encodeTo(value.note, output);
    BoolCodec.codec.encodeTo(value.since != null, output);
    if (value.since != null) {
      StrCodec.codec.encodeTo(value.since!, output);
    }
  }

  @override
  int sizeHint(DeprecationInfo value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.note);
    size += BoolCodec.codec.sizeHint(value.since != null);
    if (value.since != null) {
      size += StrCodec.codec.sizeHint(value.since!);
    }
    return size;
  }
}
