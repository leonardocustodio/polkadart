// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// There are too many proxies registered or too many announcements pending.
  tooMany('TooMany', 0),

  /// Proxy registration not found.
  notFound('NotFound', 1),

  /// Sender is not a proxy of the account to be proxied.
  notProxy('NotProxy', 2),

  /// A call which is incompatible with the proxy type's filter was attempted.
  unproxyable('Unproxyable', 3),

  /// Account is already a proxy.
  duplicate('Duplicate', 4),

  /// Call may not be made by proxy because it may escalate its privileges.
  noPermission('NoPermission', 5),

  /// Announcement, if made at all, was made too recently.
  unannounced('Unannounced', 6),

  /// Cannot add self as proxy.
  noSelfProxy('NoSelfProxy', 7);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.tooMany;
      case 1:
        return Error.notFound;
      case 2:
        return Error.notProxy;
      case 3:
        return Error.unproxyable;
      case 4:
        return Error.duplicate;
      case 5:
        return Error.noPermission;
      case 6:
        return Error.unannounced;
      case 7:
        return Error.noSelfProxy;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
