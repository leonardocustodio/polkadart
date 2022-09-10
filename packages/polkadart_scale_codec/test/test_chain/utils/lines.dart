import 'dart:io';

List<String> readLines(String filePath) {
  return File(filePath).readAsLinesSync();
}
