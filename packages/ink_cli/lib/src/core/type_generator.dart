part of ink_cli;

class TypeGenerator {
  final String abiFilePath;
  final AbiOutput fileOutput;

  late final Map<int, String> _nameAssignment;
  late final InkAbi _inkAbi;
  late final Map<String, dynamic> _rawMetadata;
  late final List<CodecInterface> _types;

  TypeGenerator({required this.abiFilePath, required this.fileOutput});

  /// 1) Read the file and parse JSON
  dynamic _readMetadata() {
    final content = File(abiFilePath).readAsStringSync();
    return jsonDecode(content);
  }

  /// 2) Create InkAbi from the metadata JSON (validates schema internally)
  InkAbi _getInkAbi() {
    return InkAbi(_rawMetadata);
  }

  /// 3) Convert PortableTypes from registry to CodecInterface list
  List<CodecInterface> _buildCodecInterfaceList() {
    final List<CodecInterface> interfaces = <CodecInterface>[];
    for (final portableType in _inkAbi.registry.types) {
      try {
        final codecInterface = _convertPortableTypeToCodecInterface(portableType);
        interfaces.add(codecInterface);
      } catch (e) {
        // If conversion fails, add a placeholder to maintain index alignment
        interfaces.add(
          PrimitiveCodecInterface(
            path: portableType.type.path,
            primitive: Primitive.U8, // Default placeholder
          ),
        );
      }
    }

    return interfaces;
  }

  /// Convert a single PortableType to CodecInterface
  CodecInterface _convertPortableTypeToCodecInterface(PortableType portableType) {
    final TypeDef typeDef = portableType.type.typeDef;
    final List<String> pathList = portableType.type.path;
    final List<String> docs = portableType.type.docs;

    return switch (typeDef) {
      TypeDefPrimitive() => PrimitiveCodecInterface(
        path: pathList,
        docs: docs,
        primitive: _convertPrimitiveFromTypeDef(typeDef),
      ),
      TypeDefComposite() => CompositeCodecInterface(
        path: pathList,
        docs: docs,
        fields: getFields(typeDef.fields),
      ),
      TypeDefVariant() => VariantCodecInterface(
        path: pathList,
        docs: docs,
        variants: typeDef.variants
            .map(
              (final variant) => Variants(
                name: variant.name,
                fields: getFields(variant.fields),
                index: variant.index,
                docs: variant.docs,
              ),
            )
            .toList(),
      ),
      TypeDefSequence() => SequenceCodecInterface(path: pathList, docs: docs, type: typeDef.type),
      TypeDefArray() => ArrayCodecInterface(
        path: pathList,
        docs: docs,
        len: typeDef.length,
        type: typeDef.type,
      ),
      TypeDefTuple() => TupleCodecInterface(path: pathList, docs: docs, tuple: typeDef.fields),
      TypeDefCompact() => CompactCodecInterface(path: pathList, docs: docs, type: typeDef.type),
      TypeDefBitSequence() => BitSequenceCodecInterface(
        path: pathList,
        docs: docs,
        bitStoreType: typeDef.bitStoreType,
        bitOrderType: typeDef.bitOrderType,
      ),
    };
  }

  List<Field> getFields(final List<substrate_metadata.Field> fields) {
    return fields
        .map(
          (final field) =>
              Field(name: field.name, type: field.type, typeName: field.typeName, docs: field.docs),
        )
        .toList();
  }

  /// Convert TypeDefPrimitive to local Primitive enum
  ///
  /// Maps substrate_metadata's Primitive enum to the local Primitive enum
  /// using name-based lookup to avoid naming conflicts.
  Primitive _convertPrimitiveFromTypeDef(TypeDefPrimitive typeDef) {
    // Get the primitive name as string (e.g., "I8", "U8", "Bool", etc.)
    final primitiveName = typeDef.primitive.name;
    // Look up the corresponding local Primitive enum value by name
    return Primitive.values.firstWhere(
      (p) => p.name == primitiveName,
      orElse: () => throw StateError('Unknown primitive type: $primitiveName'),
    );
  }

