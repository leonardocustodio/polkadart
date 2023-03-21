part of utils;

/// Asserts if the [value] value is true or not
///
/// Throws `AssertionException` if `false`
void assertion(bool value, [String? msg]) {
  if (!value) {
    throw AssertionException(msg ?? 'Assertion Error occured.');
  }
}

/// Decodes hex [value] and converts to Buffer of Uint8List
Uint8List decodeHex(String value) {
  if (value.startsWith('0x')) {
    value = value.substring(2);
  }
  try {
    return Uint8List.fromList(hex.decode(value));
  } catch (_) {
    throw HexException(value);
  }
}

/// Encodes buffer of list of integers [bytes] to hexa-decimal.
String encodeHex(List<int> bytes) {
  try {
    return hex.encode(bytes);
  } catch (_) {
    throw HexException('$bytes');
  }
}

///
/// returns a list of strings from a tuple string
///
/// '(a, b, c)'             =>   ['a','b','c']
/// '((a, b), c)'           => ['(a, b)', 'c']
/// '(a, (b, c))'         => ['a', '(b, c)']
/// '(a, (b, c), d)'      => ['a', '(b, c)', 'd']
/// '(a, (b, c), (d, e))' => ['a', '(b, c)', '(d, e)']
/// '((a, b), (c, d))'    => ['(a, b)', '(c, d)']
List<String> parseTupleRegExp(String text) {
  text = text.substring(1, text.length - 1);

  final List<String> result = <String>[];
  String buffer = '';

  int count = 0;

  for (var index = 0; index < text.length; index++) {
    final String char = text[index];
    if (char == '(') {
      count++;
    } else if (char == ')') {
      count--;
    }

    if (count == 0 &&
        char == ',' &&
        index != text.length - 1 &&
        text[index + 1] == ' ') {
      result.add(buffer);
      buffer = '';
      index++;
    } else {
      buffer += char;
    }
  }
  result.add(buffer);
  return result;
}
