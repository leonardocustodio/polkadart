# substrate_metadata

[substrate_metadata](https://www.pub.dev/packages/substrate_metadata) is a flutter and dart library for encoding and decoding chain **metadata**, **constants**, **extrinsics** and **events** of blocks.

# Lets Get Started

### Decode Metadata

```dart
  // create MetadataDecoder instance
  final decoderInstance = MetadataDecoder.instance;

  // decode metadata
  final Metadata decodedMetadata = decoderInstance.decodeAsMetadata('0x090820....');

  //
  // or
  // get raw Map<String, dynamic>
  final Map<String, dynamic> metadataMap = decoderInstance.decode('0x090820....');
```

### Decode Extrinsic

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  final chain = Chain(chainDefinitions);

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final RawBlock rawBlock = RawBlock.fromJson( { blockJson } );

  // DecodedBlockExtrinsics
  final DecodedBlockExtrinsics decodedExtrinsic = chain.decodeExtrinsics(rawBlock);
```

### Encode Extrinsic

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  final chain = Chain(chainDefinitions);

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final RawBlock rawBlock = RawBlock.fromJson( { blockJson } );

  // DecodedBlockExtrinsics
  final DecodedBlockExtrinsics decodedExtrinsic = chain.decodeExtrinsics(rawBlock);

  // encodedRawBlock.hashCode == rawBlock
  final RawBlock encodedRawBlock = chain.encodeExtrinsic(decodedExtrinsic);
```

### Add SpecVersion

```dart
  final specJson = {'specName': 'polkadot', 'specVersion':......};

  final specVersion = SpecVersion.fromJson(specJson);

  // specVersion gets added to support decoding the blocks.
  chainObject.addSpecVersion(specVersion);
```

### Decode Events

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  final chain = Chain(chainDefinitions);

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final RawBlockEvents rawBlockEvents = RawBlockEvents.fromJson( { blockJson } );

  // DecodedBlockEvents
  final DecodedBlockEvents decodedEvents = chain.decodeEvents(rawBlockEvents);
```

### Encode Events

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  final chain = Chain(chainDefinitions);

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final rawBlockEvents = RawBlockEvents.fromJson( { blockJson } );

  // DecodedBlockEvents
  final DecodedBlockEvents decodedEvents = chain.decodeEvents(rawBlockEvents);

  // encodedBlockEvents.hashCode == rawBlockEvents.hashCode
  final RawBlockEvents encodedBlockEvents = chain.encodeEvents(decodedEvents);
```

### Create Chain Description from SpecVersion

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  // create chain object
  final chain = Chain(chainDefinitions);

  final specJson = {'specName': 'polkadot', 'specVersion':......};

  final SpecVersion specVersion = SpecVersion.fromJson(specJson);

  final ChainDescription chainDescription = chainObject.getChainDescriptionFromSpecVersion(specVersion);
```

### Decode Constants

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  final chain = Chain(chainDefinitions);

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final ChainDescription chainDescription = chain.getChainDescriptionFromSpecVersion()

  // Map<String, Map<String, dynamic>> containing mapped pallets and names
  final constants = chain.decodeConstants(chainDescription);
```

## Resources

- [substrate.dev](https://substrate.dev/docs/en/knowledgebase/advanced/codec)
- [Parity-scale-codec](https://github.com/paritytech/parity-scale-codec)
- [Polkadot.js](http://polkadot.js.org/)
- [Squid](https://github.com/subsquid/squid)