  /// 4) Build name assignments using `Names`
  Map<int, String> _buildNameAssignment() {
    final names = Names(_types);

    // Reserve certain names
    names.reserve('metadata');
    names.reserve('bool');
    names.reserve('String');
    names.reserve('double');
    names.reserve('int');
    names.reserve('List');

    // Set known custom names for messages and constructors type indices
    names.assign(_inkAbi.messagesIndex, 'Message');
    names.assign(_inkAbi.constructorsIndex, 'Constructor');

    // Possibly alias argument types using display names
    void addArgAlias(ArgSpec arg) {
      final displayName = arg.type.displayName;
      if (displayName.isNotEmpty) {
        final aliasName = displayName.last;
        names.alias(arg.type.typeId, aliasName);
      }
    }

    // Note: EventSpec doesn't expose args directly - event types are composite
    // types created from the event's args and stored by typeId in the registry.
    // We skip event alias iteration here since the type IDs are already registered.

    // Add aliases from messages
    for (final message in _inkAbi.messages) {
      for (final arg in message.args) {
        addArgAlias(arg);
      }
    }

    // Add aliases from constructors
    for (final constructor in _inkAbi.constructors) {
      for (final arg in constructor.args) {
        addArgAlias(arg);
      }
    }

    return names.getAssignment();
  }

