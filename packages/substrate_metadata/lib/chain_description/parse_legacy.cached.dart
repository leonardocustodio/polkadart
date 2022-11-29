// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'parse_legacy.dart';

// **************************************************************************
// CachedGenerator
// **************************************************************************

abstract class _$ParseLegacy {
  Metadata get metadata;
  LegacyTypes get legacyTypes;
}

class _ParseLegacy with ParseLegacy implements _$ParseLegacy {
  _ParseLegacy(this.metadata, this.legacyTypes);

  @override
  final Metadata metadata;
  @override
  final LegacyTypes legacyTypes;

  final __signedExtensionsCached = <String, int>{};
  final __storageCached = <String, Map<String, Map<String, StorageItem>>>{};
  final __constantsCached = <String, Map<String, Map<String, Constant>>>{};

  @override
  int _signedExtensions() {
    final cachedValue = __signedExtensionsCached[""];
    if (cachedValue == null) {
      final int toReturn;
      try {
        final result = super._signedExtensions();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      __signedExtensionsCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }

  @override
  Map<String, Map<String, StorageItem>> _storage() {
    final cachedValue = __storageCached[""];
    if (cachedValue == null) {
      final Map<String, Map<String, StorageItem>> toReturn;
      try {
        final result = super._storage();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      __storageCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }

  @override
  Map<String, Map<String, Constant>> _constants() {
    final cachedValue = __constantsCached[""];
    if (cachedValue == null) {
      final Map<String, Map<String, Constant>> toReturn;
      try {
        final result = super._constants();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      __constantsCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }
}
