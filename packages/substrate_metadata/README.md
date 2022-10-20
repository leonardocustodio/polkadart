# substrate_metadata

[substrate_metadata](https://www.pub.dev/packages/substrate_metadata) is a flutter and dart library for encoding and decoding chain **metadata**, **constants**, **extrinsic** and **events** of blocks.

# Lets Get Started

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  substrate_metadata: 0.0.2
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```css
dart pub get
```

with `Flutter`:

```css
flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use:

```dart
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
```

# Usage

### Decode Metadata

```dart
  // create MetadataDecoder signleton instance
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

  final rawBlock = RawBlock.fromJson( { blockJson } );

  // DecodedBlockExtrinsics
  final decodedExtrinsic = chain.decodeExtrinsics(rawBlock);
```

### Encode Extrinsic

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  final chain = Chain(chainDefinitions);

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final rawBlock = RawBlock.fromJson( { blockJson } );

  // DecodedBlockExtrinsics
  final decodedExtrinsic = chain.decodeExtrinsics(rawBlock);

  // encodedRawBlock.hashCode == rawBlock
  final encodedRawBlock = chain.encodeExtrinsic(decodedExtrinsic);
```

### Decode Events

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  final chain = Chain(chainDefinitions);

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final rawBlockEvents = RawBlockEvents.fromJson( { blockJson } );

  // DecodedBlockEvents
  final decodedEvents = chain.decodeEvents(rawBlockEvents);
```

### Encode Events

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  final chain = Chain(chainDefinitions);

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final rawBlockEvents = RawBlockEvents.fromJson( { blockJson } );

  // DecodedBlockEvents
  final decodedEvents = chain.decodeEvents(rawBlockEvents);

  // encodedBlockEvents.hashCode == rawBlockEvents.hashCode
  final encodedBlockEvents = chain.encodeEvents(decodedEvents);
```

### Create Chain Description from SpecVersion

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  // create chain object
  final chain = Chain(chainDefinitions);

  final specJson = {'specName': 'polkadot', 'specVersion':......};

  final specVersion = SpecVersion.fromJson(specJson);

  final chainDescription = chainObject.getChainDescriptionFromSpecVersion(specVersion);
```

### Decode Constants

```dart
  final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);

  final chain = Chain(chainDefinitions);

  // Preferred to provide all the available Spec-Version information.
  chain.initSpecVersionFromFile('../chain/versions.json');

  final chainDescription = chain.getChainDescriptionFromSpecVersion()

  // Map<String, Map<String, dynamic>> containing mapped pallets and names
  final constants = chain.decodeConstants(chainDescription);
```
