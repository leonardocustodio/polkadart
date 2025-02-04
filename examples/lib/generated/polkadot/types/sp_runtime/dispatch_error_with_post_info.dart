// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../frame_support/dispatch/post_dispatch_info.dart' as _i2;
import 'dispatch_error.dart' as _i3;

class DispatchErrorWithPostInfo {
  const DispatchErrorWithPostInfo({
    required this.postInfo,
    required this.error,
  });

  factory DispatchErrorWithPostInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Info
  final _i2.PostDispatchInfo postInfo;

  /// DispatchError
  final _i3.DispatchError error;

  static const $DispatchErrorWithPostInfoCodec codec =
      $DispatchErrorWithPostInfoCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, dynamic>> toJson() => {
        'postInfo': postInfo.toJson(),
        'error': error.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DispatchErrorWithPostInfo &&
          other.postInfo == postInfo &&
          other.error == error;

  @override
  int get hashCode => Object.hash(
        postInfo,
        error,
      );
}

class $DispatchErrorWithPostInfoCodec
    with _i1.Codec<DispatchErrorWithPostInfo> {
  const $DispatchErrorWithPostInfoCodec();

  @override
  void encodeTo(
    DispatchErrorWithPostInfo obj,
    _i1.Output output,
  ) {
    _i2.PostDispatchInfo.codec.encodeTo(
      obj.postInfo,
      output,
    );
    _i3.DispatchError.codec.encodeTo(
      obj.error,
      output,
    );
  }

  @override
  DispatchErrorWithPostInfo decode(_i1.Input input) {
    return DispatchErrorWithPostInfo(
      postInfo: _i2.PostDispatchInfo.codec.decode(input),
      error: _i3.DispatchError.codec.decode(input),
    );
  }

  @override
  int sizeHint(DispatchErrorWithPostInfo obj) {
    int size = 0;
    size = size + _i2.PostDispatchInfo.codec.sizeHint(obj.postInfo);
    size = size + _i3.DispatchError.codec.sizeHint(obj.error);
    return size;
  }
}
