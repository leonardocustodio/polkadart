import 'dart:collection' show UnmodifiableListView;

import './exceptions.dart';
import './registry_item.dart';

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
    for (final item in items) {
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
  factory Registry.fromMap(List<Map<String, dynamic>> jsonList) {
    final List<RegistryItem> convertedItems = jsonList.map(RegistryItem.fromJson).toList();
    return Registry(convertedItems);
  }

  /// Fetching the RegistryItem by the name of the network
  ///
  /// ```
  /// [Exception]
  /// throw NoEntryForNetworkException: when (_byNetwork.containsKey(network) == false)
  /// ```
  RegistryItem getByNetwork(String network) {
    final item = _byNetwork[network];
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
    final item = _byPrefix[prefix];
    if (item == null) {
      throw NoEntryForPrefixException(prefix);
    }
    return item;
  }

  /// Registry Item getter
  ///
  /// Returns an unmodifiable view of the registry items.
  /// This is more efficient than creating a copy on each access.
  List<RegistryItem> get items => UnmodifiableListView(_items);
}
