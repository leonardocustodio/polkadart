import 'package:convert/convert.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  group('Sr25519 Suri', () {
    late List<(String, String, String)> testVectors;

    setUp(() {
      const PHRASE =
          'bottom drive obey lake curtain smoke basket hold race lonely fit walk';
      testVectors = [
        // (seed, address, mnemonic)
        (
          '0x46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a',
          '5DfhGyQdFobKM8NsWvEeAKk5EQQgYe9AydgJ7rMB6E1EqRzV',
          PHRASE
        ),
        (
          '0xb69355deefa7a8f33e9297f5af22e680f03597a99d4f4b1c44be47e7a2275802',
          '5GC6LfpV352HtJPySfAecb5JdePtf4R9Vq49NUU8RhzgBqgq',
          '$PHRASE///password'
        ),
        (
          '0x40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a',
          '5DXZzrDxHbkQov4QBAY4TjpwnHCMrKXkomTnKSw8UArBEY5v',
          '$PHRASE/foo'
        ),
        (
          '0x547d4a55642ec7ebadc0bd29b6e570b8c926059b3c0655d4948075e9a7e6f31e',
          '5DyV6fZuvPemWrUqBgWwTSgoV86w6xms3KhkFU6cQcWxU8eP',
          '$PHRASE//foo'
        ),
        (
          '0x3841947ffcde6f5fef26fb68b59bb8665637e30e32ec2051f99cf6b9c674fe09',
          '5DLU27is5iViNopQb2KxsTyPx6j4vCu8X3sk3j3NNLkPCqKM',
          '$PHRASE//foo/bar'
        ),
        (
          '0xdc142f7476a7b0aa262aeccf207f1d18daa90762db393006741e8a31f39dbc53',
          '5H3GPTqDSpjkfDwbHy12PD6BWm8jvGSX4xYC8UMprHpTPcRg',
          '$PHRASE/foo//bar'
        ),
        (
          '0xa2e56b06407a6d1e819d2fc33fa0ec604b29c2e868b70b3696bb049b8725934b',
          '5FkHmNgbg64MwStgCyDi2Uw3ufFu11mqQgmWT9uwK4Lghvpv',
          '$PHRASE//foo/bar//42/69'
        ),
        (
          '0x0e0d24e3e1ff2c07f269c99e2e0df8681fda1851ac42fc846ca2daaa90cd8f14',
          '5CP8S23JBNXYNpJsL7ESPJBNnUZE6itcfM4EnDxEhaVEU6dT',
          '$PHRASE//foo/bar//42/69///password'
        ),
        (
          '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d',
          '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
          '$PHRASE//Alice'
        )
      ];
    });

    test('Test', () async {
      for (final (seed, address, uri) in testVectors) {
        final keypair = await KeyPair.sr25519.fromUri(uri);
        expect(keypair.address, address);
        expect('0x${hex.encode(keypair.publicKey.encode())}', seed);
      }
    });
  });
}
