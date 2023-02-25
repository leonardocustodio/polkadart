part of parsers;

class V14Parser {
  final Map<String, dynamic> metadata;

  const V14Parser({required this.metadata});

  ChainInfo getChainInfo() {
    final rawMetadata = metadata.toJson()['metadata'];

    //
    // Expand the V14 compressed types and then mapp the siTypes id to the type names.
    final metadataExpander =
        MetadataV14Expander(rawMetadata['lookup']['types']);

    //
    // copy of the siTypes map
    final siTypes = Map<int, String>.from(metadataExpander.registeredSiType);

    // Iterate over the pallets
    //
    // Set the types names for the storage, calls, events, constants
    for (var palletIndex = 0;
        palletIndex < rawMetadata['pallets'].length;
        palletIndex++) {
      final pallet = rawMetadata['pallets'][palletIndex];

      //
      // storage
      if (pallet['storage'] != null) {
        for (var storageIndex = 0;
            storageIndex < pallet['storage']['items'].length;
            storageIndex++) {
          final storage = pallet['storage']['items'][storageIndex];
          final storageType = storage['type'];

          if (storageType['Plain'] != null) {
            //
            // for plain
            final siType = siTypes[storageType['Plain']];
            rawMetadata['pallets'][palletIndex]['storage']['items']
                [storageIndex]['type']['plain_type'] = siType;
          } else if (storageType['Map'] != null) {
            //
            // for map

            // key
            rawMetadata['pallets'][palletIndex]['storage']['items']
                    [storageIndex]['type']['Map']['key_type'] =
                siTypes[storageType['Map']['key']];

            // value
            rawMetadata['pallets'][palletIndex]['storage']['items']
                    [storageIndex]['type']['Map']['value_type'] =
                siTypes[storageType['Map']['value']];
          }
        }
      }

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
              'name': v['name'],
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

      //
      // call lookup filling
      rawMetadata['call_index'] = <String, dynamic>{};
      for (var callIndex = 0; callIndex < calls.length; callIndex++) {
        final call = calls[callIndex];
        final lookup = ((pallet['index'] + callIndex) as int)
            .toRadixString(16)
            .padLeft(4, '0');
        rawMetadata['call_index'][lookup] = {
          'module': {'name': pallet['name']},
          'call': call,
        };
      }

      //
      // event lookup filling
      rawMetadata['event_index'] = <String, dynamic>{};
      for (var eventIndex = 0; eventIndex < events.length; eventIndex++) {
        final event = events[eventIndex];
        final lookup = ((pallet['index'] + eventIndex) as int)
            .toRadixString(16)
            .padLeft(4, '0');
        rawMetadata['event_index'][lookup] = {
          'module': {'name': pallet['name']},
          'call': event,
        };
      }

      //
      // constants lookup filling
      for (var index = 0; index < pallet['constants'].length; index++) {
        final item = pallet['constants'][index];
        rawMetadata['pallets'][palletIndex]['constants'][index]['type_string'] =
            siTypes[item['type']];
      }

      //
      // error lookup filling
      final errors = <Map<String, dynamic>>[];
      if (pallet['errors'] != null) {
        final variants =
            rawMetadata['lookup']['types'][pallet['errors']['type']];
        for (final variant in variants['type']['def']['Variant']['variants']) {
          errors.add({
            'name': variant['name'],
            'docs': variant['docs'],
          });
        }
      }
      rawMetadata['pallets'][palletIndex]['errors_value'] = errors;
    }

    final registry = RegistryCreator.instance[14];

    //
    // Register the Call type
    registry.addCodec('Call', Call(registry: registry, metadata: rawMetadata));
    registry.registerCustomCodec(metadataExpander.customCodecRegister);

    return ChainInfo(scaleCodec: ScaleCodec(registry));
  }
}
