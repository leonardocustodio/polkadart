part of ink_cli;

class Names {
  final Map<int, String> _assignment = {};
  final Map<String, String> _assigned = {};
  final Set<String> _reserved = {'Result', 'Option', 'Bytes', 'BitSequence'};
  final Map<int, Set<String>> _aliases = {};

  final List<CodecInterface> _types;
  Names(this._types);

  void assign(final int ti, final String name) {
    assert(_isFree(name),
        'Attempted to assign name "$name" which is already it is already reserved or assigned.');
    _assigned[name] = getTypeHash(_types, ti);
    _assignment[ti] = name;
  }

  bool _isFree(final String name) {
    return _reserved.contains(name) == false && _assigned.containsKey(name) == false;
  }

  void reserve(final String name) {
    assert(
        _isFree(name), 'Cannot reserve name "$name" because it is already reserved or assigned.');
    _reserved.add(name);
  }

  void alias(final int ti, final String name) {
    final existing = _aliases[ti];
    if (existing != null) {
      existing.add(name);
    } else {
      _aliases[ti] = {name};
    }
  }

  ///
  /// Returns a map from type index -> assigned name.
  Map<int, String> getAssignment() {
    // -- First pass --
    for (int ti = 0; ti < _types.length; ti++) {
      if (_assignment.containsKey(ti)) {
        continue;
      }
      if (!isNameNeeded(_types, ti)) {
        continue;
      }

      final String? name = deriveName(_types[ti]);
      if (name != null && _isFree(name)) {
        assign(ti, name);
        continue;
      }

      final Set<String>? aliases = _aliases[ti];
      if (aliases != null) {
        // Check each alias until we find a free one
        for (final String aliasName in aliases) {
          if (_isFree(aliasName)) {
            assign(ti, aliasName);
            break;
          }
        }
        // If we successfully assigned, move on
        if (_assignment.containsKey(ti)) {
          continue;
        }
      }

      // Fallback name: `Type_0`, `Type_1`, ...
      assign(ti, 'Type_$ti');
    }

    // -- Second pass --
    // Here we try to name everything (except sequences) if it doesn't have a name yet.
    for (int ti = 0; ti < _types.length; ti++) {
      final CodecInterface type = _types[ti];
      if (_assignment.containsKey(ti) || type.kind == TypeKind.sequence) {
        continue;
      }

      final String? name = deriveName(type);
      if (name != null && _isFree(name)) {
        assign(ti, name);
      }
    }

    // -- Third pass --
    // If still unnamed (and not a sequence), we look for a single alias
    for (int ti = 0; ti < _types.length; ti++) {
      if (_assignment.containsKey(ti) || _types[ti].kind == TypeKind.sequence) {
        continue;
      }

      final Set<String>? aliases = _aliases[ti];
      if (aliases != null && aliases.length == 1) {
        final String soleAlias = aliases.first;
        if (_isFree(soleAlias)) {
          assign(ti, soleAlias);
        }
      }
    }

    return _assignment;
  }
}

///
/// Derive the "the best" name from the path.
String? deriveName(final CodecInterface type) {
  // If no path or empty path, we have nothing to derive
  if (type.path == null || type.path!.isEmpty) {
    return null;
  }

  // Try to find something that looks like 'vNN' in the path
  final version = type.path!.firstWhere(
    (name) => RegExp(r'^v\d+$', caseSensitive: false).hasMatch(name),
    orElse: () => '',
  );

  final lastName = type.path!.last; // The final segment
  if (version.isNotEmpty && version != lastName) {
    // E.g. version = 'v1', name = 'Thing' => 'V1Thing'
    return 'V${version.substring(1)}$lastName';
  } else {
    return lastName;
  }
}

bool isNameNeeded(final List<CodecInterface> types, final int ti) {
  final CodecInterface ty = types[ti];
  switch (ty.kind) {
    case TypeKind.variant:
      return asResultType(ty as VariantCodecInterface) == null && asOptionType(ty) == null;
    case TypeKind.composite:
      return true;
    default:
      return false;
  }
}

Map<String, int?>? asResultType(final VariantCodecInterface type) {
  if (type.variants.length != 2) {
    return null;
  }

  // Find `Ok` variant
  Variants? ok;
  for (final Variants variant in type.variants) {
    if (variant.name == 'Ok') {
      ok = variant;
      break;
    }
  }
  if (ok == null) {
    return null;
  }

  // Find `Err` variant
  Variants? err;
  for (final Variants variant in type.variants) {
    if (variant.name == 'Err') {
      err = variant;
      break;
    }
  }
  if (err == null) {
    return null;
  }

  // Check both are "value variants"
  if (isValueVariant(ok) && isValueVariant(err)) {
    // Grab the type from the first field if it exists, else null
    int? okType;
    if (ok.fields.isNotEmpty) {
      okType = ok.fields[0].type;
    }
    int? errType;
    if (err.fields.isNotEmpty) {
      errType = err.fields[0].type;
    }

    return <String, int?>{
      'ok': okType,
      'err': errType,
    };
  }
  return null;
}

Map<String, int?>? asOptionType(final VariantCodecInterface type) {
  if (type.variants.length != 2) {
    return null;
  }

  // Find `Some` variant
  Variants? some;
  for (final Variants variant in type.variants) {
    if (variant.name == 'Some') {
      some = variant;
      break;
    }
  }
  if (some == null) {
    return null;
  }

  // Find `None` variant
  Variants? none;
  for (final Variants variant in type.variants) {
    if (variant.name == 'None') {
      none = variant;
      break;
    }
  }
  if (none == null) {
    return null;
  }

  // Check that `Some` is a value variant and `None` has zero fields
  if (isValueVariant(some) && none.fields.isEmpty) {
    int? someType;
    if (some.fields.isNotEmpty) {
      someType = some.fields[0].type;
    }
    return <String, int?>{
      'some': someType,
    };
  }
  return null;
}

bool isValueVariant(final Variants v) {
  return v.fields.isEmpty || (v.fields.length < 2 && v.fields[0].name == null);
}

/* /// Placeholder for your real implementation.
String getTypeHash(List<Type> types, int ti) {
  // Return a stable hash or unique string for the type at `ti`.
  // This is just a stub.
  return 'hash_of_type_$ti';
}

/// Placeholder for your real implementation.
bool asResultType(Type ty) {
  // Return `true` if `ty` is recognized as a `Result`.
  return false;
}

/// Placeholder for your real implementation.
bool asOptionType(Type ty) {
  // Return `true` if `ty` is recognized as an `Option`.
  return false;
} */
