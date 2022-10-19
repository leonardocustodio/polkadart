// ignore_for_file: unnecessary_overrides
part of polkadart_scale_codec_core;

abstract class RegistryType extends Equatable {
  final String kind;
  const RegistryType({required this.kind});

  @override
  String toString() {
    return getFormattedString();
  }

  String getFormattedString() {
    switch (kind) {
      case 'array':
        var type = (this as RegistryArrayType);
        return '[${type.item.toString()}; ${type.length}]';
      case 'tuple':
        return '(${(this as RegistryTupleType).params.map((RegistryType t) => t.toString()).join(', ')})';
      case 'named':
        var type = (this as RegistryNamedType);
        if (type.params.isEmpty) {
          return type.name;
        } else {
          return '${type.name}<${type.params.map((t) => t is int ? t.toString() : (t as RegistryType)).join(', ')}>';
        }
    }
    return '';
  }

  @override
  List<Object?> get props => [kind];
}

class RegistryNamedType extends RegistryType with EquatableMixin {
  final String name;

  /// list items can be of type -> `RegistryType` or `int`
  final List<dynamic> params;
  const RegistryNamedType({required this.name, required this.params})
      : super(kind: 'named');

  @override
  List<Object?> get props => [name, params, 'named'];

  // We can't call super.toString() because it will end up calling toString() defined in the Equatable class.
  @override
  String toString() => super.getFormattedString();
}

class RegistryArrayType extends RegistryType with EquatableMixin {
  final RegistryType item;
  final int length;
  const RegistryArrayType({required this.item, required this.length})
      : super(kind: 'array');

  @override
  List<Object?> get props => [item, length, 'array'];

  // We can't call super.toString() because it will end up calling toString() defined in the Equatable class.
  @override
  String toString() => super.getFormattedString();
}

class RegistryTupleType extends RegistryType with EquatableMixin {
  final List<RegistryType> params;
  const RegistryTupleType({required this.params}) : super(kind: 'tuple');

  @override
  List<Object?> get props => [params, 'tuple'];

  // We can't call super.toString() because it will end up calling toString() defined in the Equatable class.
  @override
  String toString() => super.getFormattedString();
}

class TypeExpParser {
  List<String> _tokens = <String>[];
  int _idx = 0;
  late String _typeExp;

  TypeExpParser(String typeExp) {
    _typeExp = typeExp;
    _tokens = _tokenize(typeExp);
  }

  RegistryType parse() {
    var type = _assert(_anyType());
    if (!_eof()) {
      _abort();
    }
    return type;
  }

  bool _eof() {
    return _idx >= _tokens.length;
  }

  String? _tok(dynamic tok) {
    if (!(tok is String || tok is RegExp) || _eof()) {
      return null;
    }
    var current = _tokens[_idx];
    late bool match;
    if (tok is RegExp) {
      if (!!isNotEmpty(current)) {
        match = tok.hasMatch(current);
      }
    } else {
      match = current == tok;
    }
    if (match) {
      _idx += 1;
      return current;
    } else {
      return null;
    }
  }

  String _assertTok(dynamic tok) {
    return _assert(_tok(tok));
  }

  int? _nat() {
    var tok = _tok(RegExp(r'^\d+$'));
    return tok == null ? null : int.tryParse(tok);
  }

  int _assertNat() {
    return _assert(_nat());
  }

  String? _name() {
    return _tok(RegExp(r'^[a-zA-Z]\w*$'));
  }

  String _assertName() {
    return _assert(_name());
  }

  List<dynamic> _list(String sep, dynamic Function() p) {
    var item = p();
    if (item == null) {
      return [];
    }
    var result = [item];
    while (isNotEmpty(_tok(sep))) {
      item = p();
      if (item == null) {
        break;
      } else {
        result.add(item);
      }
    }
    return result;
  }

  RegistryTupleType? _tuple() {
    if (!isNotEmpty(_tok('('))) {
      return null;
    }
    var params = _list(',', () => _anyType());
    _assertTok(')');

    return RegistryTupleType(params: params.cast<RegistryType>());
  }

  RegistryArrayType? _array() {
    if (!isNotEmpty(_tok('['))) {
      return null;
    }

    var item = _assert(_anyType());
    _assertTok(';');
    var length = _assertNat();
    if (isNotEmpty(_tok(';'))) {
      _assertName();
    }
    _assertTok(']');

    return RegistryArrayType(item: item, length: length);
  }

  RegistryNamedType? _namedType() {
    late String name;
    String? trait;
    String? item;
    if (isNotEmpty(_tok('<'))) {
      name = _assertNamedType().name;
      _assertTok('as');
      trait = _assertNamedType().name;
      _assertTok('>');
    } else {
      var nameTok = _name();
      if (nameTok == null) {
        return null;
      }
      name = nameTok;
    }
    while (isNotEmpty(_tok('::')) && isNotEmpty(item = _name())) {}
    if (name == 'InherentOfflineReport' &&
        name == trait &&
        item == 'Inherent') {
    } else if (name == 'exec' && item == 'StorageKey') {
      name = 'ContractStorageKey';
    } else if (name == 'Lookup' && item == 'Source') {
      name = 'LookupSource';
    } else if (name == 'Lookup' && item == 'Target') {
      name = 'LookupTarget';
    } else if (isNotEmpty(item)) {
      _assert(trait != 'HasCompact');
      name = item!;
    } else if (trait == 'HasCompact') {
      return RegistryNamedType(name: 'Compact', params: <dynamic>[
        RegistryNamedType(name: name, params: _typeParameters())
      ]);
    }
    return RegistryNamedType(name: name, params: _typeParameters());
  }

  RegistryNamedType _assertNamedType() {
    return _assert(_namedType());
  }

  List<dynamic> _typeParameters() {
    List<dynamic> params = <dynamic>[];
    if (isNotEmpty(_tok('<'))) {
      params = _list(',', () {
        var natValue = _nat();
        if (natValue != null && natValue != 0) {
          return natValue;
        }
        return _anyType();
      });
      _assertTok('>');
    } else {
      params = <dynamic>[];
    }
    return params;
  }

  RegistryType? _pointerBytes() {
    if (!isNotEmpty(_tok('&'))) {
      return null;
    }
    if (isNotEmpty(_tok("'"))) {
      _assertTok('static');
    }
    _assertTok('[');
    _assertTok('u8');
    _assertTok(']');
    return RegistryNamedType(
        name: 'Vec',
        params: <dynamic>[RegistryNamedType(name: 'u8', params: <dynamic>[])]);
  }

  RegistryType? _anyType() {
    return _tuple() ?? _array() ?? _namedType() ?? _pointerBytes();
  }

  void _abort() {
    throw Exception('Invalid type expression: $_typeExp');
  }

  dynamic _assert(dynamic value) {
    if (value == null || (value is bool && value == false)) {
      _abort();
    } else {
      return value;
    }
  }

  List<String> _tokenize(String typeExp) {
    List<String> tokens = <String>[];
    String word = '';
    for (var i = 0; i < typeExp.length; i++) {
      var c = typeExp[i];
      if (RegExp(r'\w').hasMatch(c)) {
        word += c;
      } else {
        if (isNotEmpty(word)) {
          tokens.add(word);
          word = '';
        }
        c = c.trim();
        if (c == ':' && typeExp[i + 1] == ':') {
          i += 1;
          tokens.add('::');
        } else if (isNotEmpty(c)) {
          tokens.add(c);
        }
      }
    }
    if (isNotEmpty(word)) {
      tokens.add(word);
    }
    return tokens;
  }
}
