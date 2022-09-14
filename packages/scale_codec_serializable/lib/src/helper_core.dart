import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'type_helpers/config_types.dart';
import 'unsupported_type_error.dart';
import 'utils.dart';

abstract class HelperCore {
  final ClassElement element;
  final ClassConfig config;

  HelperCore(this.element, this.config);

  void addMember(String memberContent);

  @protected
  String get targetClassReference => element.name;

  @protected
  String get prefix => '_\$${element.name.nonPrivate}';
}

InvalidGenerationSourceError createInvalidGenerationError(
    String targetMember, FieldElement field, UnsupportedTypeError error) {
  var message = 'Could not generate `$targetMember` code for `${field.name}`';
  if (error.type is TypeParameterType) {
    message = '$message because of type '
        '`${error.type.getDisplayString(withNullability: false)}` '
        '(type parameter)';
  } else if (field.type != error.type) {
    message = '$message because of type `${typeToCode(error.type)}`';
  }

  return InvalidGenerationSourceError(
    [
      '$message.',
      if (error.reason != null) error.reason,
    ].join('\n'),
    element: field,
  );
}
