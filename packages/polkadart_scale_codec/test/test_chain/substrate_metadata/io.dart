import 'dart:convert';
import 'dart:io';
import '../exceptions/old_types_bundle_expection.dart';
import 'old/types.dart';

import '../substrate_metadata/old/definitions/altair.dart' as altair;
import '../substrate_metadata/old/definitions/bifrost.dart' as bifrost;
import '../substrate_metadata/old/definitions/khala.dart' as khala;
import '../substrate_metadata/old/definitions/kusama.dart' as kusama;
import '../substrate_metadata/old/definitions/moonsama.dart' as moonsama;
import '../substrate_metadata/old/definitions/polkadot.dart' as polkadot;
import '../substrate_metadata/old/definitions/acala.dart' as acala;
import '../substrate_metadata/old/definitions/astar.dart' as astar;
import '../substrate_metadata/old/definitions/shiden.dart' as shiden;
import '../substrate_metadata/old/definitions/shibuya.dart' as shibuya;
import '../substrate_metadata/old/definitions/crust.dart' as crust;
import '../substrate_metadata/old/definitions/shell.dart' as shell;
import '../substrate_metadata/old/definitions/statemint.dart' as statemint;
import '../substrate_metadata/old/definitions/subsocial.dart' as subsocial;
import '../substrate_metadata/old/definitions/kilt.dart' as kilt;
import '../substrate_metadata/old/definitions/hydradx.dart' as hydradx;
import '../substrate_metadata/old/definitions/pioneer.dart' as pioneer;
import '../substrate_metadata/old/definitions/parallel.dart' as parallel;
import '../substrate_metadata/old/definitions/clover.dart' as clover;
import '../substrate_metadata/old/definitions/manta.dart' as manta;
import '../substrate_metadata/old/definitions/calamari.dart' as calamari;
import '../substrate_metadata/old/definitions/basilisk.dart' as basilisk;
import '../substrate_metadata/old/definitions/unique.dart' as unique;
import '../substrate_metadata/old/definitions/darwinia.dart' as darwinia;
import '../substrate_metadata/old/definitions/kintsugi.dart' as kintsugi;

OldTypesBundle? getOldTypesBundle(String chain) {
  switch (chain) {
    case 'altair':
      return OldTypesBundle.fromMap(altair.bundle);
    case 'bifrost':
      return OldTypesBundle.fromMap(bifrost.bundle);
    case 'khala':
      return OldTypesBundle.fromMap(khala.bundle);
    case 'kusama':
      return OldTypesBundle.fromMap(kusama.bundle);
    case 'moonbeam':
    case 'moonbase':
    case 'moonriver':
      return OldTypesBundle.fromMap(moonsama.bundle);
    case 'polkadot':
      return OldTypesBundle.fromMap(polkadot.bundle);
    case 'acala':
    case 'karura':
      return OldTypesBundle.fromMap(acala.bundle);
    case 'astar':
      return OldTypesBundle.fromMap(astar.bundle);
    case 'shiden':
      return OldTypesBundle.fromMap(shiden.bundle);
    case 'shibuya':
      return OldTypesBundle.fromMap(shibuya.bundle);
    case 'crust':
      return OldTypesBundle.fromMap(crust.bundle);
    case 'shell':
      return OldTypesBundle.fromMap(shell.bundle);
    case 'statemint':
    case 'statemine':
      return OldTypesBundle.fromMap(statemint.bundle);
    case 'subsocial':
      return OldTypesBundle.fromMap(subsocial.bundle);
    case 'kilt':
    case 'kilt-spiritnet': // real spec name
      return OldTypesBundle.fromMap(kilt.bundle);
    case 'hydradx':
    case 'hydra-dx': // real spec name
      return OldTypesBundle.fromMap(hydradx.bundle);
    case 'pioneer':
      return OldTypesBundle.fromMap(pioneer.bundle);
    case 'parallel':
    case 'heiko':
      return OldTypesBundle.fromMap(parallel.bundle);
    case 'clover':
      return OldTypesBundle.fromMap(clover.bundle);
    case 'manta':
      return OldTypesBundle.fromMap(manta.bundle);
    case 'calamari':
      return OldTypesBundle.fromMap(calamari.bundle);
    case 'basilisk':
      return OldTypesBundle.fromMap(basilisk.bundle);
    case 'unique':
    case 'quartz':
      return OldTypesBundle.fromMap(unique.bundle);
    case 'darwinia':
    case 'Darwinia': // real spec name
      return OldTypesBundle.fromMap(darwinia.bundle);
    case 'kintsugi':
    case 'kintsugi-parachain': // real spec name
      return OldTypesBundle.fromMap(kintsugi.bundle);
    default:
      return null;
  }
}

OldTypesBundle readOldTypesBundle(String file) {
  late String content;
  try {
    content = File(file).readAsStringSync();
  } catch (e) {
    throw OldTypesBundleException(file, e);
  }
  late OldTypesBundle json;
  try {
    json = OldTypesBundle.fromMap(jsonDecode(content));
  } catch (e) {
    throw OldTypesBundleException(file, e);
  }
  return json;
}
