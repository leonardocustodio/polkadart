import 'package:cryptography/dart.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;
import '../utils/common_utils.dart';
import 'package:utility/utility.dart';
import 'dart:convert';
import 'metadata.model.dart';
import 'types.dart';

List<Type> normalizeMetadataTypes(List<Type> types) {
  types = fixWrapperKeepOpaqueTypes(types);
  types = introduceOptionType(types);
  types = removeUnitFieldsFromStructs(types);
  types = replaceUnitOptionWithBoolean(types);
  types = normalizeFieldNames(types);
  return types;
}

List<Type> fixWrapperKeepOpaqueTypes(List<Type> types) {
  var u8 = types.length;
  var replaced = false;
  types = types.map((Type type) {
    if (!isNotEmpty(type.path?.length)) {
      return type;
    }
    if (type.path!.last != 'WrapperKeepOpaque') {
      return type;
    }
    if (type.kind != scale.TypeKind.Composite) {
      return type;
    }
    if (type is CompositeType && type.fields.length != 2) {
      return type;
    }
    if (type is CompositeType &&
        types[type.fields[0].type].kind != scale.TypeKind.Compact) {
      return type;
    }
    replaced = true;
    return SequenceType(type: u8);
  }).toList();
  if (replaced) {
    types.add(PrimitiveType(primitive: scale.Primitive.U8));
  }
  return types;
}

List<Type> introduceOptionType(List<Type> types) {
  return types.map((Type type) {
    if (isOptionType(type) && type is VariantType) {
      return OptionType(
        type: type.variants[1].fields[0].type,
        docs: type.docs,
        path: type.path,
      );
    } else {
      return type;
    }
  }).toList();
}

bool isOptionType(Type type) {
  if (type.kind != scale.TypeKind.Variant) {
    return false;
  }
  if (type is VariantType && type.variants.length != 2) {
    return false;
  }
  var v0 = (type as VariantType).variants[0];
  var v1 = type.variants[1];
  return v0.name == 'None' &&
      v0.fields.isEmpty &&
      v0.index == 0 &&
      v1.name == 'Some' &&
      v1.index == 1 &&
      v1.fields.length == 1 &&
      v1.fields[0].name == null;
}

List<Type> removeUnitFieldsFromStructs(List<Type> types) {
  var changed = true;
  while (changed) {
    changed = false;
    types = types.map((type) {
      switch (type.kind) {
        case scale.TypeKind.Composite:
          if ((type as CompositeType).fields[0].name == null) {
            return type;
          }
          var fields = type.fields.where((f) {
            var fieldType = scale.getUnwrappedType(types, f.type) as Type;
            return !isUnitType(fieldType);
          }).toList();
          /* var fields = type.fields.filter(f => {
                        let fieldType = getUnwrappedType(types, f.type)
                        return !isUnitType(fieldType)
                    }); */
          if (fields.length == type.fields.length) {
            return type;
          }
          changed = true;

          return CompositeType(
            path: type.path,
            docs: type.docs,
            fields: fields,
          );

        case scale.TypeKind.Variant:
          var variants = (type as VariantType).variants.map((v) {
            if (v.fields[0].name == null) {
              return v;
            }
            var fields = v.fields.where((f) {
              var fieldType = scale.getUnwrappedType(types, f.type);
              return !isUnitType(fieldType as Type);
            }).toList();

            if (fields.length == v.fields.length) {
              return v;
            }
            changed = true;

            return Variant(
              fields: fields,
              docs: v.docs,
              index: v.index,
              name: v.name,
            );
          }).toList();

          return VariantType(
            variants: variants,
            path: type.path,
            docs: type.docs,
          );
        default:
          return type;
      }
    }).toList();
  }
  return types;
}

bool isUnitType(Type type) {
  return type.kind == scale.TypeKind.Tuple && (type as TupleType).tuple.isEmpty;
}

List<Type> replaceUnitOptionWithBoolean(List<Type> types) {
  return types.map((Type type) {
    if (type.kind == scale.TypeKind.Option &&
        isUnitType(
            scale.getUnwrappedType(types, (type as OptionType).type) as Type)) {
      return PrimitiveType(
        primitive: scale.Primitive.Bool,
        path: type.path,
        docs: type.docs,
      );
    } else {
      return type;
    }
  }).toList();
}

List<Type> normalizeFieldNames(List<Type> types) {
  return types
      .map((Type type) {
        switch (type.kind) {
          case scale.TypeKind.Composite:
            return CompositeType(
                path: type.path,
                docs: type.docs,
                fields: convertToCamelCase((type as CompositeType).fields));
          case scale.TypeKind.Variant:
            return VariantType(
              path: type.path,
              docs: type.docs,
              variants: (type as VariantType)
                  .variants
                  .map((Variant v) => Variant(
                        index: v.index,
                        name: v.name,
                        docs: v.docs,
                        fields: convertToCamelCase(v.fields),
                      ))
                  .toList(),
            );
          default:
            return type;
        }
      })
      .toList()
      .cast();
}

List<Field> convertToCamelCase(List<Field> fields) {
  return fields.map((f) {
    if (isNotEmpty(f.name)) {
      var name = f.name;
      if (name!.startsWith(RegExp(r'r#'))) {
        name = name.slice(2);
      }
      name = name.camelCase;
      return Field(docs: f.docs, type: f.type, name: name);
    } else {
      return f;
    }
  }).toList();
}

String sha256(dynamic data) {
  late String content;

  if (data is String) {
    content = data;
  } else {
    // stringify the hashmap
    content = jsonEncode(data);
  }

  final algorithm = const DartSha256();

  // sinker to which all the hashes will be appended and then (hashed or digested) at last step;
  final sink = algorithm.newHashSink();

  // add content to sinker to be hashed
  sink.add(utf8.encode(content));

  // close the sink to be able to hash/digest
  sink.close();

  return scale.encodeHex(sink.hashSync().bytes);
}

bool isPreV14(Metadata metadata) {
  switch (metadata.kind) {
    case 'V0':
    case 'V1':
    case 'V2':
    case 'V3':
    case 'V4':
    case 'V5':
    case 'V6':
    case 'V7':
    case 'V8':
    case 'V9':
    case 'V10':
    case 'V11':
    case 'V12':
    case 'V13':
      return true;
    default:
      return false;
  }
}
