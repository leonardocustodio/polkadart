import '../models/scale_codec_class.dart';

extension EncodeMethodTemplate on ScaleCodecClass {
  String generateEncodeMethod() {
    if (!shouldCreateEncodeMethod) {
      return '';
    }
    return '''
    String encode() => '';
    ''';
  }
}
