// ignore_for_file: unused_local_variable

import 'package:polkadart/apis/apis.dart' show StateApi, Provider;
import 'package:polkadart/multisig/multisig_base.dart' show Multisig, MultisigAccount;
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;
import 'package:ss58/ss58.dart';
import 'package:substrate_metadata/chain/chain_info.dart' show ChainInfo;
import 'package:substrate_metadata/metadata/metadata.dart' show RuntimeMetadataPrefixed;

void main() async {
  //
  // Signatories: Friday1, Friday2, Friday3
  // These accounts are using `dev phrase`: 'bottom drive obey lake curtain smoke basket hold race lonely fit walk';
  final friday1 = await keyring.KeyPair.sr25519.fromUri('//Friday1');
  friday1.ss58Format = 42;

  final friday2 = await keyring.KeyPair.sr25519.fromUri('//Friday2');
  friday2.ss58Format = 42;

  final friday3 = await keyring.KeyPair.sr25519.fromUri('//Friday3');
  friday3.ss58Format = 42;

  // Recipient: FridayR
  final fridayR = await keyring.KeyPair.sr25519.fromUri('//FridayR');
  fridayR.ss58Format = 42;

  final provider = Provider.fromUri(Uri.parse('wss://westend-rpc.polkadot.io'));
  final RuntimeMetadataPrefixed runtimeMetadataPrefixed = await StateApi(provider).getMetadata();
  final ChainInfo chainInfo = runtimeMetadataPrefixed.buildChainInfo();

  final multisigAccount = MultisigAccount(
    addresses: [friday1.address, friday2.address, friday3.address],
    threshold: 2,
  );

  print(Address(prefix: 42, pubkey: multisigAccount.multisigPubkey).encode());

  final multisig = Multisig(
    provider: provider,
    chainInfo: chainInfo,
    multisigAccount: multisigAccount,
  );

  /// Create and Fund Multisig
  final fundResponse = await multisig.createAndFundMultisig(
    depositorAddress: friday1.address,
    signingCallback: friday1.sign,
    fundingAmount: BigInt.parse('100${'0' * 10}'), // 1.00 WND
  );

  // transfer to //FridayR using multisig
  final multisigResponse = await multisig.initiateTransfer(
    senderAddress: friday1.address,
    signingCallback: friday1.sign,
    recipientAddress: fridayR.address,
    keepAlive: false,
    transferAmount: BigInt.parse('50${'0' * 10}'), // 0.50 WND
  );

  // With threshold of 2, the second approval is the final one and must use asMulti
  final finalApproval = await multisig.asMulti(
    callData: multisigResponse.callData,
    approverAddress: friday2.address,
    signingCallback: friday2.sign,
  );
}
