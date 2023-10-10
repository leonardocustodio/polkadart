// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum ClaimPermission {
  permissioned('Permissioned', 0),
  permissionlessCompound('PermissionlessCompound', 1),
  permissionlessWithdraw('PermissionlessWithdraw', 2),
  permissionlessAll('PermissionlessAll', 3);

  const ClaimPermission(
    this.variantName,
    this.codecIndex,
  );

  factory ClaimPermission.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ClaimPermissionCodec codec = $ClaimPermissionCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ClaimPermissionCodec with _i1.Codec<ClaimPermission> {
  const $ClaimPermissionCodec();

  @override
  ClaimPermission decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ClaimPermission.permissioned;
      case 1:
        return ClaimPermission.permissionlessCompound;
      case 2:
        return ClaimPermission.permissionlessWithdraw;
      case 3:
        return ClaimPermission.permissionlessAll;
      default:
        throw Exception('ClaimPermission: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ClaimPermission value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
