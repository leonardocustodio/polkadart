import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'type_helpers/config_types.dart';

const _scaleCodecKeyChecker = TypeChecker.fromRuntime(ScaleCodecKey);

DartObject? _scaleCodecKeyAnnotation(FieldElement element) =>
    _scaleCodecKeyChecker.firstAnnotationOf(element) ??
    (element.getter == null
        ? null
        : _scaleCodecKeyChecker.firstAnnotationOf(element.getter!));

ConstantReader scaleCodecKeyAnnotation(FieldElement element) =>
    ConstantReader(_scaleCodecKeyAnnotation(element));

/// Returns `true` if [element] is annotated with [ScaleCodecKey].
bool hasJsonKeyAnnotation(FieldElement element) =>
    _scaleCodecKeyAnnotation(element) != null;

Never throwUnsupported(FieldElement element, String message) =>
    throw InvalidGenerationSourceError(
      'Error with `@JsonKey` on the `${element.name}` field. $message',
      element: element,
    );

/// Return the Dart code presentation for the given [type].
///
/// This function is intentionally limited, and does not support all possible
/// types and locations of these files in code. Specifically, it supports
/// only [InterfaceType]s, with optional type arguments that are also should
/// be [InterfaceType]s.
String typeToCode(
  DartType type, {
  bool forceNullable = false,
}) {
  if (type.isDynamic) {
    return 'dynamic';
  } else if (type is InterfaceType) {
    return [
      type.element2.name,
      if (type.typeArguments.isNotEmpty)
        '<${type.typeArguments.map(typeToCode).join(', ')}>',
      (type.isDartCoreNull || forceNullable) ? '?' : '',
    ].join();
  }

  if (type is TypeParameterType) {
    return type.getDisplayString(withNullability: false);
  }
  throw UnimplementedError('(${type.runtimeType}) $type');
}

/// If [targetType] is an enum, returns the [FieldElement] instances associated
/// with its values.
///
/// Otherwise, `null`.
Iterable<FieldElement>? iterateEnumFields(DartType targetType) {
  if (targetType is InterfaceType && targetType.element2 is EnumElement) {
    return targetType.element2.fields
        .where((element) => element.isEnumConstant);
  }
  return null;
}

T enumValueForDartObject<T>(
  DartObject source,
  List<T> items,
  String Function(T) name,
) =>
    items[source.getField('index')!.toIntValue()!];

/// Return an instance of [JsonSerializable] corresponding to a the provided
/// [reader].
// #CHANGE WHEN UPDATING json_annotation
ScaleCodecSerializable _valueForAnnotation(ConstantReader reader) =>
    ScaleCodecSerializable(
      createDecodeMethod:
          reader.read('createDecodeMethod').literalValue as bool?,
      createEncodeMethod:
          reader.read('createEncodeMethod').literalValue as bool?,
    );

/// Returns a [ClassConfig] with values from the [ScaleCodecSerializable]
/// instance represented by [reader].
///
/// For fields that are not defined in [ScaleCodecSerializable] or `null` in [reader],
/// use the values in [config].
ClassConfig mergeConfig(
  ClassConfig config,
  ConstantReader reader, {
  required ClassElement classElement,
}) {
  final annotation = _valueForAnnotation(reader);

  return ClassConfig(
      createDecodeMethod:
          annotation.createDecodeMethod ?? config.createDecodeMethod,
      createEncodeMethod:
          annotation.createEncodeMethod ?? config.createEncodeMethod);
}
