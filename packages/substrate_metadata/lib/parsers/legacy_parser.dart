part of parsers;

class LegacyParser {
  static ChainInfo getChainInfo(DecodedMetadata decodedMetadata) {
    final rawMetadata = decodedMetadata.metadataJson;
    final modules = rawMetadata['modules'];

    for (var moduleIndex = 0; moduleIndex < modules.length; moduleIndex++) {
      final module = modules[moduleIndex];
      if (module['calls'] != null) {
        rawMetadata['call_index'] ??= <String, dynamic>{};
        for (var callIndex = 0;
            callIndex < module['calls'].length;
            callIndex++) {
          final lookup =
              (moduleIndex + callIndex).toRadixString(16).padLeft(4, '0');

          final call = module['calls'][callIndex];

          rawMetadata['call_index'][lookup] = {
            'module': {'name': module['name']},
            'call': call,
          };
        }
      }

      if (module['events'] != null) {
        rawMetadata['event_index'] ??= <String, dynamic>{};
        for (var eventIndex = 0;
            eventIndex < module['events'].length;
            eventIndex++) {
          final lookup =
              (moduleIndex + eventIndex).toRadixString(16).padLeft(4, '0');

          final event = module['events'][eventIndex];

          rawMetadata['event_index'][lookup] = {
            'module': {'name': module['name']},
            'call': event,
          };
        }
      }
    }

    //
    // Get already processed versioned registry from singleton
    final registry = RegistryCreator.instance[decodedMetadata.version];

    //
    // Register the Call type
    registry.addCodec('Call', Call(registry: registry, metadata: rawMetadata));
    //registry.registerCustomCodec(legacyTypes.types);

    return ChainInfo(
        registry: registry,
        metadata: rawMetadata,
        version: decodedMetadata.version);
  }
}
