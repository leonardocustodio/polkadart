import 'dart:convert';
import 'dart:io';

import 'package:ink_abi/ink_abi_base.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  final String jsonFilePath = './test/test_resources/v3_metadata.json';
  final Map<String, dynamic> metadataV3 =
      jsonDecode(File(jsonFilePath).readAsStringSync());
  final InkAbi inkAbi = InkAbi(metadataV3);

  test('decode constructor', () {
    final data = '0x9bae9d5e0000a0dec5adc9353600000000000000';
    final decoded = inkAbi.decodeConstructor(data);
    expect(decoded.value['initial_supply'].toString(),
        BigInt.tryParse('1000000000000000000000').toString());
  });

  test('decode event', () {
    final String data =
        '0x0001da002226d93b2c422b95b780a2493e738716050ccad6ddbd7d58f1943bc6373d015207202c27b646ceeb294ce516d4334edafbd771f869215cb070ba51dd7e2c720000c84e676dc11b0000000000000000';
    final decoded = inkAbi.decodeEventFromHex(data);
    expect('0x${encodeHex(decoded['from'].value.cast<int>())}',
        '0xda002226d93b2c422b95b780a2493e738716050ccad6ddbd7d58f1943bc6373d');
    expect('0x${encodeHex(decoded['to'].value.cast<int>())}',
        '0x5207202c27b646ceeb294ce516d4334edafbd771f869215cb070ba51dd7e2c72');
    expect(decoded['value'].toString(),
        BigInt.tryParse('2000000000000000000').toString());
  });

  test('decode message', () {
    final String data =
        '0x84a15da15207202c27b646ceeb294ce516d4334edafbd771f869215cb070ba51dd7e2c720000f444829163450000000000000000';
    final decoded = inkAbi.decodeMessage(data);
    expect('0x${encodeHex(decoded.value['to'].cast<int>())}',
        '0x5207202c27b646ceeb294ce516d4334edafbd771f869215cb070ba51dd7e2c72');
    expect(decoded.value['value'].toString(),
        BigInt.tryParse('5000000000000000000').toString());
  });
}
