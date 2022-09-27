import '../models/scale_codec_class.dart';

extension EncodeMethodTemplate on ScaleCodecClass {
  //TODO: implement encode method and test
  String generateEncodeMethod() {
    if (!shouldCreateEncodeMethod) {
      return '';
    }
    return '''
    String encode() => '';
    ''';
  }
}
