import 'package:ss58/ss58.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Should return one instance of RegistryItem when call fromJson constructor', () {
    final Map<String, dynamic> json = {'prefix': 2, "network": "kusama"};

    final registryItem = RegistryItem.fromJson(json);

    expect(registryItem, isA<RegistryItem>());
  });

  test('Should return the correct map values when call toJson', () {
    final Map<String, dynamic> json = {'prefix': 2, "network": "kusama"};

    final registryItem = RegistryItem.fromJson(json);
    final registryMap = registryItem.toJson();

    expect(registryMap, isMap);
    expect(registryMap, json);
  });

  test('Should return all props of RegistryItem', () {
    final Map<String, dynamic> json = {'prefix': 2, "network": "kusama"};

    final registryItem = RegistryItem.fromJson(json);
    final registryItemProps = registryItem.props;

    expect(registryItemProps, isList);
    expect(registryItemProps.length, 2);

    expect(registryItemProps[0], json['prefix']);
    expect(registryItemProps[1], json['network']);
  });
}
