part of parsers;

class LegacyParser {
  static ChainInfo getChainInfo(
      DecodedMetadata decodedMetadata, LegacyTypes legacyTypes) {
    final rawMetadata = decodedMetadata.metadataJson;

    int callModuleIndex = -1;
    int eventModuleIndex = -1;

    final resultingRegistry = Registry();

    final callsCodec = <int, MapEntry<String, Codec>>{};
    final eventsCodec = <int, MapEntry<String, Codec>>{};
    for (final module in rawMetadata['modules']) {
      // Getting the module name and converting it to camelCase
      String moduleName = module['name'];
      moduleName = moduleName[0].toLowerCase() + moduleName.substring(1);

      // Getting the aliases for this specific module
      final Map<String, String>? moduleNameAlias =
          substrateTypesAlias[moduleName];

      final Map<String, dynamic> types =
          Map<String, dynamic>.from(legacyTypes.types);

      if (moduleNameAlias != null) {
        // overriding the types with the aliases for this specific module
        types.addAll(moduleNameAlias);
      }

      final callRegistry = Registry();
      callRegistry.addCodec(
          'Call',
          ReferencedCodec(
              referencedType: 'GenericCall', registry: resultingRegistry));

      if (module['calls'] != null) {
        callModuleIndex++;

        final index = module['index'] ?? callModuleIndex;

        final callEnumCodec = <int, MapEntry<String, Codec>>{};
        for (var callIndex = 0;
            callIndex < module['calls'].length;
            callIndex++) {
          final call = module['calls'][callIndex];

          final List<dynamic> args = call['args'];
          Codec argsCodec = TupleCodec([]);

          if (args.isNotEmpty) {
            if (args.first is String) {
              // List<String>
              final codecs = <Codec>[];
              for (final String arg in args) {
                final String type = legacyTypeSimplifier(arg);
                final Codec codec =
                    callRegistry.parseSpecificCodec(types, type);
                codecs.add(codec);
              }
              argsCodec = TupleCodec(codecs);
            } else if (args.first is Map<String, dynamic>) {
              // List<Map<String, dynamic>>
              final Map<String, Codec> codecs = <String, Codec>{};

              for (final arg in args) {
                final String name = arg['name'];

                final String type = legacyTypeSimplifier(arg['type']);

                final Codec codec =
                    callRegistry.parseSpecificCodec(types, type);

                codecs[name] = codec;
              }
              argsCodec = CompositeCodec(codecs);
            } else {
              throw Exception('Unknown type of args: $args');
            }
          }
          callEnumCodec[callIndex] = MapEntry(call['name'], argsCodec);
        }
        callsCodec[index] =
            MapEntry(module['name'], ComplexEnumCodec.sparse(callEnumCodec));
      }

      //
      // Events Parsing
      final eventRegistry = Registry();

      if (module['events'] != null) {
        eventModuleIndex++;

        final index = module['index'] ?? eventModuleIndex;

        final eventEnumCodec = <int, MapEntry<String, Codec>>{};
        for (var eventIndex = 0;
            eventIndex < module['events'].length;
            eventIndex++) {
          final event = module['events'][eventIndex];

          final List<dynamic> args = event['args'];

          Codec argsCodec = TupleCodec([]);

          if (args.isNotEmpty) {
            if (args.first is String) {
              // List<String>
              final codecs = <Codec>[];
              for (final String arg in args) {
                final String type = legacyTypeSimplifier(arg);
                final Codec codec =
                    eventRegistry.parseSpecificCodec(types, type);
                codecs.add(codec);
              }
              argsCodec = TupleCodec(codecs);
            } else if (args.first is Map<String, dynamic>) {
              // List<Map<String, dynamic>>
              final Map<String, Codec> codecs = <String, Codec>{};

              for (final arg in args) {
                final String name = arg['name'];

                final String type = legacyTypeSimplifier(arg['type']);

                final Codec codec =
                    eventRegistry.parseSpecificCodec(types, type);

                codecs[name] = codec;
              }
              argsCodec = CompositeCodec(codecs);
            } else {
              throw Exception('Unknown type of args: $args');
            }
          }
          eventEnumCodec[eventIndex] = MapEntry(event['name'], argsCodec);
        }
        eventsCodec[index] =
            MapEntry(module['name'], ComplexEnumCodec.sparse(eventEnumCodec));
      }
    }
    resultingRegistry
      ..addCodec('GenericCall', ComplexEnumCodec.sparse(callsCodec))
      ..addCodec('GenericEvent', ComplexEnumCodec.sparse(eventsCodec));

    {
      //
      // Configure the events codec
      final eventCodec = resultingRegistry.parseSpecificCodec(
          legacyTypes.types, 'EventRecord');

      resultingRegistry
        ..addCodec('EventRecord', eventCodec)
        ..addCodec('EventCodec', SequenceCodec(eventCodec));
    }

    {
      //
      // Configure the Extrinsic Signature Codec
      final eraCodec = EraExtrinsic.codec;
      final nonceCodec = CompactBigIntCodec.codec;
      Codec? tipCodec;

      final extrinsic = rawMetadata['extrinsic'];
      if (extrinsic != null &&
          extrinsic['signedExtensions'] is List &&
          extrinsic['signedExtensions'] != null &&
          extrinsic['signedExtensions'].isNotEmpty) {
        final signedExtensions =
            (extrinsic['signedExtensions'] as List<dynamic>).cast<String>();
        if (signedExtensions.contains('ChargeTransactionPayment')) {
          tipCodec = CompactBigIntCodec.codec;
        }
      }

      final addressCodec =
          resultingRegistry.parseSpecificCodec(legacyTypes.types, 'Address');

      final signatureCodec = resultingRegistry.parseSpecificCodec(
          legacyTypes.types, 'ExtrinsicSignature');

      final extrinsicCodec = CompositeCodec({
        'address': addressCodec,
        'signature': signatureCodec,
        'signedExtensions': CompositeCodec({
          'era': eraCodec,
          'nonce': nonceCodec,
          if (tipCodec != null) 'tip': tipCodec,
        }),
      });

      resultingRegistry.addCodec('ExtrinsicSignatureCodec', extrinsicCodec);
    }

    return ChainInfo(
        scaleCodec: ScaleCodec(resultingRegistry),
        version: decodedMetadata.version);
  }
}
