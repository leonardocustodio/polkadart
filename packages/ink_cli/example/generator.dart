import 'package:ink_cli/ink_cli.dart';

void main() {
    final fileOutput = FileOutput('/Users/kawal/Desktop/git_projects/polkadart/packages/ink_cli/example/generated.dart');
    final generator =
        TypeGenerator(abiFilePath: './example/v3_metadata.json', fileOutput: fileOutput);
    generator.generate();
    fileOutput.write();
    print('Generated');
}
