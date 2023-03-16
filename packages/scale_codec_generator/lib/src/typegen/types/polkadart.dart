part of generators;

class PolkadartGenerator {
  String filePath;
  String name;
  List<PalletGenerator> pallets;

  PolkadartGenerator(
      {required this.filePath, required this.name, required this.pallets});

  GeneratedOutput generated() {
    final queries = classbuilder.createPolkadartQueries(this);
    final constants = classbuilder.createPolkadartConstants(this);
    final rpc = classbuilder.createPolkadartRpc(this);
    final polkdart = classbuilder.createPolkadartClass(this);
    return GeneratedOutput(
        classes: [queries, constants, rpc, polkdart], enums: [], typedefs: []);
  }
}
