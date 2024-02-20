# Polkadart

Provides a clean wrapper around all the methods exposed by a Polkadot/Substrate network client and defines all the types exposed by a node.

## Usage

```dart
import 'package:polkadart/polkadart.dart' show Provider, StateApi;

void main() async {
  final polkadot = Provider(Uri.parse('wss://rpc.polkadot.io'));
  final api = StateApi(polkadot);
  final runtimeVersion = await api.getRuntimeVersion();
  print(runtimeVersion.toJson());
  await polkadot.disconnect();
}
```

## Multisig

### Initiate Multisig (Create and Fund)

```dart
  final provider = Provider.fromUri(Uri.parse('wss://westend-rpc.polkadot.io'));

  // Signatory 1
  final keypairS1 = await keyring.KeyPair.sr25519.fromUri('//keypairS1');

  // Signatory 2
  final signatory2Address = '5Cp4.......';

  // Signatory 3
  final signatory3Address = '5Dt2.......';

  // Recipient's Address
  final recipientAddress = '5Fq3.......';

  ///
  /// Create and Fund Multisig
  final multiSigResponse = await Multisig.createAndFundMultisig(
    depositorKeyPair: keypairS1,
    otherSignatoriesAddressList: [signatory2Address, signatory3Address],
    threshold: 2,
    recipientAddress: recipientAddress,
    amount: BigInt.parse('7000000000000'), // 7 WND ~ (tokenDecimals: 12)
    provider: provider,
  );

  // Json Response for forwarding to other signatories.
  final json = multiSigResponse.toJson();

```

### ApproveAsMulti
#### Used to approve the multisig call and then it waits for other singatories to approve.

```dart
  // Signatory 2
  final keypairS2 = await keyring.KeyPair.sr25519.fromUri('//keypairS2');

  // Json for forwarding to other signatories.
  final json = multiSigResponse.toJson();

  // Assuming keypairS2 is the first signatory who is approving.
  final localResponse = MultisigResponse.fromJson(json);

  // Waiting for approx 15 seconds for the transaction to be included in the block.
  await Future.delayed(Duration(seconds: 15));

  // Approve this call by keypairS2 and wait on further approval.
  await localResponse.approveAsMulti(provider, keypairS2);

```

### AsMulti
#### Used to do the final approval of the multisig call and execute the transaction if the threshold is met.

```dart
  // Signatory 3
  // Assuming keypairS3 is the first signatory who is approving.
  final keypairS3 = await keyring.KeyPair.sr25519.fromUri('//keypairS3');

  // Json for forwarding to other signatories.
  final json = multiSigResponse.toJson();

  final localResponse = MultisigResponse.fromJson(json);

  // Waiting for approx 15 seconds for the transaction to be included in the block.
  await Future.delayed(Duration(seconds: 15));

  // Approve this call by keypairS3 and execute the transaction if the threshold is met
  await localResponse.asMulti(provider, keypairS3);
```

### cancelAsMulti
#### Used to do cancel the multisig call.

```dart
  // Signatory 1
  // Assuming keypairS1 is the first signatory who is approving.
  final keypairS1 = await keyring.KeyPair.sr25519.fromUri('//keypairS1');

  // Json for forwarding to other signatories.
  final json = multiSigResponse.toJson();

  final localResponse = MultisigResponse.fromJson(json);

  // Waiting for approx 15 seconds for the transaction to be included in the block.
  await Future.delayed(Duration(seconds: 15));

  // Approve this call by keypairS1 and execute the transaction if the threshold is met
  await localResponse.asMulti(provider, keypairS1);
```

## Tutorials

Looking for tutorials to get started? Look at [example](./example) for guides on how to use the API to make queries and submit transactions.
