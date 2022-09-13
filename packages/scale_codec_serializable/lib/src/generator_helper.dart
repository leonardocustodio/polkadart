import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:scale_codec_serializable/src/decoder_helper.dart';
import 'package:scale_codec_serializable/src/encoder_helper.dart';
import 'package:scale_codec_serializable/src/helper_core.dart';
import 'package:scale_codec_serializable/src/type_helper.dart';
import 'package:scale_codec_serializable/src/utils.dart';
import 'package:source_gen/source_gen.dart';

import 'field_helpers.dart';
import 'settings.dart';

class GeneratorHelper extends HelperCore with EncoderHelper, DecodeHelper {
  final Settings _generator;
  final _addedMembers = <String>{};

  GeneratorHelper(
    this._generator,
    ClassElement element,
    ConstantReader annotation,
  ) : super(
          element,
          mergeConfig(
            _generator.config,
            annotation,
            classElement: element,
          ),
        );

  @override
  void addMember(String memberContent) {
    _addedMembers.add(memberContent);
  }

  @override
  Iterable<TypeHelper> get allTypeHelpers => _generator.allHelpers;

  Iterable<String> generate() sync* {
    assert(_addedMembers.isEmpty);

    final sortedFields = createSortedFieldSet(element);

    // Used to keep track of why a field is ignored. Useful for providing
    // helpful errors when generating constructor calls that try to use one of
    // these fields.
    final unavailableReasons = <String, String>{};

    final accessibleFields = sortedFields.fold<Map<String, FieldElement>>(
        <String, FieldElement>{}, (map, field) {
      if (!field.isPublic) {
        unavailableReasons[field.name] = 'It is assigned to a private field.';
      } else if (field.getter == null) {
        assert(field.setter != null);
        unavailableReasons[field.name] =
            'Setter-only properties are not supported.';
        log.warning('Setters are ignored: ${element.name}.${field.name}');
      } else {
        assert(!map.containsKey(field.name));
        map[field.name] = field;
      }

      return map;
    });

    var accessibleFieldSet = accessibleFields.values.toSet();

    if (config.createDecodeMethod) {
      yield* createDecode(accessibleFieldSet);
    }

    if (config.createEncodeMethod) {
      yield* createEncode(accessibleFieldSet);
    }

    yield* _addedMembers;
  }
}
