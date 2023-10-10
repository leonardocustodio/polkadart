// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../tuples.dart' as _i2;
import 'data.dart' as _i3;

class IdentityInfo {
  const IdentityInfo({
    required this.additional,
    required this.display,
    required this.legal,
    required this.web,
    required this.riot,
    required this.email,
    this.pgpFingerprint,
    required this.image,
    required this.twitter,
  });

  factory IdentityInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BoundedVec<(Data, Data), FieldLimit>
  final List<_i2.Tuple2<_i3.Data, _i3.Data>> additional;

  /// Data
  final _i3.Data display;

  /// Data
  final _i3.Data legal;

  /// Data
  final _i3.Data web;

  /// Data
  final _i3.Data riot;

  /// Data
  final _i3.Data email;

  /// Option<[u8; 20]>
  final List<int>? pgpFingerprint;

  /// Data
  final _i3.Data image;

  /// Data
  final _i3.Data twitter;

  static const $IdentityInfoCodec codec = $IdentityInfoCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'additional': additional
            .map((value) => [
                  value.value0.toJson(),
                  value.value1.toJson(),
                ])
            .toList(),
        'display': display.toJson(),
        'legal': legal.toJson(),
        'web': web.toJson(),
        'riot': riot.toJson(),
        'email': email.toJson(),
        'pgpFingerprint': pgpFingerprint?.toList(),
        'image': image.toJson(),
        'twitter': twitter.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is IdentityInfo &&
          _i5.listsEqual(
            other.additional,
            additional,
          ) &&
          other.display == display &&
          other.legal == legal &&
          other.web == web &&
          other.riot == riot &&
          other.email == email &&
          other.pgpFingerprint == pgpFingerprint &&
          other.image == image &&
          other.twitter == twitter;

  @override
  int get hashCode => Object.hash(
        additional,
        display,
        legal,
        web,
        riot,
        email,
        pgpFingerprint,
        image,
        twitter,
      );
}

class $IdentityInfoCodec with _i1.Codec<IdentityInfo> {
  const $IdentityInfoCodec();

  @override
  void encodeTo(
    IdentityInfo obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.Tuple2<_i3.Data, _i3.Data>>(
        _i2.Tuple2Codec<_i3.Data, _i3.Data>(
      _i3.Data.codec,
      _i3.Data.codec,
    )).encodeTo(
      obj.additional,
      output,
    );
    _i3.Data.codec.encodeTo(
      obj.display,
      output,
    );
    _i3.Data.codec.encodeTo(
      obj.legal,
      output,
    );
    _i3.Data.codec.encodeTo(
      obj.web,
      output,
    );
    _i3.Data.codec.encodeTo(
      obj.riot,
      output,
    );
    _i3.Data.codec.encodeTo(
      obj.email,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(20)).encodeTo(
      obj.pgpFingerprint,
      output,
    );
    _i3.Data.codec.encodeTo(
      obj.image,
      output,
    );
    _i3.Data.codec.encodeTo(
      obj.twitter,
      output,
    );
  }

  @override
  IdentityInfo decode(_i1.Input input) {
    return IdentityInfo(
      additional: const _i1.SequenceCodec<_i2.Tuple2<_i3.Data, _i3.Data>>(
          _i2.Tuple2Codec<_i3.Data, _i3.Data>(
        _i3.Data.codec,
        _i3.Data.codec,
      )).decode(input),
      display: _i3.Data.codec.decode(input),
      legal: _i3.Data.codec.decode(input),
      web: _i3.Data.codec.decode(input),
      riot: _i3.Data.codec.decode(input),
      email: _i3.Data.codec.decode(input),
      pgpFingerprint:
          const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(20)).decode(input),
      image: _i3.Data.codec.decode(input),
      twitter: _i3.Data.codec.decode(input),
    );
  }

  @override
  int sizeHint(IdentityInfo obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<_i3.Data, _i3.Data>>(
            _i2.Tuple2Codec<_i3.Data, _i3.Data>(
          _i3.Data.codec,
          _i3.Data.codec,
        )).sizeHint(obj.additional);
    size = size + _i3.Data.codec.sizeHint(obj.display);
    size = size + _i3.Data.codec.sizeHint(obj.legal);
    size = size + _i3.Data.codec.sizeHint(obj.web);
    size = size + _i3.Data.codec.sizeHint(obj.riot);
    size = size + _i3.Data.codec.sizeHint(obj.email);
    size = size +
        const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(20))
            .sizeHint(obj.pgpFingerprint);
    size = size + _i3.Data.codec.sizeHint(obj.image);
    size = size + _i3.Data.codec.sizeHint(obj.twitter);
    return size;
  }
}
