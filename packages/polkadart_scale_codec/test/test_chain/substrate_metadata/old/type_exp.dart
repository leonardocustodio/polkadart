abstract class Type {
  final String kind;
  const Type({required this.kind});

  @override
  String toString() {
    return _toString(this);
  }

  String _toString(Type type) {
    switch (type.kind) {
      case 'array':
        return '[${_toString((type as ArrayType).item)}; ${type.len}]';
      case 'tuple':
        return '(${(type as TupleType).params.map((t) => _toString(t)).join(', ')})';
      case 'named':
        if ((type as NamedType).params.isEmpty) {
          return type.name;
        } else {
          return '${type.name}<${type.params.map((t) => t is int ? t.toString() : _toString(t as Type)).join(', ')}>';
        }
    }
    return '';
  }
}

class NamedType extends Type {
  final String name;

  /// list items can be of type -> `Type` or `int`
  final List<dynamic> params;
  const NamedType({required this.name, required this.params})
      : super(kind: 'named');
}

class ArrayType extends Type {
  final Type item;
  final int len;
  const ArrayType({required this.item, required this.len})
      : super(kind: 'array');
}

class TupleType extends Type {
  final List<Type> params;
  const TupleType({required this.params}) : super(kind: 'tuple');
}
