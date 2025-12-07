import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ss58/ss58.dart';
import 'package:ss58/util/ss58_registry_json.dart' as reg;
import 'package:test/test.dart';

void main() {
  //
  // ADDRESS DECODE TESTS
  //
  group('Address.decode()', () {
    group('valid addresses with single-byte prefix (0-63)', () {
      test('should decode Polkadot address (prefix 0)', () {
        final address = Address.decode('15oF4uVJwmo4TdGW7VfQxNLavjCXviqxT9S1MgbjMNHr6Sp5');
        expect(address.prefix, equals(0));
        expect(address.pubkey.length, equals(32));
      });

      test('should decode Kusama address (prefix 2)', () {
        final address = Address.decode('EXtQYFeY2ivDsfazZvGC9aG87DxnhWH2f9kjUUq2pXTZKF5');
        expect(address.prefix, equals(2));
        expect(address.pubkey.length, equals(32));
      });

      test('should decode Substrate address (prefix 42)', () {
        final address = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
        expect(address.prefix, equals(42));
        expect(address.pubkey.length, equals(32));
      });

      test('should decode address with prefix 63 (boundary)', () {
        // Prefix 63 is the last single-byte prefix
        final pubkey = Uint8List.fromList(
          hex.decode('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'),
        );
        final encoded = Address(prefix: 63, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.prefix, equals(63));
      });
    });

    group('valid addresses with two-byte prefix (64-16383)', () {
      test('should decode Crust address (prefix 66)', () {
        final address = Address.decode('cTMxUeDi2HdYVpedqu5AFMtyDcn4djbBfCKiPDds6k1fuFYXL');
        expect(address.prefix, equals(66));
        expect(address.pubkey.length, equals(32));
      });

      test('should decode address with prefix 64 (first two-byte prefix)', () {
        final pubkey = Uint8List.fromList(
          hex.decode('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'),
        );
        final encoded = Address(prefix: 64, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.prefix, equals(64));
      });

      test('should decode address with prefix 127', () {
        final pubkey = Uint8List.fromList(
          hex.decode('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'),
        );
        final encoded = Address(prefix: 127, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.prefix, equals(127));
      });

      test('should decode address with prefix 128', () {
        final pubkey = Uint8List.fromList(
          hex.decode('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'),
        );
        final encoded = Address(prefix: 128, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.prefix, equals(128));
      });

      test('should decode address with prefix 16383 (maximum)', () {
        final pubkey = Uint8List.fromList(
          hex.decode('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'),
        );
        final encoded = Address(prefix: 16383, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.prefix, equals(16383));
      });
    });

    group('valid pubkey lengths', () {
      test('should decode 32-byte pubkey (standard)', () {
        final address = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
        expect(address.pubkey.length, equals(32));
      });

      test('should decode 33-byte pubkey (compressed)', () {
        final pubkey = Uint8List(33);
        pubkey.fillRange(0, 33, 1);
        final encoded = Address(prefix: 42, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.pubkey.length, equals(33));
      });

      test('should decode 1-byte pubkey', () {
        final pubkey = Uint8List.fromList([42]);
        final encoded = Address(prefix: 0, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.pubkey.length, equals(1));
        expect(decoded.pubkey[0], equals(42));
      });

      test('should decode 2-byte pubkey', () {
        final pubkey = Uint8List.fromList([1, 2]);
        final encoded = Address(prefix: 0, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.pubkey.length, equals(2));
      });

      test('should decode 4-byte pubkey', () {
        final pubkey = Uint8List.fromList([1, 2, 3, 4]);
        final encoded = Address(prefix: 0, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.pubkey.length, equals(4));
      });

      test('should decode 8-byte pubkey', () {
        final pubkey = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
        final encoded = Address(prefix: 0, pubkey: pubkey).encode();
        final decoded = Address.decode(encoded);
        expect(decoded.pubkey.length, equals(8));
      });
    });

    group('invalid inputs', () {
      test('should throw BadAddressLengthException for empty string', () {
        expect(() => Address.decode(''), throwsA(isA<BadAddressLengthException>()));
      });

      test('should throw BadAddressLengthException for too short address', () {
        expect(() => Address.decode('KS'), throwsA(isA<BadAddressLengthException>()));
      });

      test('should throw InvalidPrefixException for invalid first byte (>127)', () {
        // Address starting with byte > 127
        expect(
          () => Address.decode('fRWKeM1KzddF4G6N6isvg6SpFVWJLLXRyYvK1dXLx4xjP'),
          throwsA(isA<InvalidPrefixException>()),
        );
      });

      test('should throw InvalidCheckSumException for corrupted address', () {
        expect(
          () => Address.decode('3HX1zEyzCbxeXe34JY8SNSVAZ6djFccsV5f67PTied4CcWHs'),
          throwsA(isA<InvalidCheckSumException>()),
        );
      });

      test('should throw BadAddressLengthException for invalid pubkey length', () {
        // These should fail because (data.length - offset) doesn't match valid lengths
        expect(
          () => Address.decode('3HX1zEyzCbxeXe34JY8SNSVAZ6djFccsV5f67PTied4CcWHspQ'),
          throwsA(isA<BadAddressLengthException>()),
        );
      });
    });
  });

  //
  // ADDRESS TRYDECODE TESTS
  //
  group('Address.tryDecode()', () {
    test('should return Address for valid address', () {
      final address = Address.tryDecode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(address, isNotNull);
      expect(address!.prefix, equals(42));
      expect(address.pubkey.length, equals(32));
    });

    test('should return null for empty string', () {
      final address = Address.tryDecode('');
      expect(address, isNull);
    });

    test('should return null for invalid address', () {
      final address = Address.tryDecode('invalid');
      expect(address, isNull);
    });

    test('should return null for corrupted checksum', () {
      final address = Address.tryDecode('3HX1zEyzCbxeXe34JY8SNSVAZ6djFccsV5f67PTied4CcWHs');
      expect(address, isNull);
    });

    test('should return null for too short address', () {
      final address = Address.tryDecode('KS');
      expect(address, isNull);
    });
  });

  //
  // ADDRESS ENCODE TESTS
  //
  group('Address.encode()', () {
    group('valid pubkey lengths', () {
      test('should encode 1-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List.fromList([1]));
        expect(() => address.encode(), returnsNormally);
      });

      test('should encode 2-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List.fromList([1, 2]));
        expect(() => address.encode(), returnsNormally);
      });

      test('should encode 4-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List.fromList([1, 2, 3, 4]));
        expect(() => address.encode(), returnsNormally);
      });

      test('should encode 8-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]));
        expect(() => address.encode(), returnsNormally);
      });

      test('should encode 32-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List(32));
        expect(() => address.encode(), returnsNormally);
      });

      test('should encode 33-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List(33));
        expect(() => address.encode(), returnsNormally);
      });
    });

    group('prefix ranges', () {
      test('should encode with prefix 0', () {
        final address = Address(prefix: 0, pubkey: Uint8List.fromList([1, 2, 3, 4]));
        expect(() => address.encode(), returnsNormally);
      });

      test('should encode with prefix 63 (last single-byte)', () {
        final address = Address(prefix: 63, pubkey: Uint8List.fromList([1, 2, 3, 4]));
        expect(() => address.encode(), returnsNormally);
      });

      test('should encode with prefix 64 (first two-byte)', () {
        final address = Address(prefix: 64, pubkey: Uint8List.fromList([1, 2, 3, 4]));
        expect(() => address.encode(), returnsNormally);
      });

      test('should encode with prefix 16383 (maximum)', () {
        final address = Address(prefix: 16383, pubkey: Uint8List.fromList([1, 2, 3, 4]));
        expect(() => address.encode(), returnsNormally);
      });
    });

    group('roundtrip encode/decode', () {
      test('should roundtrip Substrate address', () {
        const original = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
        final decoded = Address.decode(original);
        final encoded = decoded.encode();
        expect(encoded, equals(original));
      });

      test('should roundtrip Polkadot address', () {
        const original = '15oF4uVJwmo4TdGW7VfQxNLavjCXviqxT9S1MgbjMNHr6Sp5';
        final decoded = Address.decode(original);
        final encoded = decoded.encode();
        expect(encoded, equals(original));
      });

      test('should roundtrip Kusama address', () {
        const original = 'EXtQYFeY2ivDsfazZvGC9aG87DxnhWH2f9kjUUq2pXTZKF5';
        final decoded = Address.decode(original);
        final encoded = decoded.encode();
        expect(encoded, equals(original));
      });
    });

    group('custom prefix override', () {
      test('should encode with custom prefix parameter', () {
        final pubkey = Uint8List.fromList(
          hex.decode('d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'),
        );
        final address = Address(prefix: 42, pubkey: pubkey);

        // Encode with different prefix
        final polkadotEncoded = address.encode(prefix: 0);
        final decoded = Address.decode(polkadotEncoded);
        expect(decoded.prefix, equals(0));
      });
    });

    group('invalid inputs', () {
      test('should throw InvalidPrefixException for negative prefix', () {
        final address = Address(prefix: -1, pubkey: Uint8List.fromList([1, 2, 3, 4]));
        expect(() => address.encode(), throwsA(isA<InvalidPrefixException>()));
      });

      test('should throw InvalidPrefixException for prefix > 16383', () {
        final address = Address(prefix: 16384, pubkey: Uint8List.fromList([1, 2, 3, 4]));
        expect(() => address.encode(), throwsA(isA<InvalidPrefixException>()));
      });

      test('should throw BadAddressLengthException for 3-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List(3));
        expect(() => address.encode(), throwsA(isA<BadAddressLengthException>()));
      });

      test('should throw BadAddressLengthException for 5-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List(5));
        expect(() => address.encode(), throwsA(isA<BadAddressLengthException>()));
      });

      test('should throw BadAddressLengthException for 6-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List(6));
        expect(() => address.encode(), throwsA(isA<BadAddressLengthException>()));
      });

      test('should throw BadAddressLengthException for 7-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List(7));
        expect(() => address.encode(), throwsA(isA<BadAddressLengthException>()));
      });

      test('should throw BadAddressLengthException for 9-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List(9));
        expect(() => address.encode(), throwsA(isA<BadAddressLengthException>()));
      });

      test('should throw BadAddressLengthException for 31-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List(31));
        expect(() => address.encode(), throwsA(isA<BadAddressLengthException>()));
      });

      test('should throw BadAddressLengthException for 35-byte pubkey', () {
        final address = Address(prefix: 0, pubkey: Uint8List(35));
        expect(() => address.encode(), throwsA(isA<BadAddressLengthException>()));
      });
    });
  });

  //
  // ADDRESS.WITHPREFIX TESTS
  //
  group('Address.withPrefix()', () {
    test('should create new address with different prefix', () {
      final original = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(original.prefix, equals(42));

      final polkadot = original.withPrefix(0);
      expect(polkadot.prefix, equals(0));
      expect(polkadot.pubkey, equals(original.pubkey));
    });

    test('should throw InvalidPrefixException for negative prefix', () {
      final address = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(() => address.withPrefix(-1), throwsA(isA<InvalidPrefixException>()));
    });

    test('should throw InvalidPrefixException for prefix > 16383', () {
      final address = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(() => address.withPrefix(16384), throwsA(isA<InvalidPrefixException>()));
    });

    test('should create a copy of pubkey (not reference)', () {
      final pubkey = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
      final original = Address(prefix: 0, pubkey: pubkey);
      final copy = original.withPrefix(42);

      // Modify original pubkey
      pubkey[0] = 99;

      // Copy should be unaffected (if implemented correctly)
      // Note: This test documents expected behavior
      expect(copy.pubkey[0], equals(1));
    });
  });

  //
  // ADDRESS.TOSTRING TESTS
  //
  group('Address.toString()', () {
    test('should return formatted string with prefix and hex pubkey', () {
      final pubkey = Uint8List.fromList([1, 2, 3, 4]);
      final address = Address(prefix: 42, pubkey: pubkey);
      final str = address.toString();

      expect(str, contains('prefix: 42'));
      expect(str, contains('0x01020304'));
    });
  });

  //
  // ADDRESS EQUALITY (EQUATABLE) TESTS
  //
  group('Address equality', () {
    test('should be equal when prefix and pubkey match', () {
      final pubkey = Uint8List.fromList([1, 2, 3, 4]);
      final a1 = Address(prefix: 42, pubkey: pubkey);
      final a2 = Address(prefix: 42, pubkey: Uint8List.fromList([1, 2, 3, 4]));
      expect(a1, equals(a2));
    });

    test('should not be equal when prefix differs', () {
      final pubkey = Uint8List.fromList([1, 2, 3, 4]);
      final a1 = Address(prefix: 42, pubkey: pubkey);
      final a2 = Address(prefix: 0, pubkey: pubkey);
      expect(a1, isNot(equals(a2)));
    });

    test('should not be equal when pubkey differs', () {
      final a1 = Address(prefix: 42, pubkey: Uint8List.fromList([1, 2, 3, 4]));
      final a2 = Address(prefix: 42, pubkey: Uint8List.fromList([5, 6, 7, 8]));
      expect(a1, isNot(equals(a2)));
    });

    test('props should contain prefix and pubkey', () {
      final pubkey = Uint8List.fromList([1, 2, 3, 4]);
      final address = Address(prefix: 42, pubkey: pubkey);
      expect(address.props, hasLength(2));
      expect(address.props[0], equals(42));
      expect(address.props[1], equals(pubkey));
    });
  });

  //
  // CODEC TESTS
  //
  group('Codec', () {
    group('constructor', () {
      test('should create Codec with valid prefix', () {
        expect(() => Codec(0), returnsNormally);
        expect(() => Codec(42), returnsNormally);
        expect(() => Codec(16383), returnsNormally);
      });

      test('should throw InvalidPrefixException for negative prefix', () {
        expect(() => Codec(-1), throwsA(isA<InvalidPrefixException>()));
      });

      test('should throw InvalidPrefixException for prefix > 16383', () {
        expect(() => Codec(16384), throwsA(isA<InvalidPrefixException>()));
      });
    });

    group('fromNetwork()', () {
      test('should create Codec from valid network name', () {
        final codec = Codec.fromNetwork('kusama');
        expect(codec.prefix, equals(2));
      });

      test('should create Codec from polkadot network', () {
        final codec = Codec.fromNetwork('polkadot');
        expect(codec.prefix, equals(0));
      });

      test('should create Codec from substrate network', () {
        final codec = Codec.fromNetwork('substrate');
        expect(codec.prefix, equals(42));
      });

      test('should throw NoEntryForNetworkException for invalid network', () {
        expect(() => Codec.fromNetwork('nonexistent'), throwsA(isA<NoEntryForNetworkException>()));
      });
    });

    group('encode()', () {
      test('should encode bytes to address string', () {
        final bytes = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d',
        );
        final encoded = Codec(42).encode(bytes);
        expect(encoded, equals('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY'));
      });
    });

    group('decode()', () {
      test('should decode address to bytes', () {
        final bytes = Codec(42).decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
        final expected = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d',
        );
        expect(bytes, equals(expected));
      });

      test('should throw InvalidAddressPrefixException for prefix mismatch', () {
        expect(
          () => Codec(2).decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY'),
          throwsA(isA<InvalidAddressPrefixException>()),
        );
      });
    });

    group('roundtrip', () {
      test('should roundtrip encode/decode', () {
        final original = hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d',
        );
        final codec = Codec(42);
        final encoded = codec.encode(original);
        final decoded = codec.decode(encoded);
        expect(decoded, equals(original));
      });
    });

    group('registry', () {
      test('should have static registry available', () {
        expect(Codec.registry, isA<Registry>());
        expect(Codec.registry.items, isNotEmpty);
      });
    });
  });

  //
  // REGISTRY TESTS
  //
  group('Registry', () {
    group('constructor', () {
      test('should create empty registry', () {
        final registry = Registry([]);
        expect(registry.items, isEmpty);
      });

      test('should create registry with items', () {
        final item = RegistryItem(prefix: 0, network: 'test');
        final registry = Registry([item]);
        expect(registry.items, hasLength(1));
      });

      test('should throw DuplicatePrefixException for duplicate prefix', () {
        final item1 = RegistryItem(prefix: 0, network: 'test1');
        final item2 = RegistryItem(prefix: 0, network: 'test2');
        expect(() => Registry([item1, item2]), throwsA(isA<DuplicatePrefixException>()));
      });

      test('should throw DuplicateNetworkException for duplicate network', () {
        final item1 = RegistryItem(prefix: 0, network: 'test');
        final item2 = RegistryItem(prefix: 1, network: 'test');
        expect(() => Registry([item1, item2]), throwsA(isA<DuplicateNetworkException>()));
      });
    });

    group('fromMap()', () {
      test('should create registry from JSON list', () {
        final jsonList = [
          {'prefix': 0, 'network': 'test1'},
          {'prefix': 1, 'network': 'test2'},
        ];
        final registry = Registry.fromMap(jsonList);
        expect(registry.items, hasLength(2));
      });

      test('should create registry from actual registry data', () {
        final registry = Registry.fromMap(reg.jsonRegistryData);
        expect(registry.items, isNotEmpty);
      });
    });

    group('getByPrefix()', () {
      test('should return item for valid prefix', () {
        final registry = Registry.fromMap(reg.jsonRegistryData);
        final item = registry.getByPrefix(0);
        expect(item.network, equals('polkadot'));
      });

      test('should throw NoEntryForPrefixException for invalid prefix', () {
        final registry = Registry.fromMap(reg.jsonRegistryData);
        expect(() => registry.getByPrefix(-1), throwsA(isA<NoEntryForPrefixException>()));
      });
    });

    group('getByNetwork()', () {
      test('should return item for valid network', () {
        final registry = Registry.fromMap(reg.jsonRegistryData);
        final item = registry.getByNetwork('kusama');
        expect(item.prefix, equals(2));
      });

      test('should throw NoEntryForNetworkException for invalid network', () {
        final registry = Registry.fromMap(reg.jsonRegistryData);
        expect(
          () => registry.getByNetwork('nonexistent'),
          throwsA(isA<NoEntryForNetworkException>()),
        );
      });
    });

    group('items getter', () {
      test('should return copy of items list', () {
        final item = RegistryItem(prefix: 0, network: 'test');
        final registry = Registry([item]);
        final items1 = registry.items;
        final items2 = registry.items;
        expect(identical(items1, items2), isFalse);
      });
    });
  });

  //
  // REGISTRY ITEM TESTS
  //
  group('RegistryItem', () {
    group('constructor', () {
      test('should create item with required fields', () {
        final item = RegistryItem(prefix: 0, network: 'test');
        expect(item.prefix, equals(0));
        expect(item.network, equals('test'));
      });
    });

    group('fromJson()', () {
      test('should create item from valid JSON', () {
        final json = {'prefix': 42, 'network': 'substrate'};
        final item = RegistryItem.fromJson(json);
        expect(item.prefix, equals(42));
        expect(item.network, equals('substrate'));
      });
    });

    group('toJson()', () {
      test('should convert to JSON', () {
        final item = RegistryItem(prefix: 42, network: 'substrate');
        final json = item.toJson();
        expect(json['prefix'], equals(42));
        expect(json['network'], equals('substrate'));
      });

      test('should roundtrip fromJson/toJson', () {
        final original = {'prefix': 42, 'network': 'substrate'};
        final item = RegistryItem.fromJson(original);
        final json = item.toJson();
        expect(json, equals(original));
      });
    });

    group('equality', () {
      test('should be equal when prefix and network match', () {
        final item1 = RegistryItem(prefix: 0, network: 'test');
        final item2 = RegistryItem(prefix: 0, network: 'test');
        expect(item1, equals(item2));
      });

      test('should not be equal when prefix differs', () {
        final item1 = RegistryItem(prefix: 0, network: 'test');
        final item2 = RegistryItem(prefix: 1, network: 'test');
        expect(item1, isNot(equals(item2)));
      });

      test('should not be equal when network differs', () {
        final item1 = RegistryItem(prefix: 0, network: 'test1');
        final item2 = RegistryItem(prefix: 0, network: 'test2');
        expect(item1, isNot(equals(item2)));
      });
    });

    group('props', () {
      test('should have correct props list', () {
        final item = RegistryItem(prefix: 42, network: 'substrate');
        expect(item.props, hasLength(2));
        expect(item.props[0], equals(42));
        expect(item.props[1], equals('substrate'));
      });
    });
  });

  //
  // EXCEPTION TESTS
  //
  group('Exceptions', () {
    group('DuplicatePrefixException', () {
      test('should have correct toString', () {
        final exception = DuplicatePrefixException(42);
        expect(exception.toString(), equals('Duplicate prefix: 42.'));
        expect(exception.prefix, equals(42));
      });
    });

    group('DuplicateNetworkException', () {
      test('should have correct toString', () {
        final exception = DuplicateNetworkException('test');
        expect(exception.toString(), equals('Duplicate network: test.'));
        expect(exception.network, equals('test'));
      });
    });

    group('NoEntryForNetworkException', () {
      test('should have correct toString', () {
        final exception = NoEntryForNetworkException('test');
        expect(exception.toString(), equals('No entry for network: test'));
        expect(exception.network, equals('test'));
      });
    });

    group('NoEntryForPrefixException', () {
      test('should have correct toString', () {
        final exception = NoEntryForPrefixException(42);
        expect(exception.toString(), equals('No entry for prefix: 42'));
        expect(exception.prefix, equals(42));
      });
    });

    group('InvalidAddressPrefixException', () {
      test('should have correct toString', () {
        final address = Address(prefix: 42, pubkey: Uint8List.fromList([1, 2, 3, 4]));
        final exception = InvalidAddressPrefixException(
          prefix: 0,
          address: address,
          encodedAddress: 'test',
        );
        expect(exception.toString(), contains('Expected an address with prefix 0'));
        expect(exception.toString(), contains('has prefix 42'));
        expect(exception.prefix, equals(0));
        expect(exception.address, equals(address));
        expect(exception.encodedAddress, equals('test'));
      });
    });

    group('InvalidPrefixException', () {
      test('should have correct toString with prefix', () {
        final exception = InvalidPrefixException(42);
        expect(exception.toString(), equals('Invalid SS58 prefix: 42.'));
        expect(exception.prefix, equals(42));
      });

      test('should have correct toString without prefix', () {
        final exception = InvalidPrefixException();
        expect(exception.toString(), equals('Could not parse SS58 prefix'));
        expect(exception.prefix, isNull);
      });
    });

    group('InvalidCheckSumException', () {
      test('should have correct toString', () {
        final exception = InvalidCheckSumException();
        expect(exception.toString(), equals('Invalid checksum'));
      });
    });

    group('BadAddressLengthException', () {
      test('should have correct toString with address', () {
        final exception = BadAddressLengthException('test');
        expect(exception.toString(), equals('Bad Length Address: test.'));
        expect(exception.address, equals('test'));
      });

      test('should have correct toString without address', () {
        final exception = BadAddressLengthException();
        expect(exception.toString(), equals('Bad Length Address.'));
        expect(exception.address, isNull);
      });
    });
  });

  //
  // INTEGRATION TESTS
  //
  group('Integration tests', () {
    group('real-world addresses', () {
      test('should handle Polkadot treasury address', () {
        // Polkadot treasury
        final address = Address.decode('13UVJyLnbVp9RBZYFwFGyDvVd1y27Tt8tkntv6Q7JVPhFsTB');
        expect(address.prefix, equals(0));
      });

      test('should handle multiple Kusama addresses', () {
        final addresses = [
          'EXtQYFeY2ivDsfazZvGC9aG87DxnhWH2f9kjUUq2pXTZKF5',
          'H9Sa5qnaiK1oiLDstHRvgH9G6p9sMZ2j82hHMdxaq2QeAKk',
          'FXCgfz7AzQA1fNaUqubSgXxGh77sjWVVkypgueWLmAcwv79',
        ];

        for (final addr in addresses) {
          final decoded = Address.decode(addr);
          expect(decoded.prefix, equals(2));
          expect(decoded.pubkey.length, equals(32));
        }
      });
    });

    group('cross-network address conversion', () {
      test('should convert Substrate address to Polkadot', () {
        final substrate = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
        final polkadot = substrate.withPrefix(0);
        final polkadotEncoded = polkadot.encode();

        // Decode again and verify
        final decoded = Address.decode(polkadotEncoded);
        expect(decoded.prefix, equals(0));
        expect(decoded.pubkey, equals(substrate.pubkey));
      });

      test('should convert Substrate address to Kusama', () {
        final substrate = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
        final kusama = substrate.withPrefix(2);
        final kusamaEncoded = kusama.encode();

        // Decode again and verify
        final decoded = Address.decode(kusamaEncoded);
        expect(decoded.prefix, equals(2));
        expect(decoded.pubkey, equals(substrate.pubkey));
      });

      test('should preserve pubkey when converting between networks', () {
        final original = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
        final originalPubkey = Uint8List.fromList(original.pubkey);

        // Convert through multiple networks
        final polkadot = original.withPrefix(0);
        final kusama = polkadot.withPrefix(2);
        final substrate = kusama.withPrefix(42);

        expect(substrate.pubkey, equals(originalPubkey));
      });
    });

    group('registry data integrity', () {
      test('should have polkadot at prefix 0', () {
        final item = Codec.registry.getByPrefix(0);
        expect(item.network, equals('polkadot'));
      });

      test('should have kusama at prefix 2', () {
        final item = Codec.registry.getByPrefix(2);
        expect(item.network, equals('kusama'));
      });

      test('should have substrate at prefix 42', () {
        final item = Codec.registry.getByPrefix(42);
        expect(item.network, equals('substrate'));
      });

      test('getByPrefix and getByNetwork should return same item', () {
        final byPrefix = Codec.registry.getByPrefix(2);
        final byNetwork = Codec.registry.getByNetwork('kusama');
        expect(byPrefix, equals(byNetwork));
      });
    });
  });

  //
  // COMPUTEHASH FUNCTION TESTS
  //
  group('computeHash()', () {
    test('should produce consistent hash', () {
      final data = Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
      final hash1 = computeHash(data, 2);
      final hash2 = computeHash(data, 2);
      expect(hash1, equals(hash2));
    });

    test('should produce different hash for different data', () {
      final data1 = Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
      final data2 = Uint8List.fromList([9, 8, 7, 6, 5, 4, 3, 2, 1, 0]);
      final hash1 = computeHash(data1, 2);
      final hash2 = computeHash(data2, 2);
      expect(hash1, isNot(equals(hash2)));
    });
  });
}
