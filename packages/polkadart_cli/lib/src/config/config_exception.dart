class ConfigException implements Exception {
  final String message;

  ConfigException(this.message);

  ConfigException.parseError(String error)
    : message = "Failed to extract config from the 'pubspec.yaml' file.\n$error";
  factory ConfigException.invalidField({
    required String path,
    required Object expect,
    required Object actual,
  }) {
    return ConfigException.parseError("Invalid '$path', expected $expect but got $actual.");
  }

  @override
  String toString() => 'ConfigException: $message';
}
