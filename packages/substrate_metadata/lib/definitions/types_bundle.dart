import 'package:substrate_metadata/definitions/substrate/substrate_types_bundle.dart';
import '../models/legacy_types.dart';

///
/// Adds the `metadata_definitions` + `bundle`
///
/// Checks the bundle versions for inRange,
/// and `over-writes` the types of the `metadata_definitions` by using the `bundle`.
LegacyTypes getLegacyTypesFromBundle(
    LegacyTypesBundle bundle, int specVersion) {
  final types = LegacyTypes(
    types: <String, dynamic>{
      ...substrateTypesBundle.types,
      ...bundle.types,
    },
    typesAlias: <String, Map<String, String>>{
      if (substrateTypesBundle.typesAlias != null)
        ...substrateTypesBundle.typesAlias!,
      if (bundle.typesAlias != null) ...bundle.typesAlias!,
    },
    signedExtensions: <String, String>{
      if (substrateTypesBundle.signedExtensions != null)
        ...substrateTypesBundle.signedExtensions!,
      if (bundle.signedExtensions != null) ...bundle.signedExtensions!,
    },
  );

  if (bundle.versions?.isEmpty ?? true) {
    return types;
  }

  for (var i = 0; i < bundle.versions!.length; i++) {
    final override = bundle.versions![i];
    if (_isWithinRange(override.minmax, specVersion)) {
      types.types.addAll(override.types);

      types.typesAlias ??= <String, Map<String, String>>{};
      if (override.typesAlias != null) {
        types.typesAlias!.addAll(override.typesAlias!);
      }

      types.signedExtensions ??= <String, String>{};
      if (override.signedExtensions != null) {
        types.signedExtensions!.addAll(override.signedExtensions!);
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
