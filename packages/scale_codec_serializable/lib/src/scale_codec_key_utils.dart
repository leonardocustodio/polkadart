// import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
// import 'package:analyzer/dart/element/type.dart';
import 'package:scale_codec_serializable/src/utils.dart';
// import 'package:source_gen/source_gen.dart';

import 'type_helpers/config_types.dart';

final _scaleCodecKeyExpando = Expando<Map<ClassConfig, KeyConfig>>();

KeyConfig scaleCodecKeyForField(
        FieldElement field, ClassConfig classAnnotation) =>
    (_scaleCodecKeyExpando[field] ??= Map.identity())[classAnnotation] ??=
        _from(field, classAnnotation);

KeyConfig _from(FieldElement element, ClassConfig classAnnotation) {
  // If an annotation exists on `element` the source is a 'real' field.
  // If the result is `null`, check the getter – it is a property.
  final obj = scaleCodecKeyAnnotation(element);

  if (obj.isNull) {
    return _populateScaleCodecKey(
      classAnnotation,
      element,
    );
  }

  // /// Returns a literal value for [dartObject] if possible, otherwise throws
  // /// an [InvalidGenerationSourceError] using [typeInformation] to describe
  // /// the unsupported type.
  // Object? literalForObject(
  //   String fieldName,
  //   DartObject dartObject,
  //   Iterable<String> typeInformation,
  // ) {
  //   if (dartObject.isNull) {
  //     return null;
  //   }

  //   final reader = ConstantReader(dartObject);

  //   String? badType;
  //   if (reader.isSymbol) {
  //     badType = 'Symbol';
  //   } else if (reader.isType) {
  //     badType = 'Type';
  //   } else if (dartObject.type is FunctionType) {
  //     badType = 'Function';
  //   } else if (!reader.isLiteral) {
  //     badType = dartObject.type!.element2!.name;
  //   }

  //   if (badType != null) {
  //     badType = typeInformation.followedBy([badType]).join(' > ');
  //     throwUnsupported(
  //       element,
  //       '`$fieldName` is `$badType`, it must be a literal.',
  //     );
  //   }

  //   if (reader.isDouble || reader.isInt || reader.isString || reader.isBool) {
  //     return reader.literalValue;
  //   }

  //   if (reader.isList) {
  //     return [
  //       for (var e in reader.listValue)
  //         literalForObject(fieldName, e, [
  //           ...typeInformation,
  //           'List',
  //         ])
  //     ];
  //   }

  //   if (reader.isSet) {
  //     return {
  //       for (var e in reader.setValue)
  //         literalForObject(fieldName, e, [
  //           ...typeInformation,
  //           'Set',
  //         ])
  //     };
  //   }

  //   if (reader.isMap) {
  //     final mapTypeInformation = [
  //       ...typeInformation,
  //       'Map',
  //     ];
  //     return reader.mapValue.map(
  //       (k, v) => MapEntry(
  //         literalForObject(fieldName, k!, mapTypeInformation),
  //         literalForObject(fieldName, v!, mapTypeInformation),
  //       ),
  //     );
  //   }

  //   badType = typeInformation.followedBy(['$dartObject']).join(' > ');

  //   throwUnsupported(
  //     element,
  //     'The provided value is not supported: $badType. '
  //     'This may be an error in package:scale_codec_serializable. '
  //     'Please rerun your build with `--verbose` and file an issue.',
  //   );
  // }

  // /// Returns a literal object representing the value of [fieldName] in [obj].
  // ///
  // /// If [mustBeEnum] is `true`, throws an [InvalidGenerationSourceError] if
  // /// either the annotated field is not an `enum` or `List` or if the value in
  // /// [fieldName] is not an `enum` value.
  // String? createAnnotationValue(String fieldName, {bool mustBeEnum = false}) {
  //   final annotationValue = obj.read(fieldName);
  //   late final DartType annotationType;

  //   final enumFields = annotationValue.isNull
  //       ? null
  //       : iterateEnumFields(annotationType = annotationValue.objectValue.type!);
  //   if (enumFields != null) {
  //     if (mustBeEnum) {
  //       if (element.type is EnumElement) {
  //       } else if (coreIterableTypeChecker.isAssignableFromType(element.type)) {
  //       } else {
  //         throwUnsupported(
  //           element,
  //           '`$fieldName` can only be set on fields of type enum or on '
  //           'Iterable, List, or Set instances of an enum type.',
  //         );
  //       }
  //     }

  //     final enumValueNames =
  //         enumFields.map((p) => p.name).toList(growable: false);

  //     final enumValueName = enumValueForDartObject<String>(
  //         annotationValue.objectValue, enumValueNames, (n) => n);

  //     return '${annotationType.element2!.name}'
  //         '.$enumValueName';
  //   } else {
  //     final defaultValueLiteral = annotationValue.isNull
  //         ? null
  //         : literalForObject(fieldName, annotationValue.objectValue, []);
  //     if (defaultValueLiteral == null) {
  //       return null;
  //     }
  //     if (mustBeEnum) {
  //       throwUnsupported(
  //         element,
  //         'The value provided for `$fieldName` must be a matching enum.',
  //       );
  //     }
  //     return scaleCodecLiteralAsDart(defaultValueLiteral);
  //   }
  // }

  return _populateScaleCodecKey(
    classAnnotation,
    element,
    ignore: obj.read('ignore').literalValue as bool?,
  );
}

KeyConfig _populateScaleCodecKey(
  ClassConfig classAnnotation,
  FieldElement element, {
  bool? ignore,
}) {
  return KeyConfig(
    ignore: ignore ?? false,
  );
}
