import 'dart:typed_data';
import 'package:substrate_metadata/exceptions/exceptions.dart';
import 'package:substrate_metadata/storage/storage_item.model.dart';
import 'package:substrate_metadata/chain_description/parse_legacy.dart';
import 'package:substrate_metadata/chain_description/parse_v14.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/old/legacy_types_model.dart';
import 'package:substrate_metadata/utils/utils.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;

class ChainDescription {
  final List<scale_codec.Type> types;
  final int call;
  final int digest;
  final int digestItem;
  final int event;
  final int eventRecord;
  final int eventRecordList;
  final int signature;
  final Map<String, Map<String, StorageItem>> storage;
  final Map<String, Map<String, Constant>> constants;

  const ChainDescription({
    required this.types,
    required this.call,
    required this.digest,
    required this.digestItem,
    required this.event,
    required this.eventRecord,
    required this.eventRecordList,
    required this.signature,
    required this.storage,
    required this.constants,
  });

  static ChainDescription fromMetadata(Metadata metadata,
      [LegacyTypes? legacyTypes]) {
    switch (isPreV14(metadata)) {
      case true:
        assertionCheck(legacyTypes != null,
            'Type definitions are required for metadata ${metadata.kind}');
        return ParseLegacy(metadata, legacyTypes!).getChainDescription();
      case false:
        return ParseV14((metadata as Metadata_V14).value).getChainDescription();
      default:
        throw UnsupportedMetadataException(
            'Unsupported metadata version: ${metadata.kind}');
    }
  }

  static int _versionConverter(String version) {
    return int.parse(version.substring(1));
  }

  static bool isPreV14(Metadata metadata) {
    final String version = metadata.kind;
    final int versionNumber = _versionConverter(version);
    if (versionNumber < 14) {
      return true;
    }
    if (versionNumber == 14) {
      return false;
    }
    throw UnsupportedMetadataException(
        'Unsupported metadata version: ${metadata.kind}');
  }
}

class Constant {
  final int type;
  final Uint8List value;
  final List<String> docs;
  const Constant({required this.type, required this.value, required this.docs});
}
