import 'package:substrate_metadata/old/legacy_types_model.dart';
import 'package:substrate_metadata/utils/utils.dart';
import 'definitions/metadata/metadata.dart' as metadata_definitions;
import 'definitions/substrate/substrate_types_bundle.dart';

///
/// Adds the `metadata_definitions` + `bundle`
///
/// Checks the bundle versions for inRange,
/// and `overrites` the types of the `metadata_definitions` by using the `bundle`.
LegacyTypes getLegacyTypesFromBundle(
    LegacyTypesBundle bundle, int specVersion) {
  var types = LegacyTypes(
    types: <String, dynamic>{
      if (metadata_definitions.types.types != null)
        ...metadata_definitions.types.types!,
      if (substrateTypesBundle.types != null) ...substrateTypesBundle.types!,
      if (bundle.types != null) ...bundle.types!,
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

  if (!isNotEmpty(bundle.versions?.length)) {
    return types;
  }

  for (var i = 0; i < bundle.versions!.length; i++) {
    var override = bundle.versions![i];
    if (_isWithinRange(override.minmax, specVersion)) {
      types.types ??= <String, dynamic>{};
      if (override.types != null) {
        types.types!.addAll(override.types!);
      }

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
  var beg = range[0] ?? 0;
  var end = range[1] ?? double.maxFinite;
  return beg <= version && version <= end;
}
