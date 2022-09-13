import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'scale_codec_key_utils.dart';
import 'type_helper.dart';
import 'type_helpers/config_types.dart';
import 'unsupported_type_error.dart';
import 'utils.dart';

abstract class HelperCore {
  final ClassElement element;
  final ClassConfig config;

  HelperCore(this.element, this.config);

  Iterable<TypeHelper> get allTypeHelpers;

  void addMember(String memberContent);

  @protected
  String get targetClassReference =>
      '${element.name}${genericClassArgumentsImpl(false)}';

  @protected
  String get prefix => '_\$${element.name.nonPrivate}';

  /// Returns a [String] representing the type arguments that exist on
  /// [element].
  ///
  /// Returns the output of calling [genericClassArguments] with [element].
  @protected
  String genericClassArgumentsImpl(bool withConstraints) =>
      genericClassArguments(element, withConstraints);

  @protected
  KeyConfig scaleCodecKeyFor(FieldElement field) =>
      scaleCodecKeyForField(field, config);
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

/// Returns a [String] representing the type arguments that exist on
/// [element].
///
/// If [withConstraints] is `null` or if [element] has no type arguments, an
/// empty [String] is returned.
///
/// If [withConstraints] is true, any type constraints that exist on [element]
/// are included.
///
/// For example, for class `class Sample<T as num, S>{...}`
///
/// For [withConstraints] = `false`:
///
/// ```
/// "<T, S>"
/// ```
///
/// For [withConstraints] = `true`:
///
/// ```
/// "<T as num, S>"
/// ```
String genericClassArguments(ClassElement element, bool? withConstraints) {
  if (withConstraints == null || element.typeParameters.isEmpty) {
    return '';
  }
  final values = element.typeParameters.map((t) {
    if (withConstraints && t.bound != null) {
      final boundCode = typeToCode(t.bound!);
      return '${t.name} extends $boundCode';
    } else {
      return t.name;
    }
  }).join(', ');
  return '<$values>';
}
