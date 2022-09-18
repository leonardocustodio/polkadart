class OldTypesBundleException implements Exception {
  const OldTypesBundleException([this.fileName, this.error]);

  final String? fileName;
  final Object? error;

  @override
  String toString() {
    return fileName == null || error == null
        ? 'Failed to parse OldTypesBundle'
        : 'Failed to parse $fileName: $error';
  }
}
