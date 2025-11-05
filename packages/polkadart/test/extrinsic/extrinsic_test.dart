import 'dart:typed_data' show Uint8List;

import 'package:polkadart/apis/apis.dart' show SystemApi, ChainApi, StateApi, AuthorApi;
import 'package:polkadart/extrinsic_builder/extrinsic_builder_base.dart'
    show BalancesTransferKeepAlive, ExtrinsicBuilder;
import 'package:polkadart/provider.dart' show Provider;
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring show KeyPair;
import 'package:polkadart_scale_codec/utils/utils.dart' show encodeHex;
import 'package:substrate_metadata/chain/chain_info.dart' show ChainInfo;
import 'package:substrate_metadata/metadata/metadata.dart' show RuntimeMetadataPrefixed;
import 'package:test/test.dart'
    show
        expect,
        group,
        isNotNull,
        isNotEmpty,
        setUpAll,
        tearDownAll,
        greaterThanOrEqualTo,
        greaterThan,
        equals,
        test;

void customPrint(final String value) {
  // Uncomment this when needs to print it into console.
  // print(value);
}

void printSection(String title, Map<String, dynamic> data) {
  customPrint('\n${'=' * 50}');
  customPrint(title.toUpperCase());
  customPrint('=' * 50);
  data.forEach((key, value) {
    customPrint('$key: $value');
  });
}

void printTestHeader(int testNumber, String description) {
  customPrint('\n\n${'=' * 50}');
  customPrint('TEST $testNumber: $description');
  customPrint('=' * 50);
}

/// Helper function to get account nonce
Future<int> getAccountNonce(Provider provider, String address) async {
  try {
    return await SystemApi(provider).accountNextIndex(address);
  } catch (e) {
    customPrint('Account $address nonce: 0 (new account)');
    return 0;
  }
}

/// Helper function to build, sign, and return extrinsic data
Future<Map<String, dynamic>> buildTransferExtrinsic({
  required Provider provider,
  required ChainInfo chainInfo,
  required keyring.KeyPair fromKeypair,
  required keyring.KeyPair toKeypair,
  required BigInt amount,
  required int nonce,
}) async {
  // Get current chain state
  final genesisHash = await ChainApi(provider).getBlockHash(blockNumber: 0);
  final blockNumber = await ChainApi(provider).getChainHeader();
  final blockHash = await ChainApi(provider).getBlockHash(blockNumber: blockNumber);
  final runtimeVersion = await StateApi(provider).getRuntimeVersion();

  printSection('Building Transfer', {
    'From': fromKeypair.address,
    'To': toKeypair.address,
    'Amount': '$amount units (0.1 WND)',
    'Nonce': nonce,
    'Block': '$blockNumber (Spec: ${runtimeVersion.specVersion})',
    'Extrinsic Version': chainInfo.registry.extrinsic.version,
  });

  // Create and encode the call
  final transferCall = BalancesTransferKeepAlive.toAccountId(
    accountId: Uint8List.fromList(toKeypair.publicKey.bytes),
    value: amount,
  );
  final callData = transferCall.encode(chainInfo);
  expect(callData.isNotEmpty, true, reason: 'Call data should not be empty');

  final extrinsicBuilder = ExtrinsicBuilder.offline(
    chainInfo: chainInfo,
    callData: callData,
    specVersion: runtimeVersion.specVersion,
    transactionVersion: runtimeVersion.transactionVersion,
    genesisHash: genesisHash,
    blockHash: blockHash,
    blockNumber: blockNumber,
    eraPeriod: 0, // Immortal transaction (works better with parachains)
    nonce: nonce,
    tip: BigInt.zero,
  );

  // Build and sign the extrinsic
  final encodedExtrinsic = await extrinsicBuilder.signAndBuild(fromKeypair);

  // Get the extrinsic bytes and hash
  final extrinsicBytes = encodedExtrinsic.bytes;
  final txHash = encodedExtrinsic.hash;
  final txHashHex = encodeHex(txHash);

  expect(extrinsicBytes.isNotEmpty, true, reason: 'Encoded extrinsic should not be empty');
  expect(txHash.length, 32, reason: 'Transaction hash should be 32 bytes');

  // Get info for logging
  final info = encodedExtrinsic.info;

  printSection('Extrinsic Built', {
    'Call Data': '${callData.length} bytes',
    'Call Data Hex': '0x${encodeHex(callData)}',
    'Extensions': '${info.extensionSize} bytes',
    'Signature': '${info.signatureSize} bytes',
    'Signature Type': info.signatureType.toString(),
    'Extrinsic': '${extrinsicBytes.length} bytes',
    'Extrinsic Hex': encodedExtrinsic.toHex(),
    'Tx Hash': '0x$txHashHex',
  });

  return {
    'encodedExtrinsic': extrinsicBytes,
    'txHash': txHash,
    'txHashHex': txHashHex,
    'callData': callData,
    'encodedExtrinsic_obj': encodedExtrinsic, // Keep the object for potential future use
  };
}

