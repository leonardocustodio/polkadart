import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final registry = Registry();

  registry.registerCustomCodec({
    'MyCodec': 'Compact<Balance>',
    'Balance': 'u128',
    'BalanceOf': 'Balance',
  });

  print('here');
}
