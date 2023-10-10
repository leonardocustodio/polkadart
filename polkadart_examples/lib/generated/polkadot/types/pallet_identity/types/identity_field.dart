// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum IdentityField {
  display('Display', 1),
  legal('Legal', 2),
  web('Web', 4),
  riot('Riot', 8),
  email('Email', 16),
  pgpFingerprint('PgpFingerprint', 32),
  image('Image', 64),
  twitter('Twitter', 128);

  const IdentityField(
    this.variantName,
    this.codecIndex,
  );

  factory IdentityField.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $IdentityFieldCodec codec = $IdentityFieldCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $IdentityFieldCodec with _i1.Codec<IdentityField> {
  const $IdentityFieldCodec();

  @override
  IdentityField decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return IdentityField.display;
      case 2:
        return IdentityField.legal;
      case 4:
        return IdentityField.web;
      case 8:
        return IdentityField.riot;
      case 16:
        return IdentityField.email;
      case 32:
        return IdentityField.pgpFingerprint;
      case 64:
        return IdentityField.image;
      case 128:
        return IdentityField.twitter;
      default:
        throw Exception('IdentityField: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    IdentityField value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
