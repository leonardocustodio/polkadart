part of parsers;

class V14Parser {
  static ChainInfo getChainInfo(DecodedMetadata metadata) {
    final rawMetadata = metadata.metadataJson;

    //
    // Expand the V14 compressed types and then mapp the siTypes id to the type names.
    final metadataExpander =
        MetadataV14Expander(rawMetadata['lookup']['types']);

    //
    // copy of the siTypes map
    final siTypes = Map<int, String>.from(metadataExpander.registeredSiType);

    final callsCodec = <int, MapEntry<String, Codec>>{};
    final eventsCodec = <int, MapEntry<String, Codec>>{};

    final Registry resultingRegistry = Registry();
    //
    // Temporariy referencing it to GenericCall until the real GenericCall is created below
    // and
    // then add it to the resultingRegistry
    resultingRegistry.addCodec(
        'Call',
        ReferencedCodec(
            referencedType: 'GenericCall', registry: resultingRegistry));

    // Iterate over the pallets
    //
    // Set the types names for the storage, calls, events, constants
    for (var i = 0; i < rawMetadata['pallets'].length; i++) {
      final pallet = rawMetadata['pallets'][i];
      // pallet name
      final palletName = pallet['name'];
      // pallet index
      final palletIndex = pallet['index'];

      //
      // calls
      final calls = <Map<String, dynamic>>[];
      if (pallet['calls'] != null) {
        final variants =
            rawMetadata['lookup']['types'][pallet['calls']['type']];
        for (final variant in variants['type']['def']['Variant']['variants']) {
          // fill args
          final args = <Map<String, dynamic>>[];

          // iterate over fields of each variant
          for (final v in variant['fields']) {
            args.add({
              'name': v['name'],
              'type': siTypes[v['type']],
            });
          }

          calls.add({
            'name': variant['name'],
            'args': args,
            'docs': variant['docs'],
          });
        }
      }

      //
      // events
      final events = <Map<String, dynamic>>[];
      if (pallet['events'] != null) {
        final variants =
            rawMetadata['lookup']['types'][pallet['events']['type']];
        for (final variant in variants['type']['def']['Variant']['variants']) {
          // fill args
          final args = <Map<String, dynamic>>[];

          // iterate over fields of each variant
          for (final v in variant['fields']) {
            args.add({
              'name': v['typeName'],
              'type': siTypes[v['type']],
            });
          }

          events.add({
            'name': variant['name'],
            'args': args,
            'docs': variant['docs'],
          });
        }
      }

      {
        //
        // call lookup filling
        final callEnumCodec = <int, MapEntry<String, Codec>>{};
        for (var callIndex = 0; callIndex < calls.length; callIndex++) {
          final call = calls[callIndex];

          final List<Map<String, dynamic>> callArgs =
              (call['args'] as List<dynamic>).cast<Map<String, dynamic>>();

          final Map<String, Codec> codecs = <String, Codec>{};
          final List<Codec> codecList = <Codec>[];

          late Codec argsCodec;
          for (final arg in callArgs) {
            final argName = arg['name'];
            final typeName = arg['type'];

            final codec = resultingRegistry.parseSpecificCodec(
                metadataExpander.customCodecRegister, typeName);
            codecList.add(codec);
            codecs[argName] = codec;
          }

          if (codecs.length != callArgs.length) {
            argsCodec = TupleCodec(codecList);
          } else {
            argsCodec = CompositeCodec(codecs);
          }
          callEnumCodec[callIndex] = MapEntry(call['name'], argsCodec);
        }
        callsCodec[palletIndex] =
            MapEntry(palletName, ComplexEnumCodec.sparse(callEnumCodec));
      }

      {
        //
        // event lookup filling
        final eventEnumCodec = <int, MapEntry<String, Codec>>{};
        for (var eventIndex = 0; eventIndex < events.length; eventIndex++) {
          final event = events[eventIndex];

          final List<Map<String, dynamic>> eventArgs =
              (event['args'] as List<dynamic>).cast<Map<String, dynamic>>();

          final Map<String, Codec> codecs = <String, Codec>{};
          final List<Codec> codecsList = <Codec>[];

          late Codec argsCodec;
          for (final arg in eventArgs) {
            final argName = arg['name'];
            final typeName = arg['type'];

            final codec = resultingRegistry.parseSpecificCodec(
                metadataExpander.customCodecRegister, typeName);
            codecsList.add(codec);
            codecs[argName] = codec;
          }

          if (eventArgs.length != codecs.length) {
            argsCodec = TupleCodec(codecsList);
          } else {
            argsCodec = CompositeCodec(codecs);
          }
          eventEnumCodec[eventIndex] = MapEntry(event['name'], argsCodec);
        }
        eventsCodec[palletIndex] =
            MapEntry(palletName, ComplexEnumCodec.sparse(eventEnumCodec));
      }
    }

    //
    // Register the Generics
    resultingRegistry
      ..addCodec('GenericCall', ComplexEnumCodec.sparse(callsCodec))
      ..addCodec('GenericEvent', ComplexEnumCodec.sparse(eventsCodec));

    {
      //
      // Create the Event Codecs

      // Sample Registry Map for the Event Definitions
      final eventType = <String, dynamic>{
        'Phase': {
          '_enum': {
            'ApplyExtrinsic': 'u32',
            'Finalization': 'Null',
            'Initialization': 'Null',
          }
        },
        'EventRecord': {
          'phase': 'Phase',
          'event':
              'GenericEvent', // GenericEvent is already registered in line: 244
          'topics': 'Vec<Str>'
        },
        'EventCodec': 'Vec<EventRecord>',
      };

      // Parses the EventCodec from the above eventTye
      resultingRegistry.parseSpecificCodec(eventType, 'EventCodec');
    }

    {
      //
      // Configure the Extrinsics Signature Codec.

      resultingRegistry.addCodec('Era', EraExtrinsic.codec);

      // integrating Code for ExtrinsicSignature
      final extrinsicTypeId = rawMetadata['extrinsic']['type'];
      final extrinsicDef = rawMetadata['lookup']['types'][extrinsicTypeId];

      final extrinsicSignature = <String, Codec>{};

      for (final params in extrinsicDef['type']['params']) {
        final name = params['name'].toString().toLowerCase();
        switch (name) {
          case 'extra':
          case 'call':
            break;
          default:
            final siTypeName = siTypes[params['type']]!;
            final codec = resultingRegistry.parseSpecificCodec(
                metadataExpander.customCodecRegister, siTypeName);
            extrinsicSignature[name] = codec;
        }
      }
      final signedExtensionsCompositeCodec = <String, Codec>{};

      for (final signedExtensions in rawMetadata['extrinsic']
          ['signedExtensions']) {
        final type = siTypes[signedExtensions['type']];

        if (type == null || type.toLowerCase() == 'null') {
          continue;
        }
        final typeCodec = resultingRegistry.parseSpecificCodec(
            metadataExpander.customCodecRegister, type);

        final identifier =
            signedExtensions['identifier'].toString().replaceAll('Check', '');
        String newIdentifier = identifier;
        switch (identifier) {
          case 'Mortality':
            signedExtensionsCompositeCodec['era'] =
                resultingRegistry.parseSpecificCodec(
                    metadataExpander.customCodecRegister, 'Era');
            continue;
          case 'ChargeTransactionPayment':
            newIdentifier = 'tip';
            break;
          default:
        }
        signedExtensionsCompositeCodec[newIdentifier.snakeCase()] = typeCodec;
      }

      final extrinsicCodec = CompositeCodec(
        {
          ...extrinsicSignature,
          'signedExtensions': CompositeCodec(signedExtensionsCompositeCodec),
        },
      );

      resultingRegistry.addCodec('ExtrinsicSignatureCodec', extrinsicCodec);
    }

    return ChainInfo(
        scaleCodec: ScaleCodec(resultingRegistry), version: metadata.version);
  }
}
