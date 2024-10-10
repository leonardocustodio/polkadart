library substrate_metadata;

export 'core/metadata_decoder.dart';
export 'metadata/metadata.dart';

// import 'dart:convert';
// import 'dart:typed_data' show Uint8List;

// import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
//     show Codec, U32Codec, U8Codec, Input, Output;

// abstract class RuntimeMetadata {
//   int runtimeMetadataVersion();
//   Map<String, dynamic> toJson();
// }

// class RuntimeMetadataPrefixed {
//   final int magicNumber;
//   final RuntimeMetadata metadata;

//   static const RuntimeMetadataPrefixedCodec codec = RuntimeMetadataPrefixedCodec();

//   RuntimeMetadataPrefixed({required this.magicNumber, required this.metadata});

//   // factory RuntimeMetadataPrefixed.fromHex(String hex) {
//   //   final decodedMetadata = MetadataDecoder.instance.decode(hex);
//   //   return RuntimeMetadataPrefixed(
//   //     version: decodedMetadata.version,
//   //     metadata: decodedMetadata.metadata,
//   //   );
//   // }

//   Map<String, dynamic> toJson() => {
//         'magicNumber': magicNumber,
//         'metadata': metadata.toJson(),
//       };
// }

// /// Current prefix of metadata
// const META_RESERVED = 0x6174656d; // 'meta' warn endianness

// class RuntimeMetadataPrefixedCodec implements Codec<RuntimeMetadataPrefixed> {
//   const RuntimeMetadataPrefixedCodec();

//   @override
//   decode(Input input) {
//     final metaReserved = U32Codec.codec.decode(input);
//     final version = U8Codec.codec.decode(input);

//     switch (version) {
//       case 14:
//         return RuntimeMetadataPrefixed(
//           version: version,
//           metadata: MetadataV12Codec.codec.decode(input),
//         );
//       default:
//         throw Exception('Unsupported metadata version: $version');
//     }
//   }

//   @override
//   Uint8List encode(RuntimeMetadataPrefixed metadata) {
//     final output = Output.byteOutput();
//     U32Codec.codec.encodeTo(META_RESERVED, output);
//     U8Codec.codec.encodeTo(metadata.metadata.runtimeMetadataVersion(), output);
//     return output.toBytes();
//   }

//   @override
//   void encodeTo(RuntimeMetadataPrefixed metadata, Output output) {
//     U32Codec.codec.encodeTo(META_RESERVED, output);
//     U8Codec.codec.encodeTo(metadata.metadata.runtimeMetadataVersion(), output);
//   }

//   @override
//   int sizeHint(RuntimeMetadataPrefixed value) {
//     return 40;
//   }
// }
