import 'dart:io';
import 'package:ink_cli/ink_cli.dart';

void main() {
  final String dir = Directory.current.absolute.path;
  final fileOutput = FileOutput('$dir/example/generated.dart');
  final generator = TypeGenerator(
    abiFilePath: './example/v3_metadata.json',
    fileOutput: fileOutput,
  );
  generator.generate();
  fileOutput.write();
  print('Generated');
}
