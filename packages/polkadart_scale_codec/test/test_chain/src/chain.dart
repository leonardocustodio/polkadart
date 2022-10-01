// ignore_for_file: unused_element

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cached_annotation/cached_annotation.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/chainDescription.dart';
import 'package:substrate_metadata/codec.dart';
import 'package:substrate_metadata/events_and_calls.dart';
import 'package:substrate_metadata/extrinsic.dart';
import 'package:substrate_metadata/io.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/old/types_bundle.dart';
import 'package:substrate_metadata/schema/spec_version.model.dart';
import 'package:substrate_metadata/utils/common_utils.dart';
import 'package:substrate_metadata/utils/spec_version_maker.dart';
import 'package:test/test.dart';

part 'chain.cached.dart';

@WithCache()
abstract class Chain implements _$Chain {
  factory Chain(String chainName) = _Chain;

  String _item(String name) {
    return path.join('../../chain', chainName, name);
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
  List<RawBlock> getBlocks() {
    return _readLines('blocks.jsonl')
        .map((dynamic map) => RawBlock.fromMap(map))
        .toList();
  }

  @Cached()
  List<RawBlockEvents> events() {
    return _readLines('events.jsonl')
        .map((dynamic map) => RawBlockEvents(
            events: map['events'], blockNumber: map['blockNumber']))
        .toList();
  }

  @Cached()
  List<DecodedBlockExtrinsics> decodedExtrinsics() {
    var blocks = getBlocks();
    return blocks.map((b) {
      var d = getVersion(b.blockNumber);
      var extrinsics = b.extrinsics.map((hex) {
        return decodeExtrinsic(hex, d.description, d.codec);
      }).toList();
      return DecodedBlockExtrinsics(
          blockNumber: b.blockNumber, extrinsics: extrinsics);
    }).toList();
  }

  void testExtrinsicsScaleEncodingDecoding() {
    var decoded = decodedExtrinsics();

    var encoded = flatten(decoded.map((b) {
      var d = getVersion(b.blockNumber);
      var extrinsics = b.extrinsics.map((ex) {
        return scale_codec
            .encodeHex(encodeExtrinsic(ex, d.description, d.codec));
      }).toList();
      return RawBlock(blockNumber: b.blockNumber, extrinsics: extrinsics);
    }).map((b) {
      return b.extrinsics.asMap().entries.map((mapEntry) {
        return <String, dynamic>{
          'blockNumber': b.blockNumber,
          'idx': mapEntry.key,
          'extrinsic': mapEntry.value
        };
      }).toList();
    }).toList());

    var original = flatten(getBlocks().map((b) {
      return RawBlock(blockNumber: b.blockNumber, extrinsics: b.extrinsics);
    }).map((b) {
      return b.extrinsics.asMap().entries.map((mapEntry) {
        return <String, dynamic>{
          'blockNumber': b.blockNumber,
          'idx': mapEntry.key,
          'extrinsic': mapEntry.value
        };
      }).toList();
    }).toList());

    test('Extrinsics Encode/Decode', () {
      for (var i = 0; i < encoded.length; i++) {
        try {
          expect(encoded[i], equals(original[i]));
        } catch (e) {
          var b = original[i];
          var d = getVersion(b['blockNumber']);
          var fromEncoded =
              decodeExtrinsic(encoded[i]['extrinsic'], d.description, d.codec);
          var fromOriginal =
              decodeExtrinsic(b['extrinsic'], d.description, d.codec);
          expect(fromEncoded, equals(fromOriginal));
        }
      }
    });
  }

  void testConstantsScaleEncodingDecoding() {
    switch (chainName) {
      // fixme
      case 'heiko':
      case 'kintsugi':
        return;
    }
    for (final des in getDescription()) {
      test('Constants Encode/Decode  Spec-Version: ${des.specVersion}', () {
        for (final pallet in des.description.constants.keys) {
          for (var name in des.description.constants[pallet]!.keys) {
            var def = des.description.constants[pallet]![name];
            var value = des.codec.decodeBinary(def!.type, def.value);
            var encoded = des.codec.encodeToBinary(def.type, value);
            expect(encoded, equals(def.value));
          }
        }
      });
    }
  }

  List<Map<String, dynamic>> flatten(List<List<Map<String, dynamic>>> list) {
    var result = <Map<String, dynamic>>[];
    for (var value in list) {
      for (var val in value) {
        result.add(val);
      }
    }
    return result;
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
    test('Events: Encode/Decode', () {
      for (var i = 0; i < decoded.length; i++) {
        var b = decoded[i];
        var d = getVersion(b.blockNumber);
        var events =
            d.codec.encodeToHex(d.description.eventRecordList, b.events);
        var encoded =
            RawBlockEvents(blockNumber: b.blockNumber, events: events);
        expect(encoded, equals(original[i]));
      }
    });
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
    var description = getDescription();
    int next = -1;
    for (var index = 0; index < description.length; index++) {
      if (description[index].blockNumber >= blockNumber) {
        next = index;
        break;
      }
    }
    VersionDescription? e;
    if (description.isNotEmpty && next != 0 && next < description.length) {
      e = next < 0
          ? description[description.length - 1]
          : description[next - 1];
    }
    scale_codec.assertNotNull(e, 'not found metadata for block $blockNumber');
    return e!;
  }

  @Cached()
  List<VersionDescription> getDescription() {
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
