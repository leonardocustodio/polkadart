import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:scale_codec_serializable/src/class_visitor.dart';
import 'package:scale_codec_serializable/src/decoder_helper.dart';
import 'package:scale_codec_serializable/src/encoder_helper.dart';
import 'package:scale_codec_serializable/src/helper_core.dart';
import 'package:scale_codec_serializable/src/type_helpers/config_types.dart';
import 'package:source_gen/source_gen.dart';

class GeneratorHelper extends HelperCore with EncoderHelper, DecodeHelper {
  final _addedMembers = <String>{};
  final ConstantReader annotation;

  GeneratorHelper(ClassElement element, ClassConfig config, this.annotation)
      : super(
          element,
          config,
        );

  @override
  void addMember(String memberContent) {
    _addedMembers.add(memberContent);
  }

  Iterable<String> generate() sync* {
    assert(_addedMembers.isEmpty);

    final visitor = ClassVisitor();
    element.visitChildren(visitor);

    final sortedFields = visitor.fields;

    // Used to keep track of why a field is ignored. Useful for providing
    // helpful errors when generating constructor calls that try to use one of
    // these fields.
    final unavailableReasons = <String, String>{};

    final accessibleFields = sortedFields.values
        .fold<Map<String, FieldElement>>(<String, FieldElement>{},
            (map, field) {
      if (field.getter == null) {
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

    yield 'extension _\$${targetClassReference}Extension on $targetClassReference {';

    yield createClassBody(accessibleFields);

    if (config.createDecodeMethod) {
      yield* createDecode(accessibleFields);
    }

    if (config.createEncodeMethod) {
      yield* createEncode(accessibleFields);
    }

    yield* _addedMembers;

    yield '}';
  }

  /// Write a copy of class body and all fields as example above:
  ///
  /// ```dart
  ///   //...
  ///   bool isTest = true;
  ///   String get isTestEncoded => "0x01";
  ///   //...
  /// ```
  String createClassBody(Map<String, FieldElement> fields) {
    final buffer = StringBuffer();

    for (var field in fields.keys) {
      final fieldName =
          field.startsWith('_') ? field.replaceFirst('_', '') : field;
      final dartType = fields[field]?.type;

      buffer.writeln(
          'String get ${fieldName}Encoded => "TODO: encode $dartType type";');
    }

    return buffer.toString();
  }
}
