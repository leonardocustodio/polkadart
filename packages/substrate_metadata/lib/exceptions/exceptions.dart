///
/// SpecFileException
class SpecFileException implements Exception {
  final String message;

  SpecFileException(this.message);

  @override
  String toString() => message;
}

///
/// UnexpectedTypeException
class UnexpectedTypeException implements Exception {
  final String message;

  UnexpectedTypeException(this.message);

  @override
  String toString() => message;
}

///
/// UnsupportedMetadataException
class UnsupportedMetadataException implements Exception {
  final String message;

  UnsupportedMetadataException(this.message);

  @override
  String toString() => message;
}

class BlockNotFoundException implements Exception {
  const BlockNotFoundException(this.blockNumber);

  final dynamic blockNumber;

  @override
  String toString() {
    return '''
          Exception: Metadata not found for block: $blockNumber.'

          Try adding the SpecVersion for blockNumber: $blockNumber.
          ```
            chainObject.initSpecVersionFromFile('../../versions.json');
            
            or

            final specVersion = SpecVersion.fromJson( { specJson } );
            
            chainObject.addSpecVersion(specVersion);
          ```
          ''';
  }
}
