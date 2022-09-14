import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ClassVisitor extends SimpleElementVisitor<void> {
  late String className;
  final fields = <String, FieldElement>{};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    className = elementReturnType.replaceFirst('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    // final elementType = element.type.toString();
    fields[element.name] = element;
  }
}