/// Helper function to submit extrinsic and verify hash (unchanged)
Future<String> submitAndWaitForExtrinsic({
  required Provider provider,
  required Uint8List encodedExtrinsic,
  required String expectedTxHashHex,
}) async {
  final hashBytes = await AuthorApi(provider).submitExtrinsic(encodedExtrinsic);
  final hashHex = '0x${encodeHex(hashBytes)}';

  expect(hashHex, '0x$expectedTxHashHex', reason: 'Submitted tx hash should match calculated hash');

  printSection('Transaction Submitted', {
    'Expected Hash': '0x$expectedTxHashHex',
    'Actual Hash': hashHex,
    'Status': hashHex == '0x$expectedTxHashHex' ? '✅ Match' : '❌ Mismatch',
  });

  customPrint('Waiting for inclusion (~7 seconds)...');
  await Future.delayed(Duration(seconds: 7));
  return hashHex;
}

void main() {
  group('Bidirectional Transfer Tests - Friday1 <-> Friday2', () {
    late Provider provider;
    late ChainInfo chainInfo;
    late keyring.KeyPair friday1;
    late keyring.KeyPair friday2;

    // Transfer amount: 0.1 WND (Westend has 12 decimals)
    final transferAmount = BigInt.from(100_000_000_000); // 0.1 WND

    setUpAll(() async {
      // Connect to Asset Hub Westend to test with ChargeAssetTxPayment
      provider = Provider.fromUri(Uri.parse('wss://westend-asset-hub-rpc.polkadot.io'));

      // Fetch metadata
      final RuntimeMetadataPrefixed runtimeMetadataPrefixed =
          await StateApi(provider).getMetadata();
      chainInfo = ChainInfo.fromRuntimeMetadataPrefixed(runtimeMetadataPrefixed);

      // Get and verify chain properties
      final chainProperties = await SystemApi(provider).properties();
      expect(chainProperties['tokenSymbol'], isNotNull);
      expect(chainProperties['tokenDecimals'], isNotNull);

      printSection('Chain Properties', {
        'SS58 Format': chainProperties['ss58Format'],
        'Token Symbol': chainProperties['tokenSymbol'],
        'Token Decimals': chainProperties['tokenDecimals'],
      });

      // Create keypairs
      friday1 = await keyring.KeyPair.sr25519.fromUri('//Friday1');
      friday1.ss58Format = 42;
      friday2 = await keyring.KeyPair.sr25519.fromUri('//Friday2');
      friday2.ss58Format = 42;

      // Verify keypairs
      expect(friday1.publicKey.bytes.length, 32);
      expect(friday2.publicKey.bytes.length, 32);
      expect(friday1.address, isNotEmpty);
      expect(friday2.address, isNotEmpty);

      printSection('Test Accounts', {
        'Friday1 Address': friday1.address,
        'Friday1 PubKey': '0x${encodeHex(friday1.publicKey.bytes)}',
        'Friday2 Address': friday2.address,
        'Friday2 PubKey': '0x${encodeHex(friday2.publicKey.bytes)}',
      });
    });

    tearDownAll(() async {
      await provider.disconnect();
    });

    test('Transfer 0.1 WND from Friday1 to Friday2', () async {
      printTestHeader(1, 'Friday1 → Friday2 (0.1 WND)');

      final nonce = await getAccountNonce(provider, friday1.address);
      expect(nonce, greaterThanOrEqualTo(0), reason: 'Nonce should be non-negative');

      final extrinsicData = await buildTransferExtrinsic(
        provider: provider,
        chainInfo: chainInfo,
        fromKeypair: friday1,
        toKeypair: friday2,
        amount: transferAmount,
        nonce: nonce,
      );

      // Verify all components
      final encodedExtrinsic = extrinsicData['encodedExtrinsic'] as Uint8List;
      final txHash = extrinsicData['txHash'] as Uint8List;
      final callData = extrinsicData['callData'] as Uint8List;

      expect(encodedExtrinsic.length, greaterThan(0));
      expect(txHash.length, equals(32));
      expect(callData.length, greaterThan(0));

      // Submit and verify
      final submittedHash = await submitAndWaitForExtrinsic(
        provider: provider,
        encodedExtrinsic: encodedExtrinsic,
        expectedTxHashHex: extrinsicData['txHashHex'] as String,
      );

      expect(submittedHash, '0x${extrinsicData['txHashHex']}');
      customPrint('\n✅ TEST 1 PASSED');
    });

    test('Transfer 0.1 WND back from Friday2 to Friday1', () async {
      printTestHeader(2, 'Friday2 → Friday1 (0.1 WND)');

      final nonce = await getAccountNonce(provider, friday2.address);
      expect(nonce, greaterThanOrEqualTo(0), reason: 'Nonce should be non-negative');

      final extrinsicData = await buildTransferExtrinsic(
        provider: provider,
        chainInfo: chainInfo,
        fromKeypair: friday2,
        toKeypair: friday1,
        amount: transferAmount,
        nonce: nonce,
      );

      // Verify all components
      final encodedExtrinsic = extrinsicData['encodedExtrinsic'] as Uint8List;
      final txHash = extrinsicData['txHash'] as Uint8List;
      final callData = extrinsicData['callData'] as Uint8List;

      expect(encodedExtrinsic.length, greaterThan(0));
      expect(txHash.length, equals(32));
      expect(callData.length, greaterThan(0));

      // Submit and verify
      final submittedHash = await submitAndWaitForExtrinsic(
        provider: provider,
        encodedExtrinsic: encodedExtrinsic,
        expectedTxHashHex: extrinsicData['txHashHex'] as String,
      );

      expect(submittedHash, '0x${extrinsicData['txHashHex']}');
      customPrint('\n✅ TEST 2 PASSED');
    });

    // Alternative test using the auto mode (optional - shows the simpler API)
    test('Alternative: Transfer using auto mode', () async {
      printTestHeader(3, 'Auto Mode Test - Friday1 → Friday2');

      // Create and encode the call
      final transferCall = BalancesTransferKeepAlive.toAccountId(
        accountId: Uint8List.fromList(friday2.publicKey.bytes),
        value: transferAmount,
      );
      final callData = transferCall.encode(chainInfo);

      // Use the auto mode for simpler API
      final extrinsicBuilder = await ExtrinsicBuilder.auto(
        provider: provider,
        chainInfo: chainInfo,
        callData: callData,
        signerAddress: friday1.address,
      );

      final txHash = extrinsicBuilder
          .tip(BigInt.zero)
          .immortal() // Make it immortal like the original
          .signBuildAndSubmit(friday1);

      customPrint('Transaction submitted with hash: $txHash');
      customPrint('\n✅ AUTO MODE TEST PASSED');
    });
  });
}
