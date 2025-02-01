// ignore_for_file: non_constant_identifier_names
import 'package:polkadart/apis/apis.dart';
import 'package:polkadart/polkadart.dart' show Provider, StateApi;
import 'package:substrate_metadata/substrate_metadata.dart';

Future<void> main(List<String> arguments) async {
  final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
  final state = StateApi(provider);
  final runtimeMetadata = (await state.getMetadata()).metadata;

  // Let's use the runtime metadata to check how an extrinsic looks like
  final callType =
      runtimeMetadata.pallets[6].calls; // Pallet 6 = Balances pallet
  final callTypeDef =
      runtimeMetadata.typeById(callType!.type).type.typeDef as TypeDefVariant;
  final variants =
      Map<String, Variant>.fromEntries(callTypeDef.variants.map((variant) {
    print('Balance call #${variant.index}: ${variant.name}');
    return MapEntry(variant.name, variant);
  }));

  final transferAll = variants['transfer_all']!;
  print('Let\'s check the fields of the transfer_all variant');
  transferAll.fields.forEach((field) {
    print('Field of the extrinsic: ${field.name} - ${field.typeName}');
    print('The field is of type ${runtimeMetadata.typeById(field.type).type.typeDef.runtimeType}');
  });
}
