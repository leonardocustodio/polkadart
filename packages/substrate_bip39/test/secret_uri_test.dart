import 'package:substrate_bip39/substrate_bip39.dart' show SecretUri, DeriveJunction;
import 'package:test/test.dart';

void main() {
  test('interpret std secret string', () async {
    expect(SecretUri.fromStr('hello world'), SecretUri('hello world', null, []));

    expect(SecretUri.fromStr('hello world/1'),
        SecretUri('hello world', null, [DeriveJunction.fromStr('1')]));

    expect(SecretUri.fromStr('hello world/DOT'),
        SecretUri('hello world', null, [DeriveJunction.fromStr('DOT')]));

    expect(
        SecretUri.fromStr('hello world/0123456789012345678901234567890123456789'),
        SecretUri('hello world', null,
            [DeriveJunction.fromStr('0123456789012345678901234567890123456789')]));

    expect(SecretUri.fromStr('hello world//1'),
        SecretUri('hello world', null, [DeriveJunction.fromStr('/1')]));

    expect(SecretUri.fromStr('hello world//DOT'),
        SecretUri('hello world', null, [DeriveJunction.fromStr('/DOT')]));

    expect(
        SecretUri.fromStr('hello world//0123456789012345678901234567890123456789'),
        SecretUri('hello world', null,
            [DeriveJunction.fromStr('/0123456789012345678901234567890123456789')]));

    expect(
        SecretUri.fromStr('hello world//1/DOT'),
        SecretUri('hello world', null, [
          DeriveJunction.fromStr('/1'),
          DeriveJunction.fromStr('DOT'),
        ]));

    expect(
        SecretUri.fromStr('hello world//DOT/1'),
        SecretUri('hello world', null, [
          DeriveJunction.fromStr('/DOT'),
          DeriveJunction.fromStr('1'),
        ]));

    expect(
        SecretUri.fromStr('hello world//1/DOT///password'),
        SecretUri('hello world', 'password', [
          DeriveJunction.fromStr('/1'),
          DeriveJunction.fromStr('DOT'),
        ]));

    expect(
        SecretUri.fromStr('hello world/1//DOT///password'),
        SecretUri('hello world', 'password', [
          DeriveJunction.fromStr('1'),
          DeriveJunction.fromStr('/DOT'),
        ]));
  });
}
