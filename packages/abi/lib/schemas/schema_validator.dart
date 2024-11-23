part of abi;

class SchemaValidator {
  static final JsonSchema validatorV3 = JsonSchema.create(inkV3Schema);
  static final JsonSchema validatorV4 = JsonSchema.create(inkV4Schema);
  static final JsonSchema validatorV5 = JsonSchema.create(inkV5Schema);

  static bool isAbiV4(dynamic abi) {
    return abi is Map<String, dynamic> && abi['version'].toString() == '4';
  }

  static bool isAbiV5(dynamic abi) {
    return abi is Map<String, dynamic> && abi['version'].toString() == '5';
  }

  static Map<String, dynamic> getInkProject(dynamic abi) {
    if (isAbiV5(abi)) {
      final ValidationResults validationResult = validatorV5.validate(abi);
      if (validationResult.isValid) {
        return Map<String, dynamic>.from(abi);
      } else {
        throw Exception(
            'Unable to validate Ink V5 metadata: ${validationResult.errors}');
      }
    } else if (isAbiV4(abi)) {
      final ValidationResults validationResult = validatorV4.validate(abi);
      if (validationResult.isValid) {
        return Map<String, dynamic>.from(abi);
      } else {
        throw Exception(
            'Unable to validate Ink V4 metadata: ${validationResult.errors}');
      }
    } else {
      final ValidationResults validationResult = validatorV3.validate(abi);
      if (validationResult.isValid) {
        if (abi is Map<String, dynamic> && abi.containsKey('V3')) {
          return Map<String, dynamic>.from(abi['V3']);
        } else {
          throw Exception('Ink metadata below V3 is not supported');
        }
      } else {
        throw Exception(
            'Unable to validate Ink V3 metadata: ${validationResult.errors}');
      }
    }
  }
}
