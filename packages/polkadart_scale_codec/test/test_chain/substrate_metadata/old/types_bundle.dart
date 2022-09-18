import '../../utils/common_utils.dart';
import 'definitions/metadata/index.dart' as metadata_definitions;
import 'definitions/substrate/src.dart';
import 'types.dart';

OldTypes getTypesFromBundle(OldTypesBundle bundle, int specVersion) {
  var types = OldTypes(
      types: <String, dynamic>{
        /// TODO: check `metadata_definitions.types.types` whether it is unwrapping every child element
        /// or only types variable
        ...(metadata_definitions.types.types ?? <String, dynamic>{}),
        ...(substrateBundle.types ?? <String, dynamic>{}),
        ...(bundle.types ?? <String, dynamic>{})
      },
      typesAlias: OldTypesAlias(
        <String, Map<String, String>>{
          ...(substrateBundle.typesAlias?.data ??
              <String, Map<String, String>>{}),
          ...(bundle.typesAlias ?? <String, Map<String, String>>{})
        },
      ),
      signedExtensions: <String, String>{
        ...(substrateBundle.signedExtensions ?? <String, dynamic>{}),
        ...(bundle.signedExtensions ?? <String, dynamic>{})
      });

  if (!isNotEmpty(bundle.versions?.length)) {
    return types;
  }

  for (var i = 0; i < bundle.versions!.length; i++) {
    var override = bundle.versions![i];
    if (isWithinRange(override.minmax, specVersion)) {
      types.types = <String, dynamic>{
        if (override.types != null) ...override.types!,
        if (types.types != null) ...types.types!
      };

      types.typesAlias = OldTypesAlias(<String, Map<String, String>>{
        if (override.typesAlias?.data != null) ...override.typesAlias!.data,
        if (types.typesAlias != null) ...types.typesAlias!
      });

      types.signedExtensions = <String, String>{
        if (override.signedExtensions != null) ...override.signedExtensions!,
        if (types.signedExtensions != null) ...types.signedExtensions!
      };
    }
  }

  return types;
}

bool isWithinRange(SpecVersionRange range, int version) {
  var beg = range[0] ?? 0;
  var end = range[1] ?? double.maxFinite;
  return beg <= version && version <= end;
}
