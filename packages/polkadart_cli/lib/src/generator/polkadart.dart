import 'package:code_builder/code_builder.dart'
    show
        refer,
        Block,
        declareFinal,
        Code,
        Class,
        Constructor,
        Parameter,
        Method,
        Field,
        FieldModifier,
        MethodModifier;
import 'package:path/path.dart' as p;
import 'package:substrate_metadata/substrate_metadata.dart' as m;
import './pallet.dart' show PalletGenerator;
import '../typegen/references.dart' as refs;
import '../typegen/typegen.dart' show GeneratedOutput;
import '../utils/utils.dart' show sanitize;

class PolkadartGenerator {
  String filePath;
  String name;
  List<PalletGenerator> pallets;
  m.RuntimeMetadataV14 metadata;

  PolkadartGenerator({
    required this.filePath,
    required this.name,
    required this.pallets,
    required this.metadata,
  });

  GeneratedOutput generate() {
    final queries = createPolkadartQueries();
    final constants = createPolkadartConstants();
    final rpc = createPolkadartRpc();
    final tx = createPolkadartTx();
    final registry = createPolkadartRegistry();
    final polkadart = createPolkadartClass();

    return GeneratedOutput(
      classes: [queries, tx, constants, rpc, registry, polkadart],
      enums: [],
      typedefs: [],
    );
  }

  Class createPolkadartRegistry() => Class(
        (classBuilder) {
          final String signedExtensionTypes =
              metadata.extrinsic.signedExtensions
                  .where((extension) {
                    final typeID = extension.type;
                    final typeDef = metadata.typeById(typeID).type.typeDef;
                    return (typeDef is m.TypeDefTuple &&
                            typeDef.fields.isNotEmpty) ||
                        (typeDef is m.TypeDefComposite &&
                            typeDef.fields.isNotEmpty) ||
                        (typeDef is! m.TypeDefComposite &&
                            typeDef is! m.TypeDefTuple);
                  })
                  .toList()
                  .map((extension) => "'${extension.identifier}'")
                  .toList()
                  .join(', ');

          final String signedExtensionExtra =
              metadata.extrinsic.signedExtensions
                  .where((extension) {
                    final typeID = extension.additionalSigned;
                    final typeDef = metadata.typeById(typeID).type.typeDef;
                    return (typeDef is m.TypeDefTuple &&
                            typeDef.fields.isNotEmpty) ||
                        (typeDef is m.TypeDefComposite &&
                            typeDef.fields.isNotEmpty) ||
                        (typeDef is! m.TypeDefComposite &&
                            typeDef is! m.TypeDefTuple);
                  })
                  .toList()
                  .map((extension) => "'${extension.identifier}'")
                  .toList()
                  .join(', ');

          // specVersion + transactionVersion + genesisHash + blockHash;

          classBuilder
            ..name = 'Registry'
            ..constructors.add(
              Constructor((b) => b..constant = false),
            )
            ..fields.addAll([
              Field((b) => b
                ..name = 'extrinsicVersion'
                ..type = refs.int
                ..modifier = FieldModifier.final$
                ..assignment = Code('${metadata.extrinsic.version}')),
            ])
            ..methods.addAll(
              [
                Method(
                  (b) => b
                    ..name = 'getSignedExtensionTypes'
                    ..returns = refs.list()
                    ..body = Block.of(
                        [refer('[$signedExtensionTypes]').returned.statement]),
                ),
                Method(
                  (b) => b
                    ..name = 'getSignedExtensionExtra'
                    ..returns = refs.list()
                    ..body = Block.of(
                        [refer('[$signedExtensionExtra]').returned.statement]),
                )
              ],
            );
        },
      );

  Class createPolkadartQueries() => Class(
        (classBuilder) {
          final dirname = p.dirname(filePath);
          classBuilder
            ..name = 'Queries'
            ..constructors.add(
              Constructor(
                (b) => b
                  ..constant = false
                  ..requiredParameters.add(
                    Parameter(
                      (b) => b
                        ..toThis = false
                        ..required = false
                        ..named = false
                        ..type = refs.stateApi
                        ..name = 'api',
                    ),
                  )
                  ..initializers.addAll(
                    pallets.where((pallet) => pallet.storages.isNotEmpty).map(
                          (pallet) => Code.scope((a) =>
                              '${sanitize(pallet.name)} = ${a(pallet.queries(dirname))}(api)'),
                        ),
                  ),
              ),
            )
            ..fields.addAll(
              pallets.where((pallet) => pallet.storages.isNotEmpty).map(
                    (pallet) => Field((b) => b
                      ..name = sanitize(pallet.name)
                      ..type = pallet.queries(dirname)
                      ..modifier = FieldModifier.final$),
                  ),
            );
        },
      );

  Class createPolkadartConstants() => Class(
        (classBuilder) {
          final dirname = p.dirname(filePath);
          classBuilder
            ..name = 'Constants'
            ..constructors.add(
              Constructor((b) => b..constant = false),
            )
            ..fields.addAll(
              pallets.where((pallet) => pallet.constants.isNotEmpty).map(
                    (pallet) => Field(
                      (b) => b
                        ..name = sanitize(pallet.name)
                        ..type = pallet.constantsType(dirname)
                        ..modifier = FieldModifier.final$
                        ..assignment =
                            pallet.constantsType(dirname).newInstance([]).code,
                    ),
                  ),
            );
        },
      );

