import 'package:polkadart/polkadart.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;

void main() async {
  //
  // Signatories: MadisonS1, MadisonS2, MadisonS3
  //
  final madisonS1 = await keyring.KeyPair.sr25519.fromUri('//MadisonS1');
  print(madisonS1.address);

  final madisonS2 = await keyring.KeyPair.sr25519.fromUri('//MadisonS2');
  print(madisonS2.address);

  final madisonS3 = await keyring.KeyPair.sr25519.fromUri('//MadisonS3');
  print(madisonS3.address);

  // Recipient: MadisonR
  final madisonR = await keyring.KeyPair.sr25519.fromUri('//MadisonR');
  print(madisonR.address);

  final provider = Provider.fromUri(Uri.parse('wss://westend-rpc.polkadot.io'));

  final Multisig multiSig = Multisig(
    ownerKeypair: madisonS1,
    otherSignatoriesAddressList: [madisonS2.address, madisonS3.address],
    threshold: 2,
    recipientAddress: madisonR.address,
    amount: BigInt.from(12000000000),
    provider: provider,
  );

  multiSig.initiateMultiSig();
}
