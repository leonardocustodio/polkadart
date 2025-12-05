part of ink_cli;

typedef Ni = int;
typedef Hash = String;

abstract class HasherAbstract {
  Hash getHash(Ni nodeIndex);
}

class HashNode {
  final int index;
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

typedef HashNodeCallback<T> = Function(
  List<T> graph,
  DCGHasher<T> hasher,
  T type,
);

///
/// This class is a direct counterpart of the DCGHasher.
///
/// The Tarjan-based algorithm is embedded for hashing strongly connected
/// components. We store partial results in a cache, so repeated traversals
/// do not redo the entire DFS for strongly connected subgraphs.
class DCGHasher<T> implements HasherAbstract {
  /// A cache of hashes, to avoid recomputation.
  final List<String> cache;

  /// "index" used by Tarjan's algorithm.
  int index = 1;

  /// The "nodes" array to store Tarjan info, parallel to the graph.
  final List<HashNode?> nodes;

  /// The stack for Tarjan's algorithm.
  final List<int> stack = <int>[];

  /// The parent node pointer used to track Tarjan context in the traversal.
  HashNode? parentNode;

  final List<T> graph;

  final HashNodeCallback<T> computeHash;

  DCGHasher(this.graph, this.computeHash)
      : cache = List.filled(graph.length, ''),
        nodes = List.filled(graph.length, null);

  @override
  Hash getHash(final Ni ni) {
    // Equivalent to: assert(0 <= ni && ni < graph.length)
    assert(0 <= ni && ni < graph.length,
        'Index $ni is out of bounds for graph of length ${graph.length}');

    if (parentNode == null) {
      // Outside of any current recursion
      final existingHash = cache[ni];
      if (existingHash.isNotEmpty) {
        // We already know this hash
        return existingHash;
      }
      return _traverse(ni);
    } else {
      // Called during recursion
      return _visit(ni);
    }
  }

  /// Equivalent to private traverse(ni: Ni): Hash
  Hash _traverse(final Ni ni) {
    parentNode = HashNode(
      index: 0,
      lowIndex: 0,
      onStack: false,
      hash: '',
      component: 0,
    );
    try {
      return _visit(ni);
    } finally {
      parentNode = null; // ensure cleanup
    }
  }

  /// Equivalent to private visit(ni: Ni): Hash
  Hash _visit(final Ni ni) {
    final parent = parentNode;
    if (parent == null) {
      throw StateError('parentNode was unexpectedly null');
    }

    HashNode? node = nodes[ni];
    if (node != null) {
      // We have visited this node before, so we might be in the same recursion
      // or a previous one
      if (node.onStack) {
        // This must be the same recursion (a cycle discovered)
        parent.lowIndex = _min(parent.lowIndex, node.index);
        return node.hash;
      }
      if (node.hash.isNotEmpty) {
        // This node already has a hash set (and onStack = false),
        // so it's in the same component as the parent
        return node.hash;
      }
      // Means we discovered it in a previous traversal; check component
      assert(node.component != null, 'Node has no component set but was visited before.');
      if (node.component != parent.component) {
        // We are entering a strongly connected component. Return cached hash if available
        final existingHash = cache[ni];
        if (existingHash.isNotEmpty) {
          return existingHash;
        }
      }
    }
    // If none of these conditions matched, we proceed with normal Tarjan visit

    node = HashNode(
      index: index,
      lowIndex: index,
      onStack: true,
      hash: '',
      component: node?.component,
    );
    index += 1;
    nodes[ni] = node;
    stack.add(ni);

    // Compute the user-supplied merkelObj
    Map<String, dynamic> merkelObj;
    parentNode = node;
    try {
      merkelObj = computeHash(graph, this, graph[ni]);
    } finally {
      parentNode = parent;
    }

    final hashed = sha(merkelObj);

    // Tarjan check for strongly connected component root
    if (node.index == node.lowIndex) {
      // We found an SCC root, unwind the stack
      HashNode n;
      do {
        final int idx = stack.removeLast();
        n = nodes[idx]!;
        n.onStack = false;
        n.component = node.index;
        n.hash = '';
      } while (n != node);

      // Update the cache for this node index
      cache[ni] = hashed;
    } else {
      // Propagate the low link up
      parent.lowIndex = _min(parent.lowIndex, node.lowIndex);
    }

    return hashed;
  }

  int _min(int a, int b) => (a < b) ? a : b;
}

/// Equivalent to export function sha(obj: object): Hash
/// By default, sha256 will yield a 64-character hex.
Hash sha(final Map<String, dynamic> obj) {
  final content = jsonEncode(obj);
  final digest = sha256.convert(utf8.encode(content));
  final fullHex = digest.bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return fullHex.substring(0, 32);
}
