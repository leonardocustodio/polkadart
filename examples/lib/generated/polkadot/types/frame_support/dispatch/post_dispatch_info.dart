// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_weights/weight_v2/weight.dart' as _i2;
import 'pays.dart' as _i3;

class PostDispatchInfo {
  const PostDispatchInfo({
    this.actualWeight,
    required this.paysFee,
  });

  factory PostDispatchInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Option<Weight>
  final _i2.Weight? actualWeight;

  /// Pays
  final _i3.Pays paysFee;

  static const $PostDispatchInfoCodec codec = $PostDispatchInfoCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'actualWeight': actualWeight?.toJson(),
        'paysFee': paysFee.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PostDispatchInfo &&
          other.actualWeight == actualWeight &&
          other.paysFee == paysFee;

  @override
  int get hashCode => Object.hash(
        actualWeight,
        paysFee,
      );
}

class $PostDispatchInfoCodec with _i1.Codec<PostDispatchInfo> {
  const $PostDispatchInfoCodec();

  @override
  void encodeTo(
    PostDispatchInfo obj,
    _i1.Output output,
  ) {
    const _i1.OptionCodec<_i2.Weight>(_i2.Weight.codec).encodeTo(
      obj.actualWeight,
      output,
    );
    _i3.Pays.codec.encodeTo(
      obj.paysFee,
      output,
    );
  }

  @override
  PostDispatchInfo decode(_i1.Input input) {
    return PostDispatchInfo(
      actualWeight:
          const _i1.OptionCodec<_i2.Weight>(_i2.Weight.codec).decode(input),
      paysFee: _i3.Pays.codec.decode(input),
    );
  }

  @override
  int sizeHint(PostDispatchInfo obj) {
    int size = 0;
    size = size +
        const _i1.OptionCodec<_i2.Weight>(_i2.Weight.codec)
            .sizeHint(obj.actualWeight);
    size = size + _i3.Pays.codec.sizeHint(obj.paysFee);
    return size;
  }
}
