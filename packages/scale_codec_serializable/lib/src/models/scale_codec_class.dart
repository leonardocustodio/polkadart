import 'package:analyzer/dart/element/element.dart';

import '../config.dart';
import '../utils/asserts.dart';
import 'constructor.dart';

class ScaleCodecClass {
  final String name;
  final Constructor constructor;
  final bool shouldCreateDecodeMethod;
  final bool shouldCreateEncodeMethod;

  const ScaleCodecClass({
    required this.name,
    required this.constructor,
    required this.shouldCreateDecodeMethod,
    required this.shouldCreateEncodeMethod,
  });

  factory ScaleCodecClass.fromElement(
      ClassElement element, ClassConfig config) {
    assertClassIsNotAbstract(element);
    assertOneConstConstructor(element);

    final constructor = element.constructors.map(Constructor.fromElement).first;

    return ScaleCodecClass(
      name: element.name,
      constructor: constructor,
      shouldCreateDecodeMethod: config.shouldCreateDecodeMethod,
      shouldCreateEncodeMethod: config.shouldCreateEncodeMethod,
    );
  }
}
