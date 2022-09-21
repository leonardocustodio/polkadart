import '../models/param.dart';

class ParamTemplate {
  final Param param;

  const ParamTemplate(this.param);

  /// Examples of use:
  /// ```
  /// String example
  /// String example = 'example'
  /// required String example
  /// required String example = 'example'
  /// ```
  String generateParam() =>
      '$_requiredKeyword ${param.type} ${param.name} $_defaultValue';

  /// Examples of use:
  /// ```
  /// this.example
  /// this.example = 'example'
  /// required this.example
  /// required this.example = 'example'
  /// ```
  String generateThisParam() =>
      '$_requiredKeyword this.${param.name} $_defaultValue';

  /// Example of use:
  /// ```
  /// String get exampleEncoded => '';
  /// ```
  String generateEncodedField() =>
      "String get ${param.name}Encoded => 'TODO: encode ${param.name}';";

  /// Example of use:
  /// ```
  ///  Person(name: 'example')
  ///  Person('example')
  /// ```
  String generateParameterUsage() {
    if (param.isNamed) {
      return '${param.name}: ${param.name}';
    } else {
      return param.name;
    }
  }

  /// Returns the `required` keyword if the param is required and named.
  ///
  /// Example:
  /// ```
  /// Person({required this.name});
  /// _requiredKeyword => 'required'
  /// ```
  /// ...
  /// ```
  /// Person(this.name)
  /// _requiredKeyword => ''
  /// ```
  String get _requiredKeyword => param.isRequiredNamed ? 'required' : '';

  /// Returns the default value if the param is required and named.
  ///
  /// Example:
  /// ```
  /// Person({this.name = 'example'});
  /// _defaultValue => '= example'
  /// ```
  /// ...
  /// ```
  /// Person(this.name)
  /// _defaultValue => ''
  /// ```
  String get _defaultValue =>
      param.defaultValue != null ? '= ${param.defaultValue}' : '';
}
