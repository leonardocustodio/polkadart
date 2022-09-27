import '../models/scale_codec_class.dart';
import 'all_params_template.dart';

extension DecodeMethodTemplate on ScaleCodecClass {
  //TODO: implement decode method and test
  String generateDecodeMethod() {
    if (!shouldCreateDecodeMethod) {
      return '';
    }
    final constructorParamTemplates = AllParamsTemplate(constructor.params);

    return '''
    $name decode (String encodedData) =>
    $name(${constructorParamTemplates.generateParamsUsage()});
    ''';
  }
}
