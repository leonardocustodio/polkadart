import 'package:code_builder/code_builder.dart'
    show Expression, TypeReference, literalString, literalNum;
import './constants.dart' as constants;

// reference: https://www.codesansar.com/dart/keywords.htm
const Set<String> reservedWords = {
  'assert',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'default',
  'do',
  'else',
  'enum',
  'extends',
  'false',
  'final',
  'finally',
  'for',
  'if',
  'in',
  'is',
  'new',
  'null',
  'rethrow',
  'return',
  'super',
  'switch',
  'this',
  'throw',
  'true',
  'try',
  'var',
  'void',
  'while',
  'with'
};

String sanitize(String name) =>
    reservedWords.contains(name) ? '${name}_' : name;

Expression bigIntToExpression(BigInt value) {
  if (value == BigInt.zero) {
    return constants.bigInt.property('zero');
  } else if (value == BigInt.one) {
    return constants.bigInt.property('one');
  } else if (value == BigInt.two) {
    return constants.bigInt.property('two');
  }

  // Max number that can be represented precisely in Web
  // reference: https://dart.dev/guides/language/numbers#precision
  if (value <= BigInt.from(9007199254740992)) {
    return constants.bigInt.property('from').call([literalNum(value.toInt())]);
  }

  // Otherwise, use string parser
  return constants.bigInt.property('parse').call(
      [literalString(value.toRadixString(10))], {'radix': literalNum(10)});
}

// Return a compatible type for two types.
TypeReference _toCompatibleType(TypeReference a, TypeReference b) {
  // If they are equal, return any
  if (a == b) {
    return a;
  }

  // If 'a' or 'b' is dynamic, return dynamic
  if (a.symbol == constants.dynamic.symbol) {
    return a;
  }
  if (b.symbol == constants.dynamic.symbol) {
    return b;
  }

  // Check if the types are compatible
  if (a.symbol != b.symbol ||
      a.url != b.url ||
      a.types.length != b.types.length ||
      a.bound != b.bound) {
    return constants.dynamic.type as TypeReference;
  }

  // Convert subtypes to compatible types
  return TypeReference((builder) {
    builder
      ..symbol = a.symbol
      ..url = a.url
      ..bound = a.bound;

    // Recusively convert subtypes
    for (int i = 0; i < a.types.length; i++) {
      final type = _toCompatibleType(
          a.types[i].type as TypeReference, b.types[i].type as TypeReference);
      builder.types.add(type);
    }

    // If any of the types are nullable, the final type is nullable
    if (a.isNullable == true || b.isNullable == true) {
      builder.isNullable = true;
    }
  });
}

/// Find a type which is common for all types in the list.
TypeReference findCommonType(Iterable<TypeReference> types) {
  if (types.isEmpty) {
    return constants.dynamic.type as TypeReference;
  }
  if (types.length == 1) {
    return types.first;
  }
  TypeReference baseType = types.first;
  for (TypeReference type in types) {
    baseType = _toCompatibleType(baseType, type);
    if (baseType.symbol == constants.dynamic.symbol) {
      return baseType;
    }
  }
  return baseType;
}
