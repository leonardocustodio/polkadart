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
RegExpMatch? getVecMatch(String typeString) {
  return RegExp(r'^([^<]*)<(.+)>$').firstMatch(typeString);
}
