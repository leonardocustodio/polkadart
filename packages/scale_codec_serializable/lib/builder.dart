import 'package:build/build.dart';
import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'src/scale_part_builder.dart';

Builder scaleCodecSerializable(BuilderOptions options) {
  final config = ScaleCodecSerializable.fromMap(options.config);
  return scaleCodecPartBuilder(config: config);
}
