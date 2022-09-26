import '../models/param.dart';
import 'param_template.dart';

/// Template used to write the declaration of all [ParamTemplate] of a class.
class AllParamsTemplate {
  final Iterable<Param> params;

  const AllParamsTemplate(this.params);

  /// Used to write all parameters in constructors declaration.
  ///
  /// Check an example of use on `DecodeMethodTemplate`.
  String generateParamsUsage() {
    final positional = params
        .where((element) => element.isPositional)
        .map(ParamTemplate.new)
        .map((e) => e.generateParameterUsage());

    final named = params
        .where((element) => element.isNamed)
        .map(ParamTemplate.new)
        .map((e) => e.generateParameterUsage());

    return [...positional, ...named].join(',');
  }

  /// Generate new encoded fields for each [ParamTemplate].
  ///
  /// Example:
  /// ```
  /// ...
  /// String exampleEncoded = '';
  /// ```
  String generateEncodedFields() => params
      .map(ParamTemplate.new)
      .map((e) => e.generateEncodedField())
      .join('\n');
}
