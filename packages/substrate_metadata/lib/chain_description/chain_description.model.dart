import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/storage/storage_item.model.dart';

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
}

class Constant {
  final int type;
  final Uint8List value;
  final List<String> docs;
  const Constant({required this.type, required this.value, required this.docs});
}
