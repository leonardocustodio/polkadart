library ink_cli;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import 'package:ink_abi/ink_abi.dart';
import 'package:polkadart/polkadart.dart';
import 'package:substrate_metadata/substrate_metadata.dart';
import 'package:substrate_metadata/substrate_metadata.dart' as substrate_metadata;

// Era is exported from substrate_metadata via derived_codecs
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

/// contracts_builder
// - contract_args
part 'src/contracts_builder/args/contract_args.dart';
part 'src/contracts_builder/args/contract_call_args.dart';
part 'src/contracts_builder/args/instantiate_with_code_args.dart';
// - core
part 'src/contracts_builder/core/contract_builder.dart';
part 'src/contracts_builder/core/contract_mutator.dart';
part 'src/contracts_builder/core/contract_deployer.dart';
part 'src/contracts_builder/core/contract_method.dart';
part 'src/contracts_builder/core/gas_limit.dart';
part 'src/contracts_builder/core/instantiate_request.dart';
part 'src/contracts_builder/core/storage_deposit_limit.dart';
// - contract_exec
part 'src/contracts_builder/exec/contract_exec_result_ok.dart';
part 'src/contracts_builder/exec/contract_exec_result_result.dart';
part 'src/contracts_builder/exec/contract_exec_result.dart';
// - codecs
part 'src/contracts_builder/codecs/contracts_api_response_codec.dart';

// core
part 'src/core/abi_output.dart';
part 'src/core/codec_interface.dart';
part 'src/core/interfaces.dart';
part 'src/core/names_generator.dart';
part 'src/core/sink.dart';
part 'src/core/type_generator.dart';

// hasher
part 'src/hasher/type_hasher.dart';
part 'src/hasher/dcg_hasher.dart';

// utils
part 'src/utils/file_utils.dart';
