import 'dart:convert';

import 'package:ss58/src/exceptions.dart';
import 'package:ss58/src/registry_item.dart';

class Registry {
  final List<RegistryItem> _items = <RegistryItem>[];
  final Map<int, RegistryItem> _byPrefix = <int, RegistryItem>{};
  final Map<String, RegistryItem> _byNetwork = <String, RegistryItem>{};

  ///
  /// Default constructor to initialize registory items.
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

  ///
  /// Initialize the registry with the jsonString and process the jsonString to find list of registries.
  factory Registry.fromJsonString(String jsonString) {
    List<dynamic> dynamicItems =
        jsonDecode(jsonString)['registry'] as List<dynamic>;
    List<RegistryItem> convertedItems = dynamicItems.map((value) {
      return RegistryItem.fromJson(value as Map<String, dynamic>);
    }).toList();

    // Return the instance of Registry
    return Registry(convertedItems);
  }

  ///
  /// Fetching the RegistryItem by the name of the network
  ///
  /// throws an exception when not found
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
  /// throws an exception when not found
  RegistryItem getByPrefix(int prefix) {
    var item = _byPrefix[prefix];
    if (item == null) {
      throw NoEntryForPrefixException(prefix);
    }
    return item;
  }

  ///
  /// Finding the Registry Items by the name of the network
  RegistryItem? findByNetwork(String network) {
    return _byNetwork[network];
  }

  ///
  /// Finding the Registry Items by the prefix of the network
  RegistryItem? findByPrefix(int prefix) {
    return _byPrefix[prefix];
  }

  /// Registry Item getter
  ///
  /// this getter is important to make _items un-modifiable
  List<RegistryItem> get items => List<RegistryItem>.from(_items);
}
