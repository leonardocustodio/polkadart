import 'dart:convert';

import 'package:ss58/src/exceptions.dart';
import 'package:ss58/src/registry_item.dart';

/// Default class to handle `SS58 account types`.
///
/// For more details about SS58 registry, check
/// https://github.com/paritytech/ss58-registry
class Registry {
  final List<RegistryItem> _items = <RegistryItem>[];
  final Map<int, RegistryItem> _byPrefix = <int, RegistryItem>{};
  final Map<String, RegistryItem> _byNetwork = <String, RegistryItem>{};

  /// Default constructor to initialize registory items.
  ///
  /// ```
  /// [Exceptions]
  /// throw DuplicatePrefixException: when (_byPrefix already has one
  /// item with prefix equal to item.prefix).
  ///
  /// throw DuplicatePrefixException: when (_byNetwork already has one item with
  /// network equal to item.network).
  /// ```
  Registry(List<RegistryItem> items) {
    _items.addAll(items);
    for (var item in items) {
      if (_byPrefix[item.prefix] != null) {
        throw DuplicatePrefixException(item.prefix);
      } else {
        _byPrefix[item.prefix] = item;
      }
      if (_byNetwork[item.network] != null) {
        throw DuplicateNetworkException(item.network);
      } else {
        _byNetwork[item.network] = item;
      }
    }
  }

  /// Initialize the registry with the [jsonString], process it to find list of registries
  /// and return a new instance of [Registry].
  factory Registry.fromJsonString(String jsonString) {
    List<dynamic> dynamicItems =
        jsonDecode(jsonString)['registry'] as List<dynamic>;
    List<RegistryItem> convertedItems = dynamicItems.map((value) {
      return RegistryItem.fromJson(value as Map<String, dynamic>);
    }).toList();

    return Registry(convertedItems);
  }

  /// Fetching the RegistryItem by the name of the network
  ///
  /// ```
  /// [Exception]
  /// throw NoEntryForNetworkException: when (_byNetwork.containsKey(network) == false)
  /// ```
  RegistryItem getByNetwork(String network) {
    var item = _byNetwork[network];
    if (item == null) {
      throw NoEntryForNetworkException(network);
    }
    return item;
  }

  ///
  /// Fetching the RegistryItem by the prefix of the network
  ///
  /// ```
  /// [Exception]
  /// throw NoEntryForPrefixException: when (_byPrefix.containsKey(prefix) == false)
  /// ```
  RegistryItem getByPrefix(int prefix) {
    var item = _byPrefix[prefix];
    if (item == null) {
      throw NoEntryForPrefixException(prefix);
    }
    return item;
  }

  /// Registry Item getter
  ///
  /// this getter is important to make _items un-modifiable
  List<RegistryItem> get items => List<RegistryItem>.from(_items);
}
