// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'chain.dart';

// **************************************************************************
// CachedGenerator
// **************************************************************************

abstract class _$Chain {
  String get chainName;
}

class _Chain with Chain implements _$Chain {
  _Chain(this.chainName);

  @override
  final String chainName;

  final _versionsCached = <String, List<SpecVersion>>{};
  final _blockNumbersCached = <String, List<int>>{};
  final _getBlocksCached = <String, List<RawBlock>>{};
  final _eventsCached = <String, List<RawBlockEvents>>{};
  final _decodedExtrinsicsCached = <String, List<DecodedBlockExtrinsics>>{};
  final _decodedEventsCached = <String, List<DecodedBlockEvents>>{};
  final _getVersionCached = <String, VersionDescription>{};
  final _getDescriptionCached = <String, List<VersionDescription>>{};

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
  List<RawBlock> getBlocks() {
    final cachedValue = _getBlocksCached[""];
    if (cachedValue == null) {
      final List<RawBlock> toReturn;
      try {
        final result = super.getBlocks();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      _getBlocksCached[""] = toReturn;

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
  List<DecodedBlockExtrinsics> decodedExtrinsics() {
    final cachedValue = _decodedExtrinsicsCached[""];
    if (cachedValue == null) {
      final List<DecodedBlockExtrinsics> toReturn;
      try {
        final result = super.decodedExtrinsics();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      _decodedExtrinsicsCached[""] = toReturn;

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
  List<VersionDescription> getDescription() {
    final cachedValue = _getDescriptionCached[""];
    if (cachedValue == null) {
      final List<VersionDescription> toReturn;
      try {
        final result = super.getDescription();

        toReturn = result;
      } catch (_) {
        rethrow;
      } finally {}

      _getDescriptionCached[""] = toReturn;

      return toReturn;
    } else {
      return cachedValue;
    }
  }
}
