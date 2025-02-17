import 'package:polkadart/extrinsic/signed_extensions/asset_hub.dart';
import 'package:polkadart/extrinsic/signed_extensions/substrate.dart';

abstract class SignedExtensions {
  static AssetHubSignedExtensions get assetHubSignedExtensions => AssetHubSignedExtensions();
  static SubstrateSignedExtensions get substrateSignedExtensions => SubstrateSignedExtensions();

  (String, bool) signedExtension(String extension, Map info);
  (String, bool) additionalSignedExtension(String extension, Map info);
}
