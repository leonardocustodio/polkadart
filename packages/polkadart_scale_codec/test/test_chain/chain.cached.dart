// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'chain.dart';

// **************************************************************************
// CachedGenerator
// **************************************************************************

abstract class _$Chain {
  String get name;
}

class _Chain with Chain implements _$Chain {
  _Chain(this.name);

  @override
  final String name;

  final _versionsCached = <String, List<SpecVersion>>{};
  final _blockNumbersCached = <String, List<int>>{};
  final _eventsCached = <String, List<RawBlockEvents>>{};
  final _decodedEventsCached = <String, List<DecodedBlockEvents>>{};
  final _getVersionCached = <String, VersionDescription>{};
  final _descriptionCached = <String, List<VersionDescription>>{};

  @override
  List<SpecVersion> versions() {
    final cachedValue = _versionsCached[""];
    if (cachedValue == null) {
      final List<SpecVersion> toReturn;
      try {
        final result = super.versions();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      _versionsCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }

  @override
  List<int> blockNumbers() {
    final cachedValue = _blockNumbersCached[""];
    if (cachedValue == null) {
      final List<int> toReturn;
      try {
        final result = super.blockNumbers();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      _blockNumbersCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }

  @override
  List<RawBlockEvents> events() {
    final cachedValue = _eventsCached[""];
    if (cachedValue == null) {
      final List<RawBlockEvents> toReturn;
      try {
        final result = super.events();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      _eventsCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }

  @override
  List<DecodedBlockEvents> decodedEvents() {
    final cachedValue = _decodedEventsCached[""];
    if (cachedValue == null) {
      final List<DecodedBlockEvents> toReturn;
      try {
        final result = super.decodedEvents();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      _decodedEventsCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }

  @override
  VersionDescription getVersion(int blockNumber) {
    final cachedValue = _getVersionCached["${blockNumber.hashCode}"];
    if (cachedValue == null) {
      final VersionDescription toReturn;
      try {
        final result = super.getVersion(blockNumber);

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      _getVersionCached["${blockNumber.hashCode}"] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }

  @override
  List<VersionDescription> description() {
    final cachedValue = _descriptionCached[""];
    if (cachedValue == null) {
      final List<VersionDescription> toReturn;
      try {
        final result = super.description();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      _descriptionCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }
}
