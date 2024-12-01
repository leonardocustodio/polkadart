part of ink_abi;

class SchemaValidator {
  static final JsonSchema validatorV3 = JsonSchema.create(inkV3Schema);
  static final JsonSchema validatorV4 = JsonSchema.create(inkV4Schema);
  static final JsonSchema validatorV5 = JsonSchema.create(inkV5Schema);

  static bool isAbiV4(dynamic inkAbi) {
    return inkAbi is Map<String, dynamic> &&
        inkAbi['version'].toString() == '4';
  }

  static bool isAbiV5(dynamic inkAbi) {
    return inkAbi is Map<String, dynamic> &&
        inkAbi['version'].toString() == '5';
  }

  static Map<String, dynamic> getInkProject(dynamic inkAbi) {
    if (isAbiV5(inkAbi)) {
      final ValidationResults validationResult = validatorV5.validate(inkAbi);
      if (validationResult.isValid) {
        return Map<String, dynamic>.from(inkAbi);
      } else {
        throw Exception(
            'Unable to validate Ink V5 metadata: ${validationResult.errors}');
      }
    } else if (isAbiV4(inkAbi)) {
      final ValidationResults validationResult = validatorV4.validate(inkAbi);
      if (validationResult.isValid) {
        return Map<String, dynamic>.from(inkAbi);
      } else {
        throw Exception(
            'Unable to validate Ink V4 metadata: ${validationResult.errors}');
      }
    } else {
      final ValidationResults validationResult = validatorV3.validate(inkAbi);
      if (validationResult.isValid) {
        if (inkAbi is Map<String, dynamic> && inkAbi.containsKey('V3')) {
          return Map<String, dynamic>.from(inkAbi['V3']);
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
