import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/models/models.dart';

class Transfers {
  final String method;

  const Transfers(this.method);

  static Transfers transferKeepAlive = Transfers('transfer_keep_alive');

  Uint8List encode(ChainInfo chainInfo, Uint8List destination, BigInt amount) {
    final transferArgument = MapEntry(
      'Balances',
      MapEntry(
        method,
        {
          'dest': MapEntry('Id', destination),
          'value': amount,
        },
      ),
    );

    final ByteOutput output = ByteOutput();

    chainInfo.scaleCodec.registry.codecs['Call']!
        .encodeTo(transferArgument, output);
    return output.toBytes();
  }
}
