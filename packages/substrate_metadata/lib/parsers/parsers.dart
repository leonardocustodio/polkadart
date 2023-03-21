library parsers;

import 'package:equatable/equatable.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/types/metadata_types.dart';
import 'package:utility/utility.dart';
import '../models/legacy_types.dart';
import '../models/models.dart';
import 'package:substrate_metadata/utils/utils.dart';

part 'legacy_parser.dart';
part 'v14_parser.dart';
part 'metadata_v14_expander.dart';
part 'type_normalizer.dart';
part 'type_expression_parser.dart';
