// ignore_for_file: unused_local_variable

import 'package:ink_abi/ink_abi_base.dart';

void main() {
  final jsonFile =
      '/Users/kawal/Desktop/git_projects/polkadart/packages/ink_abi/example/v3_metadata.json';
/*   final json = jsonDecode(File(jsonFile).readAsStringSync());
  final jsonMap = SchemaValidator.getInkProject(json);
  final inkAbiDescription = InkAbiDescription(jsonMap);
  final types = inkAbiDescription.codecTypes();
  /* inkAbiDescription
    ..abiEvents()
    ..constructorSelectors()
    ..messageSelectors()
    ..constructors()
    ..messages(); */ */

  final output = FileOutput(
      '/Users/kawal/Desktop/git_projects/polkadart/packages/ink_abi/example/output.dart');
  final dartTypegen = DartTypegen(jsonFile, output);

  dartTypegen.generate();
  output.write();

  print('done Generating');
}
