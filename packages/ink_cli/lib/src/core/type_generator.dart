part of ink_cli;

class TypeGenerator {
  final String abiFilePath;
  final AbiOutput fileOutput;

  late final Map<int, String> _nameAssignment;
  late final InkAbiDescription _description;
  late final Map<String, dynamic> _project;

  TypeGenerator({
    required this.abiFilePath,
    required this.fileOutput,
  });

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
    names.reserve('bool');
    names.reserve('String');
    names.reserve('double');
    names.reserve('int');
    names.reserve('List');

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
    fileOutput.line("// ignore_for_file: non_constant_identifier_names");
    fileOutput.line();
    fileOutput
        .line("import 'package:polkadart_keyring/polkadart_keyring.dart';");
    fileOutput.line("import 'package:ink_abi/ink_abi_base.dart';");
    fileOutput.line("import 'package:ink_cli/ink_cli.dart';");
    fileOutput.line("import 'package:polkadart/polkadart.dart';");
    fileOutput.line("import 'dart:typed_data';");
    fileOutput.line("import 'dart:convert';");
    fileOutput.line();

    // Then, we might embed the original ABI JSON
    final metadata = JsonEncoder.withIndent('    ').convert(_readMetadata());
    fileOutput.block(
      start: "final _metadataJson = ",
      cb: () {
        for (final line in metadata.split('\n')) {
          fileOutput.line(line);
        }
      },
      end: ";",
    );

    fileOutput.line();
    fileOutput.block(
      start: 'final InkAbi _abi = InkAbi(_metadataJson);',
      cb: null,
      end: null,
    );

    // Suppose we want to replicate the decodeEvent function, etc.:
    fileOutput.line();
    if (_project['version'] == 5) {
      fileOutput.block(
        start:
            'dynamic decodeEvent(final String hex, [final List<String>? topics]) {',
        cb: () {
          /* final eventType = ifs.use(_description.event());
          out.line('final $eventType event = _abi.decodeEvent(hex, topics);'); */
          fileOutput.line('return _abi.decodeEvent(hex, topics);');
        },
        end: '}',
      );
    } else {
      fileOutput.block(
        start: 'dynamic decodeEvent(final String hex) {',
        cb: () {
          /* final eventType = ifs.use(_description.event());
          out.line('final $eventType event = _abi.decodeEvent(hex);'); */
          fileOutput.line('return _abi.decodeEvent(hex);');
        },
        end: '}',
      );
    }

    fileOutput.line();
    fileOutput.block(
      start: 'dynamic decodeMessage(final String hex) {',
      cb: () {
        /* final msgType = ifs.use(_description.messages());
        out.line('final $msgType msg = _abi.decodeMessage(hex);'); */
        fileOutput.line('return _abi.decodeMessage(hex);');
      },
      end: '}',
    );

    fileOutput.line();
    fileOutput.block(
      start: 'dynamic decodeConstructor(final String hex) {',
      cb: () {
        /* final ctorType = ifs.use(_description.constructors());
        out.line('final $ctorType cons = _abi.decodeConstructor(hex);'); */
        fileOutput.line('return _abi.decodeConstructor(hex);');
      },
      end: '}',
    );

