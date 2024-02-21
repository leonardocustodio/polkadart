part of parsers;

class V14Parser {
  late final DecodedMetadata decodedMetadata;
  late final MetadataV14 _metadataV14;
  late final MetadataV14Expander _metadataExpander;
  final Registry _resultingRegistry = Registry();

  V14Parser(this.decodedMetadata) {
    _metadataV14 = (decodedMetadata.metadataObject.value as MetadataV14);

    //
    // Expand the V14 compressed types and then map the siTypes id to the type names.
    _metadataExpander =
        MetadataV14Expander(decodedMetadata.metadataJson['lookup']['types']);
  }

  ChainInfo getChainInfo() {
    final rawMetadata = decodedMetadata.metadataJson;

    //
    // copy of the siTypes map
    final siTypes = Map<int, String>.from(_metadataExpander.registeredSiType);

    final callsCodec = <int, MapEntry<String, Codec>>{};
    final eventsCodec = <int, MapEntry<String, Codec>>{};
    //
    // Temporariy referencing it to GenericCall until the real GenericCall is created below
    // and
    // then add it to the _resultingRegistry
    {
      final proxyCodec = ProxyCodec();
      _resultingRegistry.addCodec('Call', proxyCodec);
      _resultingRegistry.addCodec('RuntimeCall', proxyCodec);
    }

    // Iterate over the pallets
    //
    // Set the types names for the storage, calls, events, constants
    for (final pallet in rawMetadata['pallets']) {
      // pallet name
      final palletName = pallet['name'];
      // pallet index
      final palletIndex = pallet['index'];

      //
      // calls
      final calls = <int, MapEntry<String, Map<String, dynamic>>>{};
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

          calls[variant['index']] = MapEntry(variant['name'], {
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
        for (final callEntry in calls.entries) {
          final int callIndex = callEntry.key;
          final MapEntry<String, Map<String, dynamic>> callValue =
              callEntry.value;

          final List<Map<String, dynamic>> callArgs =
              (callValue.value['args'] as List<dynamic>)
                  .cast<Map<String, dynamic>>();

          final Map<String, Codec> codecs = <String, Codec>{};
          final List<Codec> codecList = <Codec>[];

          late Codec argsCodec;
          for (final arg in callArgs) {
            final argName = arg['name'];
            final typeName = arg['type'];

            final codec = _resultingRegistry.parseSpecificCodec(
                _metadataExpander.customCodecRegister, typeName);
            codecList.add(codec);
            codecs[argName] = codec;
          }

          if (codecs.length != callArgs.length) {
            argsCodec = TupleCodec(codecList);
          } else {
            argsCodec = CompositeCodec(codecs);
          }
          callEnumCodec[callIndex] = MapEntry(callValue.key, argsCodec);
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

            final codec = _resultingRegistry.parseSpecificCodec(
                _metadataExpander.customCodecRegister, typeName);
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
    // Register the Generic Call
    {
      // replace the proxy of GenericCall with the real GenericCall
      final proxyCodec = _resultingRegistry.getCodec('Call')! as ProxyCodec;
      proxyCodec.codec = ComplexEnumCodec.sparse(callsCodec);
    }

    //
    // Register the Generic Event
    _resultingRegistry.addCodec(
        'GenericEvent', ComplexEnumCodec.sparse(eventsCodec));

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
      _resultingRegistry.parseSpecificCodec(eventType, 'EventCodec');
    }

    {
      //
      // Configure the Extrinsics Signature Codec.

      _resultingRegistry.addCodec('Era', EraExtrinsic.codec);

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
            final codec = _resultingRegistry.parseSpecificCodec(
                _metadataExpander.customCodecRegister, siTypeName);
            extrinsicSignature[name] = codec;
        }
      }

      // SignedExtensions Parsing
      {
        final signedExtensionsCompositeCodec = <String, Codec>{};

        // Set the extrinsic version which would be helpful further in extrinsic and signing payload.
        _resultingRegistry.extrinsicVersion =
            rawMetadata['extrinsic']['version']!;

        // clear the signedExtensions in the registry
        _resultingRegistry.signedExtensions.clear();

        for (final signedExtensions in rawMetadata['extrinsic']
            ['signedExtensions']) {
          final type = siTypes[signedExtensions['type']];
          final additionalSignedType =
              siTypes[signedExtensions['additionalSigned']];
          final identifier = signedExtensions['identifier'].toString();

          // put a NullCodec which does nothing
          _resultingRegistry.signedExtensions[identifier] = NullCodec.codec;

          // put a NullCodec which does nothing
          _resultingRegistry.additionalSignedExtensions[identifier] =
              NullCodec.codec;

          if (type == null || type.toLowerCase() == 'null') {
            continue;
          }
          final typeCodec = _resultingRegistry.parseSpecificCodec(
              _metadataExpander.customCodecRegister, type);

          // overwrite the codec here.
          _resultingRegistry.signedExtensions[identifier] = typeCodec;

          if (additionalSignedType != null ||
              additionalSignedType?.toLowerCase() != 'null') {
            final additionalSignedTypeCodec =
                _resultingRegistry.parseSpecificCodec(
                    _metadataExpander.customCodecRegister,
                    additionalSignedType!);

            // overwrite the additional signed codec here.
            _resultingRegistry.additionalSignedExtensions[identifier] =
                additionalSignedTypeCodec;
          }

          String newIdentifier = identifier.replaceAll('Check', '');
          switch (newIdentifier) {
            case 'Mortality':
              signedExtensionsCompositeCodec['era'] =
                  _resultingRegistry.parseSpecificCodec(
                      _metadataExpander.customCodecRegister, 'Era');
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

        _resultingRegistry.addCodec('ExtrinsicSignatureCodec', extrinsicCodec);
      }
    }

    return ChainInfo(
      scaleCodec: ScaleCodec(_resultingRegistry),
      version: decodedMetadata.version,
      constants: _constants(),
    );
  }

  Map<String, Map<String, Constant>> _constants() {
    final constants = <String, Map<String, Constant>>{};
    for (final pallet in _metadataV14.pallets) {
      for (final constant in pallet.constants) {
        constants[pallet.name] ??= <String, Constant>{};

        final String type = _metadataExpander.registeredSiType[constant.type]!;

        constants[pallet.name]![constant.name] = Constant(
            type: _getCodecFromType(type),
            bytes: constant.value,
            docs: constant.docs);

        // parse the codec for the constant and register it
      }
    }
    return constants;
  }

  Codec _getCodecFromType(String type) {
    return _resultingRegistry.parseSpecificCodec(
        _metadataExpander.customCodecRegister, type);
  }
}
