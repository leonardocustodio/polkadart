part of utils;

///
/// Match the typeString with the regex
/// Example: 'Vec<u8>' -> ['Vec<u8>', 'Vec', 'u8']
/// Example: 'Vec<(u8, u8)>' -> ['Vec<(u8, u8)>', 'Vec', '(u8, u8)']
///
/// Example:
/// ```dart
/// final match = getVecMatch('Vec<u8>');
/// print(match); // ['Vec<u8>', 'Vec', 'u8']
/// ```
///
/// Example:
/// ```dart
/// final match = getVecMatch('Vec<(u8, u8)>');
/// print(match); // ['Vec<(u8, u8)>', 'Vec', '(u8, u8)']
/// ```
///
/// Example:
/// ```dart
/// final match = getVecMatch('Vec<(u8, Vec<u8>)>');
/// print(match); // ['Vec<(u8, Vec<u8>)>', 'Vec', '(u8, Vec<u8>)']
/// ```
RegExpMatch? getArrowMatch(String typeString) {
  return RegExp(r'^([^<]*)<(.+)>$').firstMatch(typeString);
}

///
/// Match the typeString with the regex
/// Example: 'Result<u8, bool>' -> ['Result<u8, bool>', 'Result', 'u8', 'bool']
/// Example: 'Result<Result<u8, bool>, bool>' -> ['Result<Result<u8, bool>, bool>', 'Result', 'Result<u8, bool>', 'bool']
RegExpMatch? getResultMatch(String typeString) {
  return RegExp(r'^([^<]*)<(.+),(.+)>$').firstMatch(typeString);
}

///
/// Match the typeString with the regex
/// Example: '[u8; 10]' -> ['[u8; 10]', 'u8', '10']
/// Example: '[[u8; 2]; 100]' -> ['[u8; 100]', '[u8; 2]', '100']
RegExpMatch? getArrayMatch(String typeString) {
  return RegExp(r'\[(.+); ([0-9]+)\]$').firstMatch(typeString);
}
