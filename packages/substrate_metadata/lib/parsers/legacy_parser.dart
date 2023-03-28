part of parsers;

/// FilterTypedef helps to filter the modules that are not needed
typedef FilterTypedef = dynamic Function(AnyLegacyModule mod);

/// PalletTypedef helps to call the function for each module and passes the module and the index
typedef PalletTypedef = void Function(AnyLegacyModule mod, int index);

class LegacyParser {
  final DecodedMetadata decodedMetadata;
  final LegacyTypes legacyTypes;

  final _resultingRegistry = Registry();

  late final TypeNormalizer _typeNormalizer;

  LegacyParser(this.decodedMetadata, this.legacyTypes) {
    _typeNormalizer = TypeNormalizer(
      types: legacyTypes.types,
      typesAlias: legacyTypes.typesAlias ?? <String, Map<String, String>>{},
    );
  }

  ChainInfo getChainInfo() {
    final rawMetadata = decodedMetadata.metadataJson;

    _defineCalls();

    int callModuleIndex = -1;
    int eventModuleIndex = -1;

    _resultingRegistry.addCodec('Call', ProxyCodec());

    final genericCallsCodec = <int, MapEntry<String, Codec>>{};
    final genericEventsCodec = <int, MapEntry<String, Codec>>{};

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
                final codec = _getCodecFromType(arg, moduleName);
                codecs.add(codec);
              }
              argsCodec = TupleCodec(codecs);
            } else if (args.first is Map<String, dynamic>) {
              // List<Map<String, dynamic>>
              final Map<String, Codec> codecs = <String, Codec>{};

              for (final arg in args) {
                final String name = arg['name'];
                final String argType = arg['type'];

                codecs[name] = _getCodecFromType(argType, moduleName);
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
                final codec = _getCodecFromType(arg, moduleName);
                codecs.add(codec);
              }
              argsCodec = TupleCodec(codecs);
            } else if (args.first is Map<String, dynamic>) {
              // List<Map<String, dynamic>>
              final Map<String, Codec> codecs = <String, Codec>{};

              for (final arg in args) {
                final String name = arg['name'];
                final String argType = arg['type'];

                codecs[name] = _getCodecFromType(argType, moduleName);
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
    //
    // Register the Generic Call
    {
      // replace the proxy of GenericCall with the real GenericCall
      final proxyCodec = _resultingRegistry.getCodec('Call')! as ProxyCodec;
      proxyCodec.codec = ComplexEnumCodec.sparse(genericCallsCodec);
    }

    //
    // Register the Generic Event
    _resultingRegistry.addCodec(
        'GenericEvent', ComplexEnumCodec.sparse(genericEventsCodec));

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
      version: decodedMetadata.version,
      constants: _constants(),
    );
  }

  Codec _getCodecFromType(String type, String? moduleName) {
    final String parsedType =
        _typeNormalizer.normalize(type, moduleName).toString();

    return _resultingRegistry.parseSpecificCodec(legacyTypes.types, parsedType);
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

  Map<String, Map<String, Constant>> _constants() {
    final constants = <String, Map<String, Constant>>{};
    _forEachPallet(pallet: (module, _) {
      for (final constant in module.constants) {
        constants[module.name] ??= <String, Constant>{};

        constants[module.name]![constant.name] = Constant(
            type: _getCodecFromType(constant.type, module.name),
            bytes: constant.value,
            docs: constant.docs);
      }
    });
    return constants;
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

  void _forEachPallet({
    required PalletTypedef pallet,
    FilterTypedef? filter,
  }) {
    final metadata = decodedMetadata.metadataObject;
    switch (metadata.version) {
      case 9:
      case 10:
      case 11:
        var index = 0;
        for (final module in metadata.value.modules) {
          if (filter != null && filter(module) == null) {
            continue;
          }
          pallet(module, index);
          index += 1;
        }
        return;

      case 12:
      case 13:
        for (final module in metadata.value.modules) {
          if (filter != null && filter(module) == null) {
            continue;
          }
          pallet(module, module.index);
        }
        return;
    }
  }
}
