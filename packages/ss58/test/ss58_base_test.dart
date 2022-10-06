import 'package:ss58/src/exceptions.dart';
import 'package:ss58/ss58.dart';
import 'package:test/test.dart';
import 'package:convert/convert.dart';

void main() {
  group('Codec decode method tests', () {
    test('Should return correct bytes', () {
      final String address = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
      final int prefix = 42;

      final List<int> expectedBytes = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');

      expect(Codec(prefix).decode(address), expectedBytes);
    });

    test('Should throw when given prefix does not match with decoded prefix',
        () {
      final String address = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
      final int prefix = 2;

      final String expectedErrorMessage =
          'Expected an address with prefix 2, but 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY has prefix 42';

      expect(
        () => Codec(prefix).decode(address),
        throwsA(
          predicate((exception) =>
              exception is InvalidAddressPrefixException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });
  });

  group('Codec encode method tests: ', () {
    test('Should return correct address', () {
      final String address = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
      final int prefix = 42;

      final List<int> bytes = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');

      expect(Codec(prefix).encode(bytes), address);
    });

    test('Should return correct address when prefix is zero', () {
      final String address = '15oF4uVJwmo4TdGW7VfQxNLavjCXviqxT9S1MgbjMNHr6Sp5';
      final int prefix = 0;

      final List<int> bytes = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');

      expect(Codec(prefix).encode(bytes), address);
    });

    test('Should throw when given prefix is negative', () {
      final int prefix = -42;

      final List<int> bytes = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');

      final String expectedErrorMessage = 'Invalid prefix: -42.';

      expect(
        () => Codec(prefix).encode(bytes),
        throwsA(
          predicate((exception) =>
              exception is InvalidPrefixException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });

    test('Should throw when given prefix is greater than 16383', () {
      final int prefix = 16384;

      final List<int> bytes = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d');

      final String expectedErrorMessage = 'Invalid prefix: 16384.';

      expect(
        () => Codec(prefix).encode(bytes),
        throwsA(
          predicate((exception) =>
              exception is InvalidPrefixException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });

    test('Should return a Codec instance with defined prefix', () {
      final String network = 'kusama';
      final int expectedPrefix = 2;
      final codec = Codec.fromNetwork(network);

      expect(codec, isA<Codec>());
      expect(codec.prefix, expectedPrefix);
    });
  });
}
