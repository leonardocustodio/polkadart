import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'class_visitor.dart';
import 'decoder_helper.dart';
import 'encoder_helper.dart';
import 'helper_core.dart';

class GeneratorHelper extends HelperCore with EncoderHelper, DecodeHelper {
  final _addedMembers = <String>{};
  final ConstantReader annotation;

  GeneratorHelper(super.element, super.config, this.annotation);

  @override
  void addMember(String memberContent) {
    _addedMembers.add(memberContent);
  }

  Iterable<String> generate() sync* {
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
        unavailableReasons[field.name] =
            'Setter-only properties are not supported.';
        log.warning('Setters are ignored: ${element.name}.${field.name}');
      } else {
        map[field.name] = field;
      }

      return map;
    });

    yield createClassBody(accessibleFields);

    if (config.shouldCreateDecodeMethod) {
      yield* createDecode(accessibleFields);
    }

    if (config.shouldCreateEncodeMethod) {
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
    final buffer = StringBuffer()
      ..write('extension _\$${targetClassReference}Extension')
      ..writeln(' on $targetClassReference {');

    for (var field in fields.keys) {
      final fieldName = field.replaceFirst('_', '');
      final dartType = fields[field]?.type;

      buffer.writeln(
          "String get ${fieldName}Encoded => 'TODO: encode $dartType type';");
    }
    return buffer.toString();
  }
}
