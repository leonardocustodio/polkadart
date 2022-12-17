# substrate_metadata

[substrate_metadata](https://www.pub.dev/packages/substrate_metadata) is a flutter and dart library for encoding and decoding chain **metadata**, **constants**, **extrinsics** and **events** of blocks.

# Lets Get Started

### Decode Metadata

```dart
  // create MetadataDecoder instance
  final decoderInstance = MetadataDecoder();

  // decode metadata
  final Metadata decodedMetadata = decoderInstance.decodeAsMetadata('0x6d657.....790b807d0b');

  //
  // or
  // get raw Map<String, dynamic>
  final Map<String, dynamic> metadataMap = decoderInstance.decode('0x6d657.....790b807d0b');
```

### Create ChainDescription from Metadata

```dart
  // create MetadataDecoder instance
  final MetadataDecoder decoderInstance = MetadataDecoder();

  // decode metadata
  final Metadata decodedMetadata = decoderInstance.decodeAsMetadata('0x6d657.....790b807d0b');

  // create ChainDescription from metadata
  final ChainDescription chainDescription = ChainDescription.fromMetadata(decodedMetadata);
```

### Decode Extrinsic

```dart
  // create MetadataDecoder instance
  final MetadataDecoder metadataDecoder = MetadataDecoder();

  final String metadataV14 = '0x6d657.....790b807d0b';

  // decode metadata
  final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

  // create ChainDescription from metadata
  final ChainDescription chainDescription = ChainDescription.fromMetadata(metadata);

  final String extrinsic = '0x990403......a2f9e184';

  // decode extrinsic
  final dynamic decodedExtrinsics = Extrinsic.decodeExtrinsic(extrinsic, chainDescription);
```

### Encode Extrinsic

```dart
  // create MetadataDecoder instance
  final MetadataDecoder metadataDecoder = MetadataDecoder();

  final String metadataV14 = '0x6d657.....790b807d0b';

  // decode metadata
  final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

  // create ChainDescription from metadata
  final ChainDescription chainDescription = ChainDescription.fromMetadata(metadata);

  final Map<String, dynamic> extrinsicsMap = {'version': 4, 'signature': ....... };

  // encode extrinsic
  final dynamic encodedExtrinsics = Extrinsic.encodeExtrinsics(extrinsicsMap, chainDescription);
```

### Decode Events

```dart
  // create MetadataDecoder instance
  final MetadataDecoder metadataDecoder = MetadataDecoder();

  final String metadataV14 = '0x6d657.....790b807d0b';

  // decode metadata
  final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

  // create ChainDescription from metadata
  final ChainDescription chainDescription = ChainDescription.fromMetadata(metadata);

  final String encodedEventsHex = '0x38000dd14c4572......................5ec6e6fcd6184d952d000000';

  final Codec codec = Codec(chainDescription.types);

  // codec.encode(type_index, value_to_decode);
  final dynamic decodedEvents = codec.decode(chainDescription.eventRecordList, encodedEventsHex);
```

### Encode Events

```dart
  // create MetadataDecoder instance
  final MetadataDecoder metadataDecoder = MetadataDecoder();

  final String metadataV14 = '0x6d657.....790b807d0b';

  // decode metadata
  final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

  // create ChainDescription from metadata
  final ChainDescription chainDescription = ChainDescription.fromMetadata(metadata);

  final Map<String, dynamic> events = [{ 'phase': {'ApplyExtrinsic': 0}, 'event': {....} }];

  final Codec codec = Codec(chainDescription.types);

  // codec.encode(type_index, value_to_encode);
  final String eventsHex = codec.encode(chainDescription.eventRecordList, events);
```

### Decode Constants

```dart
  // create MetadataDecoder instance
  final MetadataDecoder metadataDecoder = MetadataDecoder();

  final String metadataV14 = '0x6d657.....790b807d0b';

  // decode metadata
  final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

  // create ChainDescription from metadata
  final ChainDescription chainDescription = ChainDescription.fromMetadata(metadata);

  //
  // Look on constants of chain description
  for (String palletName in chainDescription.constants.keys) {
    final pallet = chainDescription.constants[palletName]!;

    //
    // Loop throught all the constants in this given pallet
    for (Constant originalConstant in pallet.values) {
      //
      // Original constant value
      final Uint8List originalConstantValue = originalConstant.value;

      final Codec codec = Codec(chainDescription.types);
      //
      // Decoded Constant value
      final dynamic decodedConstant = codec.decode(originalConstant.type, originalConstantValue);
    }
  }
```

### Encode Constants

```dart
  // create MetadataDecoder instance
  final MetadataDecoder metadataDecoder = MetadataDecoder();

  final String metadataV14 = '0x6d657.....790b807d0b';

  // decode metadata
  final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

  // create ChainDescription from metadata
  final ChainDescription chainDescription = ChainDescription.fromMetadata(metadata);

  //
  // encoded constant value
  final bytesSink = ByteEncoder();

  final Codec codec = Codec(chainDescription.types);

  final constantValue = [1, 42, 55, ......];

  //
  // Use the codec to encode the constant
  codec.encodeWithEncoder(type_from_decoded_constant, constantValue, bytesSink);
  
  final encodedConstant = bytesSink.toBytes();
```

### Add SpecVersion

```dart
  final specJson = {'specName': 'polkadot', 'specVersion':......};

  final specVersion = SpecVersion.fromJson(specJson);

  // specVersion gets added to support decoding the blocks.
  chainObject.addSpecVersion(specVersion);
```

### Create Chain Description from SpecVersion

```dart
  // when using preV14 metadata
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  final Chain chain = Chain(chainDefinitions);

  // or

  // when using V14 metadata, you don't need to provide chainDefinitions
  final Chain chain = Chain();

  final specJson = {'specName': 'polkadot', 'specVersion':......};

  final SpecVersion specVersion = SpecVersion.fromJson(specJson);

  final ChainDescription chainDescription = chain.getChainDescriptionFromSpecVersion(specVersion);
```

### Decode Constants (With Chain)

```dart
  // when using preV14 metadata
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  final Chain chain = Chain(chainDefinitions);

  // or

  // when using V14 metadata, you don't need to provide chainDefinitions
  final Chain chain = Chain();

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final ChainDescription chainDescription = chain.getChainDescriptionFromSpecVersion()

  // Map<String, Map<String, dynamic>> containing mapped pallets and names
  final constants = chain.decodeConstants(chainDescription);
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
