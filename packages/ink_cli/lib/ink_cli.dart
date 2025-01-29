library ink_cli;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import 'package:ink_abi/ink_abi_base.dart';
import 'package:ink_abi/interfaces/interfaces_base.dart';
import 'package:ink_abi/interfaces/interfaces_base.dart' as interfaces_base;
import 'package:polkadart/polkadart.dart';
import 'package:polkadart/substrate/era.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:ss58/ss58.dart';
import 'package:substrate_metadata/utils/utils.dart';
import 'package:polkadart/scale_codec.dart' as scale_codec;

/// contracts_builder
// - contract_args
part 'src/contracts_builder/args/contract_args.dart';
part 'src/contracts_builder/args/instantiate_with_code_args.dart';
// - core
part 'src/contracts_builder/core/contract_builder.dart';
part 'src/contracts_builder/core/contract_deployer.dart';
part 'src/contracts_builder/core/contract_extrinsic_payload.dart';
part 'src/contracts_builder/core/contract_meta.dart';
part 'src/contracts_builder/core/contract_method.dart';
part 'src/contracts_builder/core/contract_signing_payload.dart';
part 'src/contracts_builder/core/gas_limit.dart';
part 'src/contracts_builder/core/instantiate_request.dart';
part 'src/contracts_builder/core/storage_deposit_limit.dart';
// - contract_exec
part 'src/contracts_builder/exec/contract_exec_result_ok.dart';
part 'src/contracts_builder/exec/contract_exec_result_result.dart';
part 'src/contracts_builder/exec/contract_exec_result.dart';

// contract_definitions
part 'src/definitions/contracts.dart';

// core
part 'src/core/abi_output.dart';
part 'src/core/interfaces.dart';
part 'src/core/names_generator.dart';
part 'src/core/sink.dart';
part 'src/core/type_generator.dart';

// hasher
part 'src/hasher/type_hasher.dart';
part 'src/hasher/dcg_hasher.dart';

// utils
part 'src/utils/file_utils.dart';
