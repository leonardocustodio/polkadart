// dart_typegen.dart

part of ink_abi;

class DartTypegen {
  final String abiFilePath;
  final AbiOutput out;

  late Map<int, String> _nameAssignment;
  late InkAbiDescription _description;
  late Map<String, dynamic> _project;

  DartTypegen(this.abiFilePath, this.out);

  /// 1) Read the file and parse JSON
  dynamic _readMetadata() {
    final content = File(abiFilePath).readAsStringSync();
    return jsonDecode(content);
  }

  /// 2) Validate the ABI file into an InkProject
  Map<String, dynamic> _getProject() {
    final metadata = _readMetadata();
    return SchemaValidator.getInkProject(metadata);
  }

  /// 3) Create InkAbiDescription from the validated project
  InkAbiDescription _getDescription() {
    return InkAbiDescription(_project);
  }

  /// 4) Build name assignments using `Names`
  Map<int, String> _buildNameAssignment() {
    final names = Names(_description.types());

    // Reserve certain names
    names.reserve('metadata');

    // Set known custom names, e.g. for event, messages, constructors
    names.assign(_description.event(), 'Event');
    names.assign(_description.messages(), 'Message');
    names.assign(_description.constructors(), 'Constructor');

    // Possibly alias event argument types, etc.
    void addArgAlias(Map<String, dynamic> arg) {
      final typeSpec = arg['type'];
      if (typeSpec?['displayName'] is List &&
          typeSpec['displayName'].isNotEmpty) {
        final displayList = List<String>.from(typeSpec['displayName']);
        final aliasName = displayList.last;
        names.alias(typeSpec['type'], aliasName);
      }
    }

    for (final event in _project['spec']['events']) {
      for (final arg in event['args']) {
        addArgAlias(arg);
      }
    }
    for (final msg in _project['spec']['messages']) {
      for (final arg in msg['args']) {
        addArgAlias(arg);
      }
    }
    for (final constructor in _project['spec']['constructors']) {
      for (final arg in constructor['args']) {
        addArgAlias(arg);
      }
    }

    return names.getAssignment();
  }

  /// The main entrypoint to trigger generation.
  void generate() {
    // 1) Build the project & description
    _project = _getProject();
    _description = _getDescription();

    // 2) Acquire the normalized type list
    final List<CodecInterface> types = _description.types();

    // 3) Build name assignments and create a sink
    _nameAssignment = _buildNameAssignment();
    final sink = Sink(types, _nameAssignment);

    // 4) Create an Interfaces helper to produce type expressions
    final ifs = Interfaces(sink);

    // 5) Start writing code to `out`
    // For example, we might print some imports:
    out.line("import 'package:ink_abi/ink_abi_base.dart';");
    out.line("import 'package:polkadart/polkadart.dart' show StateApi;");
    out.line("import 'dart:typed_data';");
    out.line("import 'dart:convert';");
    out.line();

    // Then, we might embed the original ABI JSON
    final metadata = JsonEncoder.withIndent('    ').convert(_readMetadata());
    out.block(
      start: 'const String metadataJson = r\'\'\'',
      cb: () {
        for (final line in metadata.split('\n')) {
          out.line(line);
        }
      },
      end: "''' ;",
    );

    out.line();
    out.block(
      start: 'final InkAbi _abi = InkAbi(jsonDecode(metadataJson));',
      cb: null,
      end: null,
    );

    // Suppose we want to replicate the decodeEvent function, etc.:
    out.line();
    if (_project['version'] == 5) {
      out.block(
        start:
            'dynamic decodeEvent(final String hex, [final List<String>? topics]) {',
        cb: () {
          /* final eventType = ifs.use(_description.event());
          out.line('final $eventType event = _abi.decodeEvent(hex, topics);'); */
          out.line('return _abi.decodeEvent(hex, topics);');
        },
        end: '}',
      );
    } else {
      out.block(
        start: 'dynamic decodeEvent(final String hex) {',
        cb: () {
          /* final eventType = ifs.use(_description.event());
          out.line('final $eventType event = _abi.decodeEvent(hex);'); */
          out.line('return _abi.decodeEvent(hex);');
        },
        end: '}',
      );
    }

    out.line();
    out.block(
      start: 'dynamic decodeMessage(final String hex) {',
      cb: () {
        /* final msgType = ifs.use(_description.messages());
        out.line('final $msgType msg = _abi.decodeMessage(hex);'); */
        out.line('return _abi.decodeMessage(hex);');
      },
      end: '}',
    );

    out.line();
    out.block(
      start: 'dynamic decodeConstructor(final String hex) {',
      cb: () {
        /* final ctorType = ifs.use(_description.constructors());
        out.line('final $ctorType cons = _abi.decodeConstructor(hex);'); */
        out.line('return _abi.decodeConstructor(hex);');
      },
      end: '}',
    );

    out.line();
    out.block(
      start: 'class Contract {',
      cb: () {
        out.line('final StateApi api;');
        out.line('final Uint8List address;');
        out.line('final Uint8List? blockHash;');
        out.line();
        out.block(
          start:
              'Contract({required this.api, required this.address, this.blockHash});',
          cb: () {},
          end: '',
        );

        // For each message that doesn't mutate, create a method
        final messages = _project['spec']['messages'] as List;
        for (final m in messages) {
          if (m['mutates'] == false) {
            // build signature
            final args = (m['args'] as List)
                .map((arg) =>
                    'final ${ifs.use(arg['type']['type'])} ${arg['label']}')
                .join(', ');
            final returnType = m['returnType']?['type'];
            if (returnType == null) {
              continue;
            }

            final methodName = (m['label'] as String).replaceAll('::', '_');
            out.line();
            // Add docs
            final docs = (m['docs'] as List).cast<String>();
            out.blockComment(docs);
            out.block(
              start:
                  'Future<${ifs.use(returnType)}> $methodName($args) async {',
              cb: () {
                final callArgs =
                    (m['args'] as List).map((arg) => arg['label']).join(', ');
                out.line(
                    "return await _stateCall<${ifs.use(returnType)}>('${m['selector']}', [$callArgs]);");
              },
              end: '}',
            );
          }
        }

        // The private helper method
        out.line();
        out.block(
          start:
              'Future<T> _stateCall<T>(final String selector, final List<dynamic> args) async {',
          cb: () {
            out.line('final input = _abi.encodeMessageInput(selector, args);');
            out.line('final data = encodeCall(address, input);');
            out.line(
                'final result = await api.call(\'ContractsApi_call\', data, at: blockHash);');
            out.line(' final value = decodeResult(result);');
            out.line('return _abi.decodeMessageOutput(selector, value);');
          },
          end: '}',
        );
      },
      end: '}',
    );

    // 6) Finally, "drain" the sink so that all queued definitions (interfaces, etc.) are printed
    sink.generate(out);
    return;

    /* out.line();
    out.block(
      start: 'class Result<T, E> {',
      cb: () {
        out.line('final bool isOk;');
        out.line('final T? ok;');
        out.line('final E? err;');
        out.line();
        out.block(
          start: 'Result.ok(this.ok) : isOk = true, err = null;',
          cb: () {},
          end: '',
        );
        out.block(
          start: 'Result.err(this.err) : isOk = false, ok = null;',
          cb: () {},
          end: '',
        );
      },
      end: '}',
    ); */
  }
}
