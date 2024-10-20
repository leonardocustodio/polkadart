library abi;

import 'package:abi/utils/string_extension.dart';
import 'package:polkadart_scale_codec/core/core.dart';
import 'package:polkadart_scale_codec/primitives/primitives.dart';
import 'package:substrate_metadata/parsers/parsers.dart';

typedef Bytes = String;

typedef SelectorsMap = Map<String, int>;

class AbiEvent {
  final String name;
  final Codec<dynamic> type;
  final int amountIndexed;
  final Bytes? signatureTopic;

  const AbiEvent({
    required this.name,
    required this.type,
    required this.amountIndexed,
    this.signatureTopic,
  });
}

class AbiDescription {
  final Map<String, dynamic> project;
  late final Registry registry = Registry();

  late final MetadataV14Expander expander;
  final Map<int, Codec> siTypesCodec = <int, Codec>{};
  late final Codec<dynamic> eventValue;
  late final Codec<dynamic> constructorsValue;
  late final Codec<dynamic> messagesValue;

  final List<AbiEvent> eventsValue = <AbiEvent>[];

  AbiDescription(this.project) {
    _parseTypes();
    eventsValue
      ..clear()
      ..addAll(_events());
    eventValue = _event();
    constructorsValue = _constructors();
    messagesValue = _messages();
    print('Events: $eventsValue');
  }

  void _parseTypes() {
    {
      final List<dynamic> types = project['types'];
      for (int i = 0; i < types.length; i++) {
        final String label = types[i]['type']['def'].keys.first;
        types[i]['type']['def'] = <String, dynamic>{
          label.capitalize(): types[i]['type']['def'][label]
        };
      }
      for (int i = 0; i < types.length; i++) {
        if (types[i]['type'].containsKey('path') &&
            types[i]['type']['path'] is List) {
          if (!['Option', 'Result'].contains(types[i]['type']['path'][0])) {
            final List<dynamic> path = types[i]['type']['path'];
            // TODO: Check if namespace is important or not.
            //path.insert(0, namespace);
            types[i]['type']['path'] = path;
          }
        } else {
          types[i]['type']['path'] = <String>[];
        }
        if (types[i]['type']['def'].containsKey('Variant')) {
          if (types[i]['type']['def']['Variant'].containsKey('variants')) {
            final List<dynamic> variants =
                types[i]['type']['def']['Variant']['variants'];
            for (int j = 0; j < variants.length; j++) {
              variants[j]['fields'] = <dynamic>[];
            }
            types[i]['type']['def']['Variant']['variants'] = variants;
          }
        }
      }
      project['types'] = types;
    }

    expander = MetadataV14Expander(project['types']);
    registry.registerCustomCodec(expander.customCodecRegister);

    for (int index = 0; index < project['types'].length; index++) {
      String? typeName = expander.registeredSiType[index];
      if (typeName == null) {
        throw Exception('Types not found for index: $index');
      }

      Codec<dynamic>? codec = registry.getCodec(typeName);
      if (codec != null) {
        siTypesCodec[index] = codec;
        continue;
      }
      typeName = expander.customCodecRegister[typeName];
      if (typeName == null) {
        throw Exception('Types not found for index: $index');
      }
      codec = registry.getCodec(typeName);
      if (codec != null) {
        siTypesCodec[index] = codec;
        continue;
      }
    }
  }

  SelectorsMap messageSelectors() {
    final SelectorsMap map = <String, int>{};
    final List<dynamic> messages = project['spec']['messages'];
    for (int i = 0; i < messages.length; i++) {
      map[messages[i]['selector']] = i;
    }
    return map;
  }

  SelectorsMap constructorSelectors() {
    final SelectorsMap map = <String, int>{};
    final List<dynamic> constructors = project['spec']['constructors'];
    for (int i = 0; i < constructors.length; i++) {
      map[constructors[i]['selector']] = i;
    }
    return map;
  }

  List<AbiEvent> _events() {
    final List<AbiEvent> result = <AbiEvent>[];

    for (final eventValue in project['spec']['events']) {
      int amountIndexed = 0;
      for (final arg in eventValue['args']) {
        amountIndexed += arg['indexed'] ? 1 : 0;
      }
      result.add(AbiEvent(
        name: normalizeLabel(eventValue['label']),
        type: _createComposite(eventValue),
        amountIndexed: amountIndexed,
        signatureTopic: eventValue['signature_topic'],
      ));
    }
    return result;
  }

  Codec<dynamic> _messages() {
    return _createMessagesType(project['spec']['messages']);
  }

  Codec<dynamic> _constructors() {
    return _createMessagesType(project['spec']['constructors']);
  }

  Codec<dynamic> _event() {
    return _createMessagesType(project['spec']['events']);
  }

  Codec<dynamic> _createMessagesType(List<dynamic> list) {
    final Map<int, MapEntry<String, Codec<dynamic>>> variants =
        <int, MapEntry<String, Codec<dynamic>>>{};

    for (int index = 0; index < list.length; index++) {
      final Map<String, dynamic> variant = list[index];
      late final Codec<dynamic> codec;
      if (variant['args'].isEmpty) {
        // TODO: Check if much simpler approach can be followed here or not?
        codec = NullCodec.codec;
      } else {
        codec = _createComposite(variant);
      }
      variants[index] = MapEntry(normalizeLabel(variant['label']), codec);
    }
    return ComplexEnumCodec.sparse(variants);
  }

  Codec<dynamic> _createComposite(Map<String, dynamic> map) {
    final codecMap = <String, Codec<dynamic>>{};
    for (final Map<String, dynamic> arg in map['args']!) {
      codecMap[normalizeLabel(arg['label'])] =
          siTypesCodec[arg['type']!['type']!]!;
    }
    return CompositeCodec(codecMap);
  }

  String normalizeLabel(String label) {
    return label.replaceAll('::', '_');
  }
}
