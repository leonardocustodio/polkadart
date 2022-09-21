import 'package:source_gen/source_gen.dart';

import '../models/param.dart';
import 'param_template.dart';

class AllParamsTemplate {
  final Iterable<Param> params;

  const AllParamsTemplate(this.params);

  String generateParams() => _generateParams((param) => param.generateParam());

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

  String generateEncodedFields() => params
      .map(ParamTemplate.new)
      .map((e) => e.generateEncodedField())
      .join('\n');

  String _generateParams(
    String Function(ParamTemplate) paramGeneratorSelector,
  ) {
    final paramTemplates = params.map(ParamTemplate.new);
    final positional =
        paramTemplates.where((element) => element.param.isRequiredPositional);
    final optional =
        paramTemplates.where((element) => element.param.isOptionalPositional);
    final named = paramTemplates.where((element) => element.param.isNamed);

    if (optional.isNotEmpty && named.isNotEmpty) {
      throw InvalidGenerationSourceError(
          '[EROR] Method or constructor has optional positional and named params');
    }

    final positionalParams = positional.map(paramGeneratorSelector).join(',');
    final optionalParams = optional.isNotEmpty
        ? '[${optional.map(paramGeneratorSelector).join(',')}]'
        : null;
    final namedParams = named.isNotEmpty
        ? '{${named.map(paramGeneratorSelector).join(',')}}'
        : null;

    return [positionalParams, optionalParams, namedParams]
        .whereType<String>()
        .where((element) => element.isNotEmpty)
        .join(',');
  }
}
