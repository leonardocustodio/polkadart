library ink_abi;

import 'dart:typed_data';
import 'package:ink_abi/interfaces/interfaces_base.dart';
import 'package:json_schema/json_schema.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/parsers/parsers.dart';

// core
part 'core/decode_result.dart';
part 'core/encode_call.dart';
part 'core/ink_abi.dart';
part 'core/selector_byte_input.dart';
part 'core/ink_abi_description.dart';
part 'core/types_normalizer.dart';

// models
part 'models/ink_abi_event.dart';

// schemas
part 'schemas/v3/ink_v3_schema.dart';
part 'schemas/v4/ink_v4_schema.dart';
part 'schemas/v5/ink_v5_schema.dart';
part 'schemas/schema_validator.dart';

// utils
part 'utils/string_extension.dart';
part 'utils/utils.dart';