  Class createPolkadartRpc() => Class(
        (classBuilder) {
          classBuilder
            ..name = 'Rpc'
            ..constructors.add(
              Constructor(
                (b) => b
                  ..constant = true
                  ..optionalParameters.addAll(
                    [
                      Parameter(
                        (b) => b
                          ..toThis = true
                          ..required = true
                          ..named = true
                          ..name = 'state',
                      ),
                      Parameter(
                        (b) => b
                          ..toThis = true
                          ..required = true
                          ..named = true
                          ..name = 'system',
                      )
                    ],
                  ),
              ),
            )
            ..fields.addAll(
              [
                Field((b) => b
                  ..name = 'state'
                  ..type = refs.stateApi
                  ..modifier = FieldModifier.final$),
                Field((b) => b
                  ..name = 'system'
                  ..type = refs.systemApi
                  ..modifier = FieldModifier.final$),
              ],
            );
        },
      );

  Class createPolkadartTx() => Class(
        (classBuilder) {
          final dirname = p.dirname(filePath);
          classBuilder
            ..name = 'Extrinsics'
            ..constructors.add(
              Constructor((b) => b..constant = false),
            )
            ..fields.addAll(
              pallets.where((pallet) => pallet.runtimeCall != null).map(
                    (pallet) => Field(
                      (b) => b
                        ..name = sanitize(pallet.name)
                        ..type = pallet.exts(dirname)
                        ..modifier = FieldModifier.final$
                        ..assignment =
                            pallet.exts(dirname).newInstance([]).code,
                    ),
                  ),
            );
        },
      );

  Class createPolkadartClass() => Class(
        (classBuilder) {
          classBuilder
            ..name = name
            ..constructors.addAll(
              [
                Constructor(
                  (b) => b
                    ..name = '_'
                    ..constant = false
                    ..requiredParameters.addAll(
                      [
                        Parameter((b) => b
                          ..toThis = true
                          ..required = false
                          ..named = false
                          ..name = '_provider'),
                        Parameter((b) => b
                          ..toThis = true
                          ..required = false
                          ..named = false
                          ..name = 'rpc'),
                      ],
                    )
                    ..initializers.addAll(
                      [
                        Code.scope((a) => 'query = Queries(rpc.state)'),
                        Code('constant = Constants()'),
                        Code('tx = Extrinsics()'),
                        Code('registry = Registry()'),
                      ],
                    ),
                ),
                Constructor(
                  (b) => b
                    ..factory = true
                    ..requiredParameters.addAll(
                      [
                        Parameter((b) => b
                          ..toThis = false
                          ..required = false
                          ..named = false
                          ..type = refs.provider
                          ..name = 'provider'),
                      ],
                    )
                    ..body = Block.of(
                      [
                        declareFinal('rpc')
                            .assign(
                              refer('Rpc').newInstance(
                                [],
                                {
                                  'state': refs.stateApi
                                      .newInstance([refer('provider')]),
                                  'system': refs.systemApi
                                      .newInstance([refer('provider')]),
                                },
                              ),
                            )
                            .statement,
                        refer(name)
                            .newInstanceNamed(
                                '_', [refer('provider'), refer('rpc')])
                            .returned
                            .statement,
                      ],
                    ),
                ),
                Constructor(
                  (b) => b
                    ..name = 'url'
                    ..constant = false
                    ..factory = true
                    ..requiredParameters.add(
                      Parameter((b) => b
                        ..toThis = false
                        ..required = false
                        ..named = false
                        ..type = refs.uri
                        ..name = 'url'),
                    )
                    ..body = Block.of(
                      [
                        declareFinal('provider')
                            .assign(refs.provider
                                .newInstanceNamed('fromUri', [refer('url')]))
                            .statement,
                        refer(name)
                            .newInstance([refer('provider')])
                            .returned
                            .statement,
                      ],
                    ),
                ),
              ],
            )
            ..fields.addAll(
              [
                Field((b) => b
                  ..name = '_provider'
                  ..type = refs.provider
                  ..modifier = FieldModifier.final$),
                Field((b) => b
                  ..name = 'query'
                  ..type = refer('Queries')
                  ..modifier = FieldModifier.final$),
                Field((b) => b
                  ..name = 'constant'
                  ..type = refer('Constants')
                  ..modifier = FieldModifier.final$),
                Field((b) => b
                  ..name = 'rpc'
                  ..type = refer('Rpc')
                  ..modifier = FieldModifier.final$),
                Field((b) => b
                  ..name = 'tx'
                  ..type = refer('Extrinsics')
                  ..modifier = FieldModifier.final$),
                Field((b) => b
                  ..name = 'registry'
                  ..type = refer('Registry')
                  ..modifier = FieldModifier.final$),
              ],
            )
            ..methods.addAll(
              [
                Method(
                  (b) => b
                    ..name = 'connect'
                    ..returns = refs.future()
                    ..modifier = MethodModifier.async
                    ..body = refer('_provider')
                        .property('connect')
                        .call([])
                        .awaited
                        .returned
                        .statement,
                ),
                Method(
                  (b) => b
                    ..name = 'disconnect'
                    ..returns = refs.future()
                    ..modifier = MethodModifier.async
                    ..body = refer('_provider')
                        .property('disconnect')
                        .call([])
                        .awaited
                        .returned
                        .statement,
                ),
              ],
            );
        },
      );
}
