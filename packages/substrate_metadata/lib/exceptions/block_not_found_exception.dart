part of exceptions;

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
