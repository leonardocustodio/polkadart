# substrate_metadata

[substrate_metadata](https://www.pub.dev/packages/substrate_metadata) is a flutter and dart library for encoding and decoding chain **metadata**, **constants**, **extrinsics** and **events** of blocks.

# Lets Get Started

### Decode Metadata

```dart
  // decoded metadata
  final DecodedMetadata decodedMetadata = MetadataDecoder.instance.decode('0x6d657.....790b807d0b');

  //
  // get raw Map<String, dynamic>
  final rawMetadata = decodedMetadata.metadataJson;
  
  //
  // get Metadata Object
  final metadataObject = decodedMetadata.metadataObject;
```

### Create ChainInfo from Metadata

```dart
  // decoded metadata
  final DecodedMetadata decodedMetadata = MetadataDecoder.instance.decode('0x6d657.....790b807d0b');

  // create ChainInfo from metadata
  final ChainInfo chainInfo = ChainInfo.fromMetadata(decodedMetadata);
```

### Decode Extrinsic

```dart
  // decode metadata
  final DecodedMetadata decodedMetadata = MetadataDecoder.instance.decode('0x6d657.....790b807d0b');

  // create ChainInfo from metadata
  final ChainInfo chainInfo = ChainInfo.fromMetadata(decodedMetadata);

  final String extrinsicHex = '0x990403......a2f9e184';
  
  // Create extrinsics input
  final input = Input.fromHex(extrinsicHex);

  // decode extrinsic
  final dynamic decoded = ExtrinsicsCodec(chainInfo: chainInfo).decode(input);
```

### Encode Extrinsic

```dart
  // decode metadata
  final DecodedMetadata decodedMetadata = MetadataDecoder.instance.decode('0x6d657.....790b807d0b');

  // create ChainInfo from metadata
  final ChainInfo chainInfo = ChainInfo.fromMetadata(decodedMetadata);
  
  // Create Output
  final output = HexOutput();

  final Map<String, dynamic> extrinsicsMap = {'version': 4, 'signature': ....... };

  // encode extrinsic
  ExtrinsicsCodec(chainInfo: chainInfo).encodeTo(extrinsicsMap, output);
  
  // encoded extrinsics Hex
  final extrinsicsHex = output.toString();
```

### Decode Events

```dart
  // decode metadata
  final DecodedMetadata decodedMetadata = MetadataDecoder.instance.decode('0x6d657.....790b807d0b');

  // create ChainInfo from metadata
  final ChainInfo chainInfo = ChainInfo.fromMetadata(decodedMetadata);

  final String encodedEventsHex = '0x38000dd14c4572......................5ec6e6fcd6184d952d000000';
  
  final input = Input.fromHex(encodedEventsHex);

  // list of decoded events
  final List<dynamic> decodedEvents = chainInfo.scaleCodec.decode('EventCodec', input);
```

### Encode Events

```dart
  // decode metadata
  final DecodedMetadata decodedMetadata = MetadataDecoder.instance.decode('0x6d657.....790b807d0b');

  // create ChainInfo from metadata
  final ChainInfo chainInfo = ChainInfo.fromMetadata(decodedMetadata);

  final Map<String, dynamic> events = [{ 'phase': {'ApplyExtrinsic': 0}, 'event': {....} }];

  final output = HexOutput();
  
  // encode the events
  chainInfo.scaleCodec.encodeTo('EventCodec', events, output);
  
  // events hex
  final eventsHex = output.toString();
```

### Decode Constants

```dart
  // decode metadata
  final DecodedMetadata decodedMetadata = MetadataDecoder.instance.decode('0x6d657.....790b807d0b');

  // create ChainInfo from metadata
  final ChainInfo chainInfo = ChainInfo.fromMetadata(decodedMetadata);

  //
  // Look on constants of chain description
  for (final palletMapEntry in chainInfo.constants.entries) {

    //
    // Loop throught all the constants in this given pallet
    for (final constantMapEntry in palletMapEntry.value.entries) {
      final Constant originalConstant = constantMapEntry.value;
      
      //
      // Encoded Constant bytes
      final encodedBytes = originalConstant.bytes;
      
      //
      // Decoded Constant value
      final decoded = originalConstant.value;
    }
  }
```

### Encode Constants

```dart
  // decode metadata
  final DecodedMetadata decodedMetadata = MetadataDecoder.instance.decode('0x6d657.....790b807d0b');

  // create ChainInfo from metadata
  final ChainInfo chainInfo = ChainInfo.fromMetadata(decodedMetadata);

  final output = ByteOutput();

  final decodedConstantValue = /** Some constant value from originalConstant **/;

  originalConstant.type.encodeTo(decodedConstantValue, output);
  
  final encodedConstant = output.toBytes();
```

### Add SpecVersion

```dart
  final specJson = {'specName': 'polkadot', 'specVersion':......};

  final specVersion = SpecVersion.fromJson(specJson);

  // specVersion gets added to support decoding the blocks.
  chainObject.addSpecVersion(specVersion);
```

### Create ChainInfo from SpecVersion

```dart
  // when using preV14 metadata
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  final Chain chain = Chain(chainDefinitions);

  // or

  // when using V14 metadata, you don't need to provide chainDefinitions
  final Chain chain = Chain();

  final specJson = {'specName': 'polkadot', 'specVersion':......};

  final SpecVersion specVersion = SpecVersion.fromJson(specJson);

  final ChainInfo chainInfo = chain.getChainInfoFromSpecVersion(specVersion);
```

### Decode Extrinsic (With Chain)

```dart
  // when using preV14 metadata
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  final Chain chain = Chain(chainDefinitions);

  // or

  // when using V14 metadata, you don't need to provide chainDefinitions
  final Chain chain = Chain();

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final RawBlock rawBlock = RawBlock.fromJson( { blockJson } );

  // DecodedBlockExtrinsics
  final DecodedBlockExtrinsics decodedExtrinsic = chain.decodeExtrinsics(rawBlock);
```

### Encode Extrinsic (With Chain)

```dart
  // when using preV14 metadata
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  final Chain chain = Chain(chainDefinitions);

  // or

  // when using V14 metadata, you don't need to provide chainDefinitions
  final Chain chain = Chain();

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final RawBlock rawBlock = RawBlock.fromJson( { blockJson } );

  // DecodedBlockExtrinsics
  final DecodedBlockExtrinsics decodedExtrinsic = chain.decodeExtrinsics(rawBlock);

  // encodedRawBlock.hashCode == rawBlock
  final RawBlock encodedRawBlock = chain.encodeExtrinsic(decodedExtrinsic);
```

### Decode Events (With Chain)

```dart
  // when using preV14 metadata
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  final Chain chain = Chain(chainDefinitions);

  // or

  // when using V14 metadata, you don't need to provide chainDefinitions
  final Chain chain = Chain();

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final RawBlockEvents rawBlockEvents = RawBlockEvents.fromJson( { blockJson } );

  // DecodedBlockEvents
  final DecodedBlockEvents decodedEvents = chain.decodeEvents(rawBlockEvents);
```

### Encode Events (With Chain)

```dart
  // when using preV14 metadata
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  final Chain chain = Chain(chainDefinitions);

  // or

  // when using V14 metadata, you don't need to provide chainDefinitions
  final Chain chain = Chain();

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final rawBlockEvents = RawBlockEvents.fromJson( { blockJson } );

  // DecodedBlockEvents
  final DecodedBlockEvents decodedEvents = chain.decodeEvents(rawBlockEvents);

  // encodedBlockEvents.hashCode == rawBlockEvents.hashCode
  final RawBlockEvents encodedBlockEvents = chain.encodeEvents(decodedEvents);
```

## Resources

- [substrate.dev](https://substrate.dev/docs/en/knowledgebase/advanced/codec)
- [Parity-scale-codec](https://github.com/paritytech/parity-scale-codec)
- [Polkadot.js](http://polkadot.js.org/)
- [Squid](https://github.com/subsquid/squid)
