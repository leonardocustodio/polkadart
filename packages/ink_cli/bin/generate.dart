library ink_cli;

import 'dart:io';
import 'package:args/args.dart';
import 'package:console/console.dart';
import 'package:ink_cli/ink_cli.dart';

const _sourceMetadataFile = 'source_metadata_file';
const _outputFile = 'output_file';
const _help = 'help';

void main(final List<String> args) async {
  final parser = _initiateParse();
  final result = parser.parse(args);

  if (result[_help] as bool? ?? false) {
    print(parser.usage);
    exit(0);
  }

  final bool foundMetadataFile = result.wasParsed(_sourceMetadataFile);
  final bool foundOutputFile = result.wasParsed(_outputFile);

  if (foundMetadataFile == false) {
    _setBrightRed();
    stderr.write('--$_sourceMetadataFile (-s) is required\n');
  }

  if (foundOutputFile == false) {
    _setBrightRed();
    stderr.write('--$_outputFile  (-o) is required\n');
  }
  if (foundMetadataFile == false || foundOutputFile == false) {
    exit(2);
  }

  final sourceMetadataFile = result[_sourceMetadataFile] as String;
  final outputFile = result[_outputFile] as String;

  try {
    final fileOutput = FileOutput(outputFile);
    final generator =
        TypeGenerator(abiFilePath: sourceMetadataFile, fileOutput: fileOutput);
    generator.generate();
    fileOutput.write();
    _setBrightGreen();
    print('✓ Contract Methods created in \'$outputFile\'');
  } catch (e) {
    _setBrightRed();
    stderr.write('Error while generating file: $e');
    exit(1);
  }
}

void _setBrightGreen() {
  Console.setTextColor(2, bright: true);
}

void _setBrightRed() {
  Console.setTextColor(1, bright: true);
}

ArgParser _initiateParse() {
  final ArgParser parser = ArgParser();

  parser.addFlag(
    _help,
    hide: true,
    abbr: 'h',
  );
  parser.addOption(
    _sourceMetadataFile,
    help:
        '$_sourceMetadataFile file is used to parse and generate contract methods',
    abbr: 's',
  );
  parser.addOption(
    _outputFile,
    help:
        '$_outputFile will be the file where the generated contract methods will be written',
    abbr: 'o',
  );

  return parser;
}
