part of models;

/// Portable registry wrapper for cleaner API
class PortableRegistry {
  final List<PortableType> types;

  PortableRegistry(this.types);

  PortableType? getType(int id) {
    for (final type in types) {
      if (type.id == id) {
        return type;
      }
    }
    return null;
  }
}