    fileOutput.line();
    fileOutput.block(
      start: 'class Contract {',
      cb: () {
        fileOutput.line('final Provider provider;');
        fileOutput.line('final Uint8List address;');
        fileOutput.line('final Uint8List? blockHash;');
        fileOutput.line();
        fileOutput.block(
          start: 'const Contract({',
          cb: () {
            fileOutput.line('required this.provider,');
            fileOutput.line('required this.address,');
            fileOutput.line('this.blockHash,');
          },
          end: '});',
        );

        // For each message that doesn't mutate, create a method
        final constructors = _project['spec']['constructors'] as List;
        for (final m in constructors) {
          // build signature
          final args = (m['args'] as List)
              .map((arg) =>
                  'required final ${ifs.use(arg['type']['type'])} ${arg['label']}')
              .toList();
          final returnType = m['returnType']?['type'];
          if (returnType == null) {
            continue;
          }

          final methodName = (m['label'] as String).replaceAll('::', '_');
          args.addAll(
            <String>[
              'required final Uint8List code',
              'required final KeyPair keyPair',
              'final Map<String, dynamic> extraOptions = const <String, dynamic>{}',
              'final BigInt? storageDepositLimit',
              'final Uint8List? salt',
              'final GasLimit? gasLimit',
              'final dynamic tip = 0',
              'final int eraPeriod = 0',
            ],
          );

          fileOutput.line();
          // Add docs
          final docs = (m['docs'] as List).cast<String>();
          fileOutput.blockComment(docs);
          fileOutput.block(
            start: 'Future<InstantiateRequest> ${methodName}_contract({',
            cb: () {
              for (final String arg in args) {
                fileOutput.line('$arg,');
              }
            },
            end: null,
          );

          fileOutput.block(
            start: '}) async {',
            cb: () {
              fileOutput.line(
                  'final deployer = await ContractDeployer.from(provider: provider);');

              fileOutput.block(
                start: 'return await deployer.deployContract(',
                cb: () {
                  fileOutput.line('inkAbi: _abi,');
                  fileOutput.line("selector: '${m['selector']}',");
                  fileOutput.line('code: code,');
                  fileOutput.line('keypair: keyPair,');
                  fileOutput.line('extraOptions: extraOptions,');
                  fileOutput.line('storageDepositLimit: storageDepositLimit,');
                  fileOutput.line('salt: salt,');
                  fileOutput.line('gasLimit: gasLimit,');
                  fileOutput.line('tip: tip,');
                  fileOutput.line('eraPeriod: eraPeriod,');
                  final callArgs =
                      (m['args'] as List).map((arg) => arg['label']).join(', ');
                  fileOutput.line("constructorArgs: [$callArgs],");
                },
                end: ');',
              );
            },
            end: '}',
          );
        }

        // For each message that doesn't mutate, create a method
        final messages = _project['spec']['messages'] as List;
        for (final m in messages) {
          // build signature
          final args = (m['args'] as List)
              .map((arg) =>
                  'final ${ifs.use(arg['type']['type'])} ${arg['label']}')
              .join(', ');
          //final returnType = m['returnType']?['type'];
          /* if (returnType == null) {
              continue;
            } */

          final methodName = (m['label'] as String).replaceAll('::', '_');
          fileOutput.line();
          // Add docs
          final docs = (m['docs'] as List).cast<String>();
          fileOutput.blockComment(docs);
          fileOutput.block(
            // Investigate it when optimizing polkadart_scale_codec: ${returnType == null ? 'dynamic' : ifs.use(returnType)}
            start: 'Future<dynamic> $methodName($args) async {',
            cb: () {
              final callArgs =
                  (m['args'] as List).map((arg) => arg['label']).join(', ');
              // /* Investigate it when optimizing polkadart_scale_codec: <${returnType == null ? 'dynamic' : ifs.use(returnType)}> */
              fileOutput
                  .line("return _stateCall('${m['selector']}', [$callArgs]);");
            },
            end: '}',
          );
        }

        // The private helper method
        fileOutput.line();
        fileOutput.block(
          start:
              'Future<dynamic> _stateCall(final String selector, final List<dynamic> args) async {',
          cb: () {
            fileOutput
                .line('final input = _abi.encodeMessageInput(selector, args);');
            fileOutput.line('final data = encodeCall(address, input);');
            fileOutput.line('final api = StateApi(provider);');
            fileOutput.line(
                'final result = await api.call(\'ContractsApi_call\', data, at: blockHash);');
            fileOutput.line('final decodedResult = decodeResult(result);');
            fileOutput.line(
                'return _abi.decodeMessageOutput(selector, decodedResult);');
          },
          end: '}',
        );
      },
      end: '}',
    );

    // 6) Finally, "drain" the sink so that all queued definitions (interfaces, etc.) are printed
    sink.generate(fileOutput);
    return;
  }
}