  /// The main entrypoint to trigger generation.
  void generate() {
    // 1) Read and validate metadata
    _rawMetadata = _readMetadata();
    _inkAbi = _getInkAbi();

    // 2) Build CodecInterface list from portable types
    _types = _buildCodecInterfaceList();

    // 3) Build name assignments using Names helper
    _nameAssignment = _buildNameAssignment();

    // 4) Create Sink and Interfaces for type generation
    final sink = Sink(_types, _nameAssignment);
    // ignore: unused_local_variable
    final ifs = Interfaces(sink); // Used for type expressions in args (future enhancement)

    // 5) Start writing code to `out`
    // For example, we might print some imports:
    fileOutput.line("// ignore_for_file: non_constant_identifier_names");
    fileOutput.line();
    fileOutput.line("import 'package:polkadart_keyring/polkadart_keyring.dart';");
    fileOutput.line("import 'package:ink_abi/ink_abi.dart';");
    fileOutput.line("import 'package:ink_cli/ink_cli.dart';");
    fileOutput.line("import 'package:polkadart/polkadart.dart';");
    fileOutput.line("import 'dart:typed_data';");
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
    fileOutput.block(start: 'final InkAbi _abi = InkAbi(_metadataJson);', cb: null, end: null);

    // Generate decode functions that delegate to InkAbi
    fileOutput.line();
    if (_inkAbi.version == 5) {
      fileOutput.block(
        start: 'dynamic decodeEvent(final String hex, [final List<String>? topics]) {',
        cb: () {
          fileOutput.line('return _abi.decodeEvent(hex, topics);');
        },
        end: '}',
      );
    } else {
      fileOutput.block(
        start: 'dynamic decodeEvent(final String hex) {',
        cb: () {
          fileOutput.line('return _abi.decodeEvent(hex);');
        },
        end: '}',
      );
    }

    fileOutput.line();
    fileOutput.block(
      start: 'dynamic decodeMessage(final String hex) {',
      cb: () {
        fileOutput.line('return _abi.decodeMessage(hex);');
      },
      end: '}',
    );

    fileOutput.line();
    fileOutput.block(
      start: 'dynamic decodeConstructor(final String hex) {',
      cb: () {
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
        fileOutput.line('final Uint8List contractAddress;');
        fileOutput.line('final Uint8List? blockHash;');
        fileOutput.line();
        fileOutput.block(
          start: 'const Contract({',
          cb: () {
            fileOutput.line('required this.provider,');
            fileOutput.line('required this.contractAddress,');
            fileOutput.line('required this.address,');
            fileOutput.line('this.blockHash,');
          },
          end: '});',
        );

        // For each constructor, create a deployment method
        for (final ConstructorSpec constructor in _inkAbi.constructors) {
          // Build signature with proper type resolution via Interfaces.use()
          final args = constructor.args
              .map((ArgSpec arg) => 'required final ${ifs.use(arg.type.typeId)} ${arg.label}')
              .toList();

          if (constructor.returnType == null) {
            continue;
          }

          final methodName = constructor.label.replaceAll('::', '_');
          args.addAll(<String>[
            'required final Uint8List code',
            'required final KeyPair keyPair',
            'required final ContractDeployer deployer',
            'final Map<String, dynamic> extraOptions = const <String, dynamic>{}',
            'final BigInt? storageDepositLimit',
            'final Uint8List? salt',
            'final GasLimit? gasLimit',
            'final dynamic tip = 0',
            'final int eraPeriod = 0',
          ]);

          fileOutput.line();
          // Add docs
          if (constructor.docs != null && constructor.docs!.isNotEmpty) {
            fileOutput.blockComment(constructor.docs!);
          }
          fileOutput.block(
            start: 'static Future<InstantiateRequest> ${methodName}_contract({',
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
              fileOutput.block(
                start: 'return await deployer.deployContract(',
                cb: () {
                  fileOutput.line('inkAbi: _abi,');
                  fileOutput.line("selector: '${constructor.selector}',");
                  fileOutput.line('code: code,');
                  fileOutput.line('keypair: keyPair,');
                  fileOutput.line('extraOptions: extraOptions,');
                  fileOutput.line('storageDepositLimit: storageDepositLimit,');
                  fileOutput.line('salt: salt,');
                  fileOutput.line('gasLimit: gasLimit,');
                  fileOutput.line('tip: tip,');
                  fileOutput.line('eraPeriod: eraPeriod,');
                  final callArgs = constructor.args.map((arg) => arg.label).join(', ');
                  fileOutput.line("constructorArgs: [$callArgs],");
                },
                end: ');',
              );
            },
            end: '}',
          );
        }

        // For each message, create a method
        for (final MessageSpec message in _inkAbi.messages) {
          // Build signature with proper type resolution via Interfaces.use()
          List<String> argsList = <String>[];
          if (message.mutates) {
            argsList = <String>[
              'required final KeyPair keyPair',
              'required final ContractMutator mutator',
              'BigInt? storageDepositLimit',
              'GasLimit? gasLimit',
              'final dynamic tip = 0',
              'final int eraPeriod = 0',
            ];
          }
          argsList.addAll(
            message.args
                .map((ArgSpec arg) => 'required final ${ifs.use(arg.type.typeId)} ${arg.label}')
                .toList(),
          );

          String args = argsList.join(', ');
          if (args.isNotEmpty) {
            args = '{$args}';
          }

          final methodName = message.label.replaceAll('::', '_');
          fileOutput.line();
          // Add docs
          if (message.docs != null && message.docs!.isNotEmpty) {
            fileOutput.blockComment(message.docs!);
          }
          fileOutput.block(
            start: 'Future<dynamic> $methodName($args) async {',
            cb: () {
              final callArgs = message.args.map((arg) => arg.label).join(', ');

              if (message.mutates == false) {
                fileOutput.line("return _stateCall('${message.selector}', [$callArgs]);");
              } else {
                fileOutput.line('''
                return _contractCall(
                  selector: '${message.selector}',
                  keypair: keyPair,
                  args: [$callArgs],
                  mutator: mutator,
                  storageDepositLimit: storageDepositLimit,
                  gasLimit: gasLimit,
                  tip: tip,
                  eraPeriod: eraPeriod,
                );''');
              }
            },
            end: '}',
          );
        }

        // Create a `_contractCall` method
        fileOutput.line();
        fileOutput.block(
          start: '''Future<dynamic> _contractCall({
                required final String selector,
                required final KeyPair keypair,
                required final List<dynamic> args,
                required final ContractMutator mutator,
                BigInt? storageDepositLimit,
                GasLimit? gasLimit,
                final dynamic tip = 0,
                final int eraPeriod = 0,
              }) async {''',
          cb: () {
            fileOutput.line('final input = _abi.encodeMessageInput(selector, args);');
            fileOutput.line('final result = await _baseCall(input, args);');
            fileOutput.line('''final value = await mutator.mutate(
                keypair: keypair,
                input: input,
                result: result,
                contractAddress: contractAddress,
                storageDepositLimit: storageDepositLimit,
                gasLimit: gasLimit,
                tip: tip,
                eraPeriod: eraPeriod,
              );''');
            fileOutput.line('return value;');
          },
          end: '}',
        );

        // Create a `_stateCall` method
        fileOutput.line();
        fileOutput.block(
          start:
              'Future<dynamic> _stateCall(final String selector, final List<dynamic> args,) async {',
          cb: () {
            fileOutput.line('final input = _abi.encodeMessageInput(selector, args);');
            fileOutput.line('final baseResult = await _baseCall(input, args);');
            fileOutput.line('final decodedResult = decodeResult(baseResult);');
            fileOutput.line('return _abi.decodeMessageOutput(selector, decodedResult);');
          },
          end: '}',
        );

        // Create a `_baseCall` method
        fileOutput.line();
        fileOutput.block(
          start:
              'Future<Uint8List> _baseCall(final Uint8List input, final List<dynamic> args) async {',
          cb: () {
            fileOutput.line('final data = encodeCall(address, input, contractAddress);');
            fileOutput.line('final api = StateApi(provider);');
            fileOutput.line(
              'final result = await api.call(\'ContractsApi_call\', data, at: blockHash);',
            );
            fileOutput.line('return result;');
          },
          end: '}',
        );
      },
      end: '}',
    );

    // 6) Generate type definitions from queued callbacks
    sink.generate(fileOutput);
  }
}
