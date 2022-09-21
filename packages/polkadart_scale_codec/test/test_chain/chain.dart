//ignore_for_file: unused_element

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cached_annotation/cached_annotation.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/chainDescription.dart';
import 'package:substrate_metadata/codec.dart';
import 'package:substrate_metadata/events_and_calls.dart';
import 'package:substrate_metadata/io.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/old/types_bundle.dart';
import 'package:substrate_metadata/schema/spec_version.model.dart';
import 'package:substrate_metadata/utils/lines.dart';
import 'package:substrate_metadata/utils/spec_version_maker.dart';
import 'package:test/test.dart';

part 'chain.cached.dart';

@WithCache()
abstract class Chain implements _$Chain {
  factory Chain(String name) = _Chain;

  String _item(String name) {
    return path.join('./test/chain', this.name, name);
  }

  @Cached()
  List<SpecVersion> versions() {
    return readSpecVersions(_item('versions.jsonl'));
  }

  @Cached()
  List<int> blockNumbers() {
    return _read<List<int>>('block-numbers.json');
  }

  T _read<T>(String name) {
    var content = _readFile(name);
    return jsonDecode(content) as T;
  }

  @Cached()
  List<RawBlockEvents> events() {
    return _readLines('events.jsonl')
        .map((dynamic map) => RawBlockEvents(
            events: map['events'], blockNumber: map['blockNumber']))
        .toList();
  }

  void testConstantsScaleEncodingDecoding() {
    switch (name) {
      // fixme
      case 'heiko':
      case 'kintsugi':
        return;
    }
    for (final des in description()) {
      for (final pallet in des.description.constants.keys) {
        test(
            ' Constants Encode/Decode  Spec-Version: ${des.specVersion}  Pallet: $pallet',
            () {
          for (var name in des.description.constants[pallet]!.keys) {
            var def = des.description.constants[pallet]![name];
            var value = des.codec.decodeBinary(def!.type, def.value);
            var encoded = des.codec.encodeToBinary(def.type, value);
            expect(encoded, equals(def.value));
          }
        });
      }
    }
  }

  List<dynamic> _readLines(String name) {
    if (!_exists(name)) {
      return <dynamic>[];
    }
    var out = <dynamic>[];
    for (var line in readLines(_item(name))) {
      out.add(jsonDecode(line));
    }
    return out;
  }

  void testEventsScaleEncodingDecoding() {
    var decoded = decodedEvents();
    var original = events();
    for (var i = 0; i < decoded.length; i++) {
      var b = decoded[i];
      test('Events: Encode/Decode: ${b.blockNumber}', () {
        var d = getVersion(b.blockNumber);
        var events =
            d.codec.encodeToHex(d.description.eventRecordList, b.events);
        var encoded =
            RawBlockEvents(blockNumber: b.blockNumber, events: events);
        expect(encoded, equals(original[i]));
      });
    }
  }

  @Cached()
  List<DecodedBlockEvents> decodedEvents() {
    var blocks = events();
    return blocks.map((b) {
      var d = getVersion(b.blockNumber);
      var events =
          d.codec.decodeBinary(d.description.eventRecordList, b.events);
      return DecodedBlockEvents(blockNumber: b.blockNumber, events: events);
    }).toList();
  }

  @Cached()
  VersionDescription getVersion(int blockNumber) {
    var description = this.description();
    int next = -1;
    for (var index = 0; index < description.length; index++) {
      if (description[index].blockNumber >= blockNumber) {
        next = index;
        break;
      }
    }
    VersionDescription? e;

    /// TODO: Confirm the condition of next != 0
    if (description.isNotEmpty && next != 0 && next < description.length) {
      e = next < 0
          ? description[description.length - 1]
          : description[next - 1];
    }
    scale_codec.assertNotNull(e,
        msg: 'not found metadata for block $blockNumber');
    return e!;
  }

  @Cached()
  List<VersionDescription> description() {
    return versions().map((SpecVersion sv) {
      var metadata = decodeMetadata(sv.metadata);
      var typesBundle = getOldTypesBundle(sv.specName);
      var types = typesBundle != null
          ? getTypesFromBundle(typesBundle, sv.specVersion)
          : null;
      var description = getChainDescriptionFromMetadata(metadata, types);

      return VersionDescription(
        /// local to class params
        description: description,
        codec: scale_codec.Codec(description.types),
        jsonCodec: scale_codec.JsonCodec(description.types),
        events: Registry(description.types, description.event),
        calls: Registry(description.types, description.call),

        /// passing params for super-class i.e. SpecVersion
        metadata: sv.metadata,
        specName: sv.specName,
        specVersion: sv.specVersion,
        blockNumber: sv.blockNumber,
        blockHash: sv.blockHash,
      );
    }).toList();
  }

  void _save(String filePath, dynamic content) {
    late String jsonString;
    if (content is String) {
      jsonString = content;
    } else {
      jsonString = JsonEncoder().convert(content);
    }
    File(_item(filePath))
      ..createSync()
      ..writeAsStringSync(jsonString);
  }

  void _append(String filePath, dynamic content) {
    late String jsonString;
    if (content is String) {
      jsonString = content;
    } else {
      jsonString = JsonEncoder().convert(content);
    }
    File(_item(filePath))
      ..createSync()
      ..writeAsStringSync('$jsonString\n', mode: FileMode.append);
  }

  bool _exists(String fileName) {
    return File(_item(fileName)).existsSync();
  }

  String _readFile(String fileName) {
    return File(_item(fileName)).readAsStringSync();
  }
}
