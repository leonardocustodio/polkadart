import 'package:ss58/src/exceptions.dart';
import 'package:ss58/ss58.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:ss58/util/ss58_registry_json.dart' as reg;

void main() {
  test(
      'Should return a Registry instance when default constructor is called with empty list',
      () {
    final List<RegistryItem> registryData = [];
    final registry = Registry(registryData);

    expect(registry, isA<Registry>());
  });

  test('Should return a Registry instance when default constructor is called',
      () {
    final item = RegistryItem.fromJson({
      "prefix": 0,
      "network": "polkadot",
      "displayName": "Polkadot Relay Chain",
      "symbols": ["DOT"],
      "decimals": [10],
      "standardAccount": "*25519",
      "website": "https://polkadot.network"
    });
    final List<RegistryItem> registryData = [item];
    final registry = Registry(registryData);

    expect(registry, isA<Registry>());
  });
  test(
      'Should throw DuplicatePrefixException when items list has items with same prefix',
      () {
    final item = RegistryItem.fromJson({
      "prefix": 0,
      "network": "polkadot",
      "displayName": "Polkadot Relay Chain",
      "symbols": ["DOT"],
      "decimals": [10],
      "standardAccount": "*25519",
      "website": "https://polkadot.network"
    });

    final List<RegistryItem> registryData = [item, item];

    final expectedErrorMessage = 'Duplicate prefix: 0.';

    expect(
      () => Registry(registryData),
      throwsA(
        predicate((exception) =>
            exception is DuplicatePrefixException &&
            exception.toString() == expectedErrorMessage),
      ),
    );
  });

  test(
      'Should throw DuplicatePrefixException when items list has items with same network',
      () {
    final item = RegistryItem.fromJson({
      "prefix": 0,
      "network": "polkadot",
      "displayName": "Polkadot Relay Chain",
      "symbols": ["DOT"],
      "decimals": [10],
      "standardAccount": "*25519",
      "website": "https://polkadot.network"
    });

    final item2 = RegistryItem.fromJson({
      "prefix": 15,
      "network": "polkadot",
      "displayName": "Polkadart",
      "symbols": ["DAT"],
      "decimals": [10],
      "standardAccount": "*2419",
      "website": ""
    });
    final List<RegistryItem> registryData = [item, item2];

    final expectedErrorMessage = 'Duplicate network: polkadot.';

    expect(
      () => Registry(registryData),
      throwsA(
        predicate((exception) =>
            exception is DuplicateNetworkException &&
            exception.toString() == expectedErrorMessage),
      ),
    );
  });
  test(
      'Should return a Registry instance when factory fromJsonString is called',
      () {
    final registry = Registry.fromJsonString(reg.jsonRegistryData);

    expect(registry, isA<Registry>());
  });

  test('Should return a correct registry item when getByNetwork is called', () {
    final registry = Registry.fromJsonString(reg.jsonRegistryData);

    final String network = 'kusama';
    final registryItem = registry.getByNetwork(network);

    expect(registryItem, isA<RegistryItem>());
    expect(registryItem.network, network);
  });

  test(
      'Should throw NoEntryForNetworkException when getByNetwork is called with nonexistent network',
      () {
    final registry = Registry.fromJsonString(reg.jsonRegistryData);

    final String network = 'nonexistent';

    final String expectedErrorMessage = 'No entry for network: nonexistent';

    expect(
      () => registry.getByNetwork(network),
      throwsA(
        predicate((exception) =>
            exception is NoEntryForNetworkException &&
            exception.toString() == expectedErrorMessage),
      ),
    );
  });

  test('Should return a correct registry item when getByPrefix is called', () {
    final registry = Registry.fromJsonString(reg.jsonRegistryData);

    final int prefix = 2;
    final registryItem = registry.getByPrefix(prefix);

    expect(registryItem, isA<RegistryItem>());
    expect(registryItem.prefix, prefix);
  });

  test(
      'Should throw NoEntryForPrefixException when getByPrefix is called with nonexistent prefix',
      () {
    final registry = Registry.fromJsonString(reg.jsonRegistryData);

    final int prefix = -1;

    final String expectedErrorMessage = 'No entry for prefix: -1';

    expect(
      () => registry.getByPrefix(prefix),
      throwsA(
        predicate((exception) =>
            exception is NoEntryForPrefixException &&
            exception.toString() == expectedErrorMessage),
      ),
    );
  });

  test(
      'Should return the same registry item when getByPrefix and getByNetwork are called psasing kusama values',
      () {
    final registry = Registry.fromJsonString(reg.jsonRegistryData);

    final int kusamaPrefix = 2;
    final String kusamaNetwork = 'kusama';

    expect(registry.getByNetwork(kusamaNetwork),
        registry.getByPrefix(kusamaPrefix));
  });

  test('Should return registry items', () {
    final item = RegistryItem.fromJson({
      "prefix": 0,
      "network": "polkadot",
      "displayName": "Polkadot Relay Chain",
      "symbols": ["DOT"],
      "decimals": [10],
      "standardAccount": "*25519",
      "website": "https://polkadot.network"
    });

    final List<RegistryItem> registryData = [item];

    final Registry registry = Registry(registryData);

    expect(registry.items, isA<List>());
    expect(registry.items.single, item);
  });
}
