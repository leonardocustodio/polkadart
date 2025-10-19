import 'dart:io';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/metadata/merkleize.dart';
import 'package:substrate_metadata/metadata/metadata.dart';
import 'package:test/test.dart';
import 'snapshot.dart';

void main() {
  late final RuntimeMetadata runtimeMetadata;
  late final MetadataMerkleizer merkleizedMetadata;

  setUpAll(() {
    final ksmData = './test/metadata/ksm.bin';
    final ksmMetadata = File(ksmData).readAsBytesSync();
    runtimeMetadata = RuntimeMetadataPrefixed.fromBytes(ksmMetadata).metadata;
    merkleizedMetadata = MetadataMerkleizer.fromMetadata(
      runtimeMetadata,
      decimals: 12,
      tokenSymbol: 'KSM',
    );
  });

  group('Metadata merkleize tests:', () {
    test('digests', () {
      final digest = merkleizedMetadata.digest();

      expect(digest, MerkleizeMetadataSnapshots.digests);
    });

    test('generates proofs for extrinsics', () {
      final data = merkleizedMetadata.getProofForExtrinsic(
        decodeHex(
            'c10184008eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a4801127d333c8f60c0d81dd0a6e2e20ea477a06f96aaca1811872c54c244f0935c60b1f8a38aabef3d3a4ef4050d8d078e35b57b3cf4f9545f8145ce98afb8755384550000000000001448656c6c6f'), // Hex for the transaction bytes
        decodeHex(
            '386d0f001a000000143c3561eefac7bc66facd4f0a7ec31d33b64f1827932fb3fda0ce361def535f143c3561eefac7bc66facd4f0a7ec31d33b64f1827932fb3fda0ce361def535f00'),
      );

      expect(data, MerkleizeMetadataSnapshots.extrinsicProof);
    });

    test('generates proofs for extrinsics parts', () {
      final data = merkleizedMetadata.getProofForExtrinsicParts(
        decodeHex(
            '040300648ad065ea416ca1725c29979cd41e288180f3e8aefde705cd3e0bab6cd212010bcb04fb711f01'),
        decodeHex('2503000000'),
        decodeHex(
            '164a0f001a000000b0a8d493285c2df73290dfb7e61f870f17b41801197a149ca93654499ea3dafe878a023bcb37967b6ba0685d002bb74e6cf3b4fc4ae37eb85f756bd9b026bede00'),
      );

      expect(data, MerkleizeMetadataSnapshots.extrinsicParts);
    });

    test('generates proofs for extrinsic payload', () {
      final data = merkleizedMetadata.getProofForExtrinsicPayload(decodeHex(
          '040300648ad065ea416ca1725c29979cd41e288180f3e8aefde705cd3e0bab6cd212010bcb04fb711f012503000000164a0f001a000000b0a8d493285c2df73290dfb7e61f870f17b41801197a149ca93654499ea3dafe878a023bcb37967b6ba0685d002bb74e6cf3b4fc4ae37eb85f756bd9b026bede00'));

      expect(data, MerkleizeMetadataSnapshots.extrinsicPayload);
    });

    test('fails to create with wrong extra info', () {
      expect(
          () => MetadataMerkleizer.fromMetadata(
                runtimeMetadata,
                decimals: 12,
                tokenSymbol: 'KSM',
                base58Prefix: 1,
              ),
          throwsException);
    });
  });
}
