import 'package:ss58/ss58.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test(
      'Should return one instance of RegistryItem when call fromJson constructor',
      () {
    final Map<String, dynamic> json = {
      'prefix': 2,
      "network": "kusama",
      "displayName": "Kusama Relay Chain",
      "symbols": ["KSM"],
      "decimals": [12],
      "standardAccount": "*25519",
      "website": "https://kusama.network"
    };

    final registryItem = RegistryItem.fromJson(json);

    expect(registryItem, isA<RegistryItem>());
  });

  test('Should return the correct map values when call toJson', () {
    final Map<String, dynamic> json = {
      'prefix': 2,
      "network": "kusama",
      "displayName": "Kusama Relay Chain",
      "symbols": ["KSM"],
      "decimals": [12],
      "standardAccount": "*25519",
      "website": "https://kusama.network"
    };

    final registryItem = RegistryItem.fromJson(json);
    final registryMap = registryItem.toJson();

    expect(registryMap, isMap);
    expect(registryMap, json);
  });

  test('Should return a copy of RegistryItem.decimals', () {
    final Map<String, dynamic> json = {
      'prefix': 2,
      "network": "kusama",
      "displayName": "Kusama Relay Chain",
      "symbols": ["KSM"],
      "decimals": [12],
      "standardAccount": "*25519",
      "website": "https://kusama.network"
    };

    final registryItem = RegistryItem.fromJson(json);

    expect(registryItem.decimals, json['decimals']);
  });

  test('Should return a copy of RegistryItem.symbols', () {
    final Map<String, dynamic> json = {
      'prefix': 2,
      "network": "kusama",
      "displayName": "Kusama Relay Chain",
      "symbols": ["KSM"],
      "decimals": [12],
      "standardAccount": "*25519",
      "website": "https://kusama.network"
    };

    final registryItem = RegistryItem.fromJson(json);

    expect(registryItem.symbols, json['symbols']);
  });

  test('Should return all props of RegistryItem', () {
    final Map<String, dynamic> json = {
      'prefix': 2,
      "network": "kusama",
      "displayName": "Kusama Relay Chain",
      "symbols": ["KSM"],
      "decimals": [12],
      "standardAccount": "*25519",
      "website": "https://kusama.network"
    };

    final registryItem = RegistryItem.fromJson(json);
    final registryItemProps = registryItem.props;

    expect(registryItemProps, isList);
    expect(registryItemProps.length, 7);

    expect(registryItemProps[0], json['prefix']);
    expect(registryItemProps[1], json['network']);
    expect(registryItemProps[2], json['displayName']);
    expect(registryItemProps[3], json['symbols']);
    expect(registryItemProps[4], json['decimals']);
    expect(registryItemProps[5], json['standardAccount']);
    expect(registryItemProps[6], json['website']);
  });
}
