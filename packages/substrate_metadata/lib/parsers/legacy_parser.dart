part of parsers;

class LegacyParser {
  static ChainInfo getChainInfo(
      DecodedMetadata decodedMetadata, LegacyTypes legacyTypes) {
    final rawMetadata = decodedMetadata.metadataJson;
    final modules = rawMetadata['modules'];

    final extraTypes = <String, String>{};

    int callModuleIndex = -1;
    int eventModuleIndex = -1;
    for (final module in modules) {
      if (module['calls'] != null) {
        callModuleIndex++;
        rawMetadata['call_index'] ??= <String, dynamic>{};
        for (var callIndex = 0;
            callIndex < module['calls'].length;
            callIndex++) {
          final call = module['calls'][callIndex];

          final lookup = encodeHex([module['index'] ?? callModuleIndex, callIndex]);

          rawMetadata['call_index'][lookup] = {
            'module': {'name': module['name']},
            'call': call,
          };
        }
      }
      if (module['events'] != null) {
        eventModuleIndex++;
        rawMetadata['event_index'] ??= <String, dynamic>{};
        for (var eventIndex = 0;
            eventIndex < module['events'].length;
            eventIndex++) {
          final event = module['events'][eventIndex];

          final lookup =
              encodeHex([module['index'] ?? eventModuleIndex, eventIndex]);

          rawMetadata['event_index'][lookup] = {
            'module': {'name': module['name']},
            'call': event,
          };
          final args = event['args'];
          for (final arg in args) {
            late String type;
            if (arg is String) {
              // In case of legacy metadata
              type = arg;
            } else if (arg is Map<String, dynamic>) {
              // In case of v14 metadata
              type = arg['type'];
            } else {
              throw Exception('Unknown type of arg: $arg');
            }
            extraTypes[type] = type;
          }
        }
      }
    }
    List<String> extraTypesKeys = extraTypes.keys.toList();

    for (final type in extraTypesKeys) {
      if (legacyTypes.types[type] != null) {
        extraTypes.remove(type);
      }
    }

    //
    // Get already processed versioned registry from singleton
    final registry = RegistryCreator.instance[decodedMetadata.version];

    //
    // Register the Call type
    registry.addCodec('Call', Call(registry: registry, metadata: rawMetadata));
    // ignore: unnecessary_cast
    registry.registerCustomCodec(legacyTypes.types as Map<String, dynamic>);

    extraTypesKeys = extraTypes.keys.toList();

    registry.registerCustomCodec(extraTypes);

    return ChainInfo(
        registry: registry,
        metadata: rawMetadata,
        version: decodedMetadata.version);
  }
}
