import './base.dart' show GeneratedOutput;
import '../class_builder.dart'
    show createPolkadartQueries, createPolkadartConstants, createPolkadartClass;
import './pallet.dart' show PalletGenerator;

class PolkadartGenerator {
  String filePath;
  String name;
  List<PalletGenerator> pallets;

  PolkadartGenerator(
      {required this.filePath, required this.name, required this.pallets});

  GeneratedOutput generated() {
    final queries = createPolkadartQueries(this);
    final constants = createPolkadartConstants(this);
    final polkdart = createPolkadartClass(this);
    return GeneratedOutput(
        classes: [queries, constants, polkdart], enums: [], typedefs: []);
  }
}
