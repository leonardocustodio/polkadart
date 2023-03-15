part of parsers;

class LegacyParser {
  final DecodedMetadata decodedMetadata;
  final LegacyTypes legacyTypes;

  final _resultingRegistry = Registry();

  LegacyParser(this.decodedMetadata, this.legacyTypes);

  ChainInfo getChainInfo() {
    final rawMetadata = decodedMetadata.metadataJson;

    _defineCalls();

    int callModuleIndex = -1;
    int eventModuleIndex = -1;

    _resultingRegistry.addCodec(
        'Call',
        ReferencedCodec(
            referencedType: 'GenericCall', registry: _resultingRegistry));

    final genericCallsCodec = <int, MapEntry<String, Codec>>{};
    final genericEventsCodec = <int, MapEntry<String, Codec>>{};

    final typeNormalizer = TypeNormalizer(
      types: legacyTypes.types,
      typesAlias: legacyTypes.typesAlias ?? <String, Map<String, String>>{},
    );

    for (final module in rawMetadata['modules']) {
      // Getting the module name and converting it to camelCase
      final String moduleName = module['name']!;

      if (module['calls'] != null) {
        callModuleIndex++;

        final index = module['index'] ?? callModuleIndex;

        final callEnumCodec = <int, MapEntry<String, Codec>>{};
        for (var callIndex = 0;
            callIndex < module['calls'].length;
            callIndex++) {
          final call = module['calls'][callIndex];

          final List<dynamic> args = call['args'];
          Codec argsCodec = NullCodec.codec;

          if (args.isNotEmpty) {
            if (args.first is String) {
              // List<String>
              final codecs = <Codec>[];
              for (final String arg in args) {
                final String parsedType =
                    typeNormalizer.normalize(arg, moduleName).toString();

                final Codec codec = _resultingRegistry.parseSpecificCodec(
                    legacyTypes.types, parsedType);
                codecs.add(codec);
              }
              argsCodec = TupleCodec(codecs);
            } else if (args.first is Map<String, dynamic>) {
              // List<Map<String, dynamic>>
              final Map<String, Codec> codecs = <String, Codec>{};

              for (final arg in args) {
                final String name = arg['name'];
                final String argType = arg['type'];

                final String parsedType =
                    typeNormalizer.normalize(argType, moduleName).toString();

                final Codec codec = _resultingRegistry.parseSpecificCodec(
                    legacyTypes.types, parsedType);

                codecs[name] = codec;
              }
              argsCodec = CompositeCodec(codecs);
            } else {
              throw Exception('Unknown type of args: $args');
            }
          }
          callEnumCodec[callIndex] = MapEntry(call['name'], argsCodec);
        }
        genericCallsCodec[index] =
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

          Codec argsCodec = NullCodec.codec;

          if (args.isNotEmpty) {
            if (args.first is String) {
              // List<String>
              final codecs = <Codec>[];
              for (final String arg in args) {
                final String parsedType =
                    typeNormalizer.normalize(arg, moduleName).toString();

                final Codec codec = eventRegistry.parseSpecificCodec(
                    legacyTypes.types, parsedType);
                codecs.add(codec);
              }
              argsCodec = TupleCodec(codecs);
            } else if (args.first is Map<String, dynamic>) {
              // List<Map<String, dynamic>>
              final Map<String, Codec> codecs = <String, Codec>{};

              for (final arg in args) {
                final String name = arg['name'];
                final String argType = arg['type'];

                final String parsedType =
                    typeNormalizer.normalize(argType, moduleName).toString();

                final Codec codec = eventRegistry.parseSpecificCodec(
                    legacyTypes.types, parsedType);

                codecs[name] = codec;
              }
              argsCodec = CompositeCodec(codecs);
            } else {
              throw Exception('Unknown type of args: $args');
            }
          }
          eventEnumCodec[eventIndex] = MapEntry(event['name'], argsCodec);
        }
        genericEventsCodec[index] =
            MapEntry(module['name'], ComplexEnumCodec.sparse(eventEnumCodec));
      }
    }

    _resultingRegistry
      ..addCodec('GenericCall', ComplexEnumCodec.sparse(genericCallsCodec))
      ..addCodec('GenericEvent', ComplexEnumCodec.sparse(genericEventsCodec));

    {
      //
      // Configure the events codec
      final eventCodec = _resultingRegistry.parseSpecificCodec(
          legacyTypes.types, 'EventRecord');

      _resultingRegistry
        ..addCodec('EventRecord', eventCodec)
        ..addCodec('EventCodec', SequenceCodec(eventCodec));
    }

    _createExtrinsicCodec();

    return ChainInfo(
        scaleCodec: ScaleCodec(_resultingRegistry),
        version: decodedMetadata.version);
  }

  void _createExtrinsicCodec() {
    //
    // Configure the Extrinsic Signature Codec
    final eraCodec = EraExtrinsic.codec;

    final nonceCodec = _resultingRegistry.parseSpecificCodec(
        legacyTypes.types, 'Compact<Index>');

    final tipCodec = _resultingRegistry.parseSpecificCodec(
        legacyTypes.types, 'Compact<Balance>');

    final addressCodec =
        _resultingRegistry.parseSpecificCodec(legacyTypes.types, 'Address');

    final signatureCodec = _resultingRegistry.parseSpecificCodec(
        legacyTypes.types, 'ExtrinsicSignature');

    final extrinsicCodec = CompositeCodec({
      'address': addressCodec,
      'signature': signatureCodec,
      'signedExtensions': CompositeCodec({
        'era': eraCodec,
        'nonce': nonceCodec,
        'tip': tipCodec,
      }),
    });

    _resultingRegistry.addCodec('ExtrinsicSignatureCodec', extrinsicCodec);
  }

  void _defineCalls() {
    _defineGenericLookUpSource();
  }

  void _defineGenericLookUpSource() {
    final enums = <int, MapEntry<String, Codec>>{};
    for (var i = 0; i < 0xef; i++) {
      enums[i] = MapEntry('Idx$i', NullCodec.codec);
    }
    enums[0xfc] = MapEntry('IdxU16', U16Codec.codec);
    enums[0xfd] = MapEntry('IdxU32', U32Codec.codec);
    enums[0xfe] = MapEntry('IdxU64', U64Codec.codec);
    enums[0xff] = MapEntry('AccountId',
        _resultingRegistry.parseSpecificCodec(legacyTypes.types, 'AccountId'));

    _resultingRegistry.addCodec(
        'GenericLookupSource', ComplexEnumCodec.sparse(enums));
  }
}
