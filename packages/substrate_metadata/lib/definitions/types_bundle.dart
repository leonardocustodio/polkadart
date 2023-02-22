import 'legacy_types_model.dart';
import 'metadata/metadata.dart' as metadata_definitions;
import 'substrate/substrate_types_bundle.dart' as substrate;

///
/// Adds the `metadata_definitions` + `bundle`
///
/// Checks the bundle versions for inRange,
/// and `overrites` the types of the `metadata_definitions` by using the `bundle`.
LegacyTypes getLegacyTypesFromBundle(
    LegacyTypesBundle bundle, int specVersion) {
  final types = LegacyTypes(
    types: <String, dynamic>{
      ...metadata_definitions.metadataTypes.types,
      ...substrate.substrateLegacyTypesBundle.types,
      ...bundle.types,
    },
    typesAlias: <String, Map<String, String>>{
      if (substrate.substrateLegacyTypesBundle.typesAlias != null)
        ...substrate.substrateLegacyTypesBundle.typesAlias!,
      if (bundle.typesAlias != null) ...bundle.typesAlias!,
    },
    signedExtensions: <String, String>{
      if (substrate.substrateLegacyTypesBundle.signedExtensions != null)
        ...substrate.substrateLegacyTypesBundle.signedExtensions!,
      if (bundle.signedExtensions != null) ...bundle.signedExtensions!,
    },
  );

  if (bundle.versions == null || bundle.versions!.isEmpty) {
    return types;
  }

  for (var i = 0; i < bundle.versions!.length; i++) {
    final overrideInfo = bundle.versions![i];
    if (_isWithinRange(overrideInfo.minmax, specVersion)) {
      types.types.addAll(overrideInfo.types);
      if (overrideInfo.typesAlias != null) {
        types.typesAlias!.addAll(overrideInfo.typesAlias!);
      }
      if (overrideInfo.signedExtensions != null) {
        types.signedExtensions!.addAll(overrideInfo.signedExtensions!);
      }
    }
  }

  return types;
}

bool _isWithinRange(List<int?> range, int version) {
  final beg = range[0] ?? 0;
  final end = range[1] ?? double.maxFinite;
  return beg <= version && version <= end;
}
