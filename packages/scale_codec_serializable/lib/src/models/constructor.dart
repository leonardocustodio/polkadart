import 'package:analyzer/dart/element/element.dart';

import 'param.dart';

class Constructor {
  final Iterable<Param> params;

  const Constructor({required this.params});

  factory Constructor.fromElement(ConstructorElement element) =>
      Constructor(params: element.parameters.map(Param.fromElement));
}
