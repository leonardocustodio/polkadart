part of parsers;

class LegacyParser {
  static ChainInfo getChainInfo(
      DecodedMetadata decodedMetadata, LegacyTypes legacyTypes) {
    final rawMetadata = decodedMetadata.metadataJson;
    final modules = rawMetadata['modules'];

    int callModuleIndex = -1;
    int eventModuleIndex = -1;
    for (final module in modules) {

      // Getting the module name and converting it to camelCase
      final String moduleName =
          module['name'][0].toLowerCase() + module['name'].substring(1);

      // Getting the aliases for this specific module
      final Map<String, String>? moduleNameAlias =
          substrateTypesAlias[moduleName];

      final Map<String, dynamic> types =
          Map<String, dynamic>.from(legacyTypes.types);

      if (moduleNameAlias != null) {
        // overriding the types with the aliases for this specific module
        types.addAll(moduleNameAlias);
      }

      if (module['calls'] != null) {
        callModuleIndex++;
        for (var callIndex = 0;
            callIndex < module['calls'].length;
            callIndex++) {
          final call = module['calls'][callIndex];

          final lookup =
              encodeHex([module['index'] ?? callModuleIndex, callIndex]);

          final List<dynamic> args = call['args'];

          for (final arg in args) {
            late String type;
            if (arg is String) {
              // In case of legacy metadata
              type = arg;
            } else if (arg is Map<String, dynamic>) {
              type = arg['type'];
            } else {
              throw Exception('Unknown type of arg: $arg');
            }
          }

          rawMetadata['call_index'][lookup] = {
            'module': {'name': module['name']},
            'call': call,
          };
        }
      }

      if (module['events'] != null && module['events'].isNotEmpty) {
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
          }
        }
      }
    }

    //
    // Get already processed versioned registry from singleton
    final registry = RegistryCreator.instance[decodedMetadata.version];

    //
    // Register the Call type
    registry.addCodec(
        'Call', Call(registry: registry, metadata: rawMetadata));
    registry.registerCustomCodec(
        // ignore: unnecessary_cast
        {...legacyTypes.types as Map<String, dynamic>});

    return ChainInfo(
        registry: registry,
        metadata: rawMetadata,
        version: decodedMetadata.version);
  }
}
