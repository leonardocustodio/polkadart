import 'dart:math';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:weak_map/weak_map.dart';
import 'utils/utils.dart';

// ignore: non_constant_identifier_names
final HASHERS = WeakMap<List<scale_codec.Type>, TypeHasher>();

TypeHasher getTypeHasher(List<scale_codec.Type> types) {
  var hasher = HASHERS.get(types);
  if (hasher == null) {
    hasher = TypeHasher(types);
    HASHERS[types] = hasher;
  }
  return hasher;
}

///
/// Get a strong hash of substrate type, which can be used for equality derivation
String getTypeHash(List<scale_codec.Type> types, int typeIndex) {
  return getTypeHasher(types).getHash(typeIndex);
}

/// Hash Node
///
/// More info: https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm
class HashNode {
  int index;
  int lowIndex;
  bool onStack;
  String hash;
  int? component;

  HashNode({
    required this.index,
    required this.lowIndex,
    required this.onStack,
    required this.hash,
    this.component,
  });
}

///
/// Computes hashes of substrate types for the purpose of equality derivation.
///
/// Substrate types form a cyclic directed graph.
/// Two types are equal when their depth-first traversal trees are equal.
/// Inline with equality, we define a type hash to be a merkel hash of it's depth-first traversal.
///
/// Note, that unlike a classic tree case we might need
/// to visit mutually recursive type nodes more than once.
///
/// Naive approach of performing a depth-first traversal for each node might not work,
/// as we typically have around 10^3 nodes in a graph. This is on a verge of being slow.
///
/// Hence, the following procedure:
/// 1. We embed Tarjan's strongly connected components algorithm in our hash computation to discover and
/// persist information about strongly connected components.
///  2. For each strongly connected component, we cache the resulting hash per entry point.
///
/// This allows us to visit non-mutually recursive types only once and makes the overall procedure
/// quadratic only on the size of a maximal strongly connected component, which practically should not be big.
///
class TypeHasher {
  List<String> _cache = <String>[];

  int _index = 1;
  List<HashNode?> _nodes = <HashNode?>[];
  final List<int> _stack = <int>[];
  List<scale_codec.Type> _types = <scale_codec.Type>[];

  TypeHasher(List<scale_codec.Type> types) {
    _types = types;
    _cache = List<String>.filled(types.length, '');
    _nodes = List<HashNode?>.filled(types.length, null);
  }

  String getHash(int typeIndex) {
    assertionCheck(typeIndex >= 0 && typeIndex < _types.length);
    var hash = _cache[typeIndex];
    if (isNotEmpty(hash)) {
      return hash;
    }

    return _hash(
      typeIndex,
      // dummy root node
      HashNode(index: 0, lowIndex: 0, onStack: false, hash: '', component: 0),
    );
  }

  /// [Private function]
  String _hash(int ti, HashNode parent) {
    var node = _nodes[ti];
    if (node != null) {
      // We already visited this node before, which could happen because:
      // 1. We visited it during a previous traversal
      // 2. We visited it during a current traversal
      if (node.onStack) {
        // This is certainly a current traversal,

        parent.lowIndex = min(parent.lowIndex, node.index);
        return node.hash;
      }
      if (isNotEmpty(node.hash)) {
        // This is a current traversal.
        // Parent and node belong to the same component.
        // In all other cases `node.hash` is empty.
        return node.hash;
      }
      // This is a previous traversal, or we already exited
      // the strongly connected component of a `node`.
      scale_codec.assertionCheck(node.component !=
          null); // In any case component information must be available.
      if (node.component != parent.component) {
        // We are entering the strongly connected component.
        // We can return a hash right away if we entered it via this node before.
        var hash = _cache[ti];
        if (isNotEmpty(hash)) {
          return hash;
        }
      }
      // Otherwise, perform a regular Tarjan's visit as nothing happened.
    }
    node = HashNode(
        index: _index,
        lowIndex: _index,
        onStack: true,
        hash: '',
        component: node?.component);
    _index += 1;
    _nodes[ti] = node;
    _stack.add(ti);
    var hashObj = _makeHash(ti, node);
    var hash = node.hash = hashObj is String ? hashObj : sha256(hashObj);
    if (node.index == node.lowIndex) {
      late HashNode? n;
      do {
        n = _nodes[_stack.removeLast()]!;
        n.onStack = false;
        n.component = node.index;
        n.hash = '';
      } while (n != node);
      _cache[ti] = hash;
    } else {
      parent.lowIndex = min(parent.lowIndex, node.lowIndex);
    }
    return hash;
  }

  /// Returns `Map<String, dynamic>` or `String`
  dynamic _makeHash(int ti, HashNode parent) {
    var type = _types[ti];
    switch (type.kind) {
      case scale_codec.TypeKind.Primitive:
        return <String, String>{
          'primitive': (type as scale_codec.PrimitiveType).primitive.name
        };
      case scale_codec.TypeKind.Compact:
        return <String, String>{
          'compact': _hash((type as scale_codec.CompactType).type, parent)
        };
      case scale_codec.TypeKind.Sequence:
        return <String, String>{
          'sequence': _hash((type as scale_codec.SequenceType).type, parent)
        };
      case scale_codec.TypeKind.Array:
        return <String, dynamic>{
          'array': {
            'len': (type as scale_codec.ArrayType).length,
            'type': _hash(type.type, parent)
          }
        };
      case scale_codec.TypeKind.BitSequence:
        return <String, bool>{'bitSequence': true};
      case scale_codec.TypeKind.Tuple:
        return _hashTuple((type as scale_codec.TupleType).tuple, parent);
      case scale_codec.TypeKind.Composite:
        if ((type as scale_codec.CompositeType).fields.isEmpty ||
            type.fields[0].name == null) {
          return _hashTuple(
              type.fields.map((f) {
                scale_codec.assertionCheck(f.name == null);
                return f.type;
              }).toList(),
              parent);
        } else {
          var struct = <String, dynamic>{};
          for (var f in type.fields) {
            var name = assertNotNull(f.name);
            struct[name] = _hash(f.type, parent);
          }
          return {struct};
        }
      case scale_codec.TypeKind.Variant:
        {
          var desc = <String, dynamic>{};
          for (var v in (type as scale_codec.VariantType).variants) {
            for (var idx = 0; idx < v.fields.length; idx++) {
              var field = v.fields[idx];
              dynamic name = field.name ?? idx;
              desc[v.name] = <String, dynamic>{
                'name': name,
                'type': _hash(field.type, parent)
              };
            }
          }
          return <String, dynamic>{'variant': desc};
        }
      case scale_codec.TypeKind.Option:
        return <String, String>{
          'option': _hash((type as scale_codec.OptionType).type, parent)
        };
      case scale_codec.TypeKind.DoNotConstruct:
        return <String, dynamic>{'doNotConstruct': true};
      default:
        throw scale_codec.UnexpectedCaseException();
    }
  }

  /// Returns `Map<String, dynamic>` or `String`
  dynamic _hashTuple(List<int> items, HashNode parent) {
    if (items.length == 1) {
      return _hash(items[0], parent);
    } else {
      return {'tuple': items.map((it) => _hash(it, parent))};
    }
  }
}
