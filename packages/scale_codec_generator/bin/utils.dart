import 'package:code_builder/code_builder.dart' show Expression, literalString, literalNum;
import './constants.dart' as constants;

// reference: https://www.codesansar.com/dart/keywords.htm
final Set<String> reservedWords = {
  'assert', 'break', 'case', 'catch', 'class', 'const', 'continue',
  'default', 'do', 'else', 'enum', 'extends', 'false', 'final', 'finally',
  'for', 'if', 'in', 'is', 'new', 'null', 'rethrow', 'return', 'super',
  'switch', 'this', 'throw', 'true', 'try', 'var', 'void', 'while', 'with'
};

String sanitize(String name) => reservedWords.contains(name) ? "${name}_" : name;

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
  return constants.bigInt.property('parse').call([literalString(value.toRadixString(10))], { 'radix': literalNum(10) });
}