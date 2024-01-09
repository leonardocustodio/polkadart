import 'package:polkadart/extrinsic/signed_extensions/asset_hub.dart';
import 'package:polkadart/extrinsic/signed_extensions/substrate.dart';

abstract class SignedExtensions {
  static AssetHubSignedExtensions get assetHubSignedExtensions =>
      AssetHubSignedExtensions();
  static SubstrateSignedExtensions get substrateSignedExtensions =>
      SubstrateSignedExtensions();

  String signedExtension(String extension, Map info);
  String additionalSignedExtension(String extension, Map info);
}
