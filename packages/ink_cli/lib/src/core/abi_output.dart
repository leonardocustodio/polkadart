part of ink_cli;

typedef VoidCallback = void Function();

class LazyLine {
  final String indent;
  final VoidCallback gen;

  const LazyLine({
    required this.indent,
    required this.gen,
  });
}

class FileOutput extends AbiOutput {
  final String file;

  FileOutput(this.file);

  void write() {
    File(file)
      ..createSync(recursive: true)
      ..writeAsStringSync(toString());
  }
}

typedef Line = Object; // Line can be String or LazyLine

class AbiOutput {
  final List<Line> _lines = [];
  String _indent = '';

  void line([final String? s]) {
    if (s != null) {
      _lines.add('$_indent$s');
    } else {
      _lines.add('');
    }
  }

  void block({
    required final String start,
    required final VoidCallback? cb,
    required final String? end,
  }) {
    line(start);
    if (cb != null) {
      indentation(cb);
    }
    if (end != null) {
      line(end);
    }
  }

  void indentation(final VoidCallback cb) {
    _indent += '  ';
    try {
      cb();
    } finally {
      _indent = _indent.substring(0, _indent.length - 2);
    }
  }

  void blockComment(final List<String>? lines) {
    if (lines == null || lines.isEmpty) {
      return;
    }
    line('///');
    for (final String l in lines) {
      line('///${_escapeBlockComment(l)}');
    }
  }

  void lazy(final VoidCallback gen) {
    _lines.add(LazyLine(indent: _indent, gen: gen));
  }

  @override
  String toString() {
    return _printLines(_lines, '', '');
  }

  String _printLines(final List<Line> lines, final String indent, String out) {
    for (final line in lines) {
      if (line is String) {
        out += '$indent$line\n';
      } else if (line is LazyLine) {
        out = _printLazyLine(line, indent, out);
      }
    }
    return out;
  }

  String _printLazyLine(final LazyLine line, final String indent, String out) {
    final currentLines = List<Line>.from(_lines);
    _lines.clear();
    try {
      line.gen();
      out = _printLines(_lines, indent + line.indent, out);
    } finally {
      _lines
        ..clear()
        ..addAll(currentLines);
    }
    return out;
  }

  String _escapeBlockComment(final String line) {
    return line.replaceAll('//', '///');
  }
}
