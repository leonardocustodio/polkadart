import '../../utils/common_utils.dart';

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

Type parse(String typeExp) {
  return TypeExpParser(typeExp).parse();
}

typedef _CustomFunc = dynamic Function();

class TypeExpParser {
  List<String> _tokens = <String>[];
  int _idx = 0;
  late String _typeExp;

  TypeExpParser(String typeExp) {
    _typeExp = typeExp;
    _tokens = tokenize(typeExp);
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

  List<dynamic> _list(String sep, _CustomFunc p) {
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

  TupleType? _tuple() {
    if (!isNotEmpty(_tok('('))) {
      return null;
    }
    var params = _list(',', () => _anyType());
    _assertTok(')');

    return TupleType(params: params.cast<Type>());
  }

  ArrayType? _array() {
    if (!isNotEmpty(_tok('['))) {
      return null;
    }

    var item = _assert(_anyType());
    _assertTok(';');
    var len = _assertNat();
    if (isNotEmpty(_tok(';'))) {
      _assertName();
    }
    _assertTok(']');

    return ArrayType(item: item, len: len);
  }

  NamedType? _namedType() {
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
    while (isNotEmpty(_tok('::')) && isNotEmpty(item = _name()!)) {}
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
      return NamedType(
          name: 'Compact',
          params: <dynamic>[NamedType(name: name, params: typeParameters())]);
    }
    return NamedType(name: name, params: typeParameters());
  }

  NamedType _assertNamedType() {
    return _assert(_namedType());
  }

  List<dynamic> typeParameters() {
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

  Type? _pointerBytes() {
    if (!isNotEmpty(_tok('&'))) {
      return null;
    }
    if (isNotEmpty(_tok("'"))) {
      _assertTok('static');
    }
    _assertTok('[');
    _assertTok('u8');
    _assertTok(']');
    return NamedType(
        name: 'Vec',
        params: <dynamic>[NamedType(name: 'u8', params: <dynamic>[])]);
  }

  Type? _anyType() {
    return _tuple() ?? _array() ?? _namedType() ?? _pointerBytes();
  }

  Type parse() {
    var type = _assert(_anyType());
    if (!_eof()) {
      _abort();
    }
    return type;
  }

  void _abort() {
    throw Exception('Invalid type expression: $_typeExp');
  }

  dynamic _assert(dynamic val) {
    if (val == null || (val is bool && val == false)) {
      _abort();
    } else {
      return val;
    }
  }
}

List<String> tokenize(String typeExp) {
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
