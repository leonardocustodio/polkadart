part of parsers;

class NewLegacyParser {
  static ChainInfo getChainInfo(
      DecodedMetadata decodedMetadata, LegacyTypes legacyTypes) {
    final rawMetadata = decodedMetadata.metadataJson;
    final modules = rawMetadata['modules'];

    final extraTypes = <String, String>{};

    int callModuleIndex = -1;
    int eventModuleIndex = -1;
    for (final module in modules) {
      String moduleName = module['name'].toString();
      // convert to snakeCase
      moduleName = moduleName[0].toLowerCase() + moduleName.substring(1);

      final Map<String, String>? moduleNameAlias =
          substrateTypesAlias[moduleName];

      if (module['calls'] != null) {
        callModuleIndex++;
        rawMetadata['call_index'] ??= <String, dynamic>{};
        for (var callIndex = 0;
            callIndex < module['calls'].length;
            callIndex++) {
          final call = module['calls'][callIndex];

          final lookup =
              encodeHex([module['index'] ?? callModuleIndex, callIndex]);

          final List<dynamic> args = call['args'];
          //final List<dynamic> oldArgs = List<dynamic>.from(call['args']);
          //print('module: $moduleName, oldArgs: $oldArgs');
          final List<dynamic> newArgs = args.map(
            (dynamic arg) {
              late String type;
              if (arg is String) {
                // In case of legacy metadata
                type = arg;
                final processedTypeName = Registry().renameType(type);
                final alias = moduleNameAlias?[processedTypeName];
                if (alias != null) {
                  arg = alias;
                } else {
                  arg = processedTypeName;
                }
                extraTypes[arg] = arg;
                return alias;
              } else if (arg is Map<String, dynamic>) {
                type = arg['type'];
                String processedTypeName = Registry().renameType(type);
                if (substrateTypes[processedTypeName] != null &&
                    substrateTypes[processedTypeName]! is String) {
                  processedTypeName =
                      substrateTypes[processedTypeName]! as String;
                }
                final alias = moduleNameAlias?[processedTypeName];
                if (alias != null) {
                  arg['type'] = alias;
                } else {
                  arg['type'] = processedTypeName;
                }
                extraTypes[arg['type']] = arg['type'];

                return arg;
              } else {
                throw Exception('Unknown type of arg: $arg');
              }
            },
          ).toList();

          //print('module: $moduleName, newArgs: $newArgs');
          call['args'] = newArgs;
          //print('-------');

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
            extraTypes[type] = type;
          }
        }
      }
    }
    final List<String> extraTypesKeys = extraTypes.keys.toList();

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
    registry.addCodec(
        'Call', Call(registry: registry, metadata: rawMetadata));
    registry.registerCustomCodec(
        // ignore: unnecessary_cast
        {...extraTypes, ...legacyTypes.types as Map<String, dynamic>});

    final eraCodec = EraExtrinsic.codec;
    final nonceCodec = CompactBigIntCodec.codec;
    Codec? tipCodec;

    final extrinsic = rawMetadata['extrinsic'];
    if (extrinsic != null &&
        extrinsic['signedExtensions'] != null &&
        extrinsic['signedExtensions'].isNotEmpty) {
      final signedExtensions =
          (extrinsic['signedExtensions'] as List<dynamic>).cast<String>();
      if (signedExtensions.contains('ChargeTransactionPayment')) {
        tipCodec = CompactBigIntCodec.codec;
      }
    }

    final extrinsicCodec = CompositeCodec({
      'address': registry.getCodec('Address')!,
      'signature': registry.getCodec('ExtrinsicSignature')!,
      'signedExtensions': CompositeCodec({
        'era': eraCodec,
        'nonce': nonceCodec,
        if (tipCodec != null) 'tip': tipCodec,
      }),
    });

    registry.addCodec('ExtrinsicSignatureCodec', extrinsicCodec);

    return ChainInfo(
        registry: registry,
        metadata: rawMetadata,
        version: decodedMetadata.version);
  }
}
