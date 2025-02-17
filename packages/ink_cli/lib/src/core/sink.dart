part of ink_cli;

typedef AbiOutputCallBack = void Function(AbiOutput);

class Sink {
  /// The list of queued callbacks
  final List<AbiOutputCallBack> _queue = <AbiOutputCallBack>[];

  /// The set of assigned name
  final Set<String> _assignedNames = {};

  final List<CodecInterface> types;

  /// The name assignments
  final Map<int, String> nameAssignment;

  Sink(this.types, this.nameAssignment) {
    for (final String name in nameAssignment.values) {
      _assignedNames.add(name);
    }
  }

  /// push(cb): adds a callback to the queue
  void push(final AbiOutputCallBack cb) {
    _queue.add(cb);
  }

  /// getName(ti): returns the name assigned to a given type index.
  String getName(final int ti) {
    if (ti < 0 || ti >= types.length) {
      throw RangeError('Type index $ti is out of bounds');
    }
    final String? maybeName = nameAssignment[ti];
    if (maybeName == null) {
      throw StateError('No name assigned for type index $ti');
    }
    return maybeName;
  }

  /// hasName(ti): returns true if there's a name assignment for `ti`.
  bool hasName(final int ti) {
    return nameAssignment.containsKey(ti);
  }

  /// needsName(ti): returns the result of your external "needsName" function.
  bool needsName(final int ti) {
    return isNameNeeded(types, ti);
  }

  /// isEmpty(): returns true if the queue is empty
  bool isEmpty() {
    return _queue.isEmpty;
  }

  /// generate(out): drains the queue, calling each callback with `out`.
  void generate(final AbiOutput out) {
    while (_queue.isNotEmpty) {
      final AbiOutputCallBack cb = _queue.removeLast();
      cb(out);
    }
  }

  /// qualify(ns, exp): modifies occurrences of assigned names in `exp` by prefixing them with `ns.`
  String qualify(final String prefix, String expression) {
    final RegExp splitRegex = RegExp(r'[<>&|,()\[\]{}:]');
    final List<String> parts = expression.split(splitRegex);
    final Iterable<String> trimmedParts = parts.map((t) => t.trim()).where((t) => t.isNotEmpty);

    // Collect any parts that are known assigned names
    final Set<String> local = <String>{};
    for (final String part in trimmedParts) {
      if (_assignedNames.contains(part)) {
        local.add(part);
      }
    }

    // For each such name, replace word-boundary occurrences in `exp` with `ns.name`
    for (final String name in local) {
      // We escape the name in the regex, then match word boundaries
      final RegExp nameRegex = RegExp(r'\b' + RegExp.escape(name) + r'\b');
      expression = expression.replaceAll(nameRegex, '$prefix.$name');
    }

    return expression;
  }
}
