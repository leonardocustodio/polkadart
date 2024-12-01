import 'dart:convert';
import 'dart:io';

import 'package:ink_abi/ink_abi_base.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  final String jsonFilePath = './test/test_resources/v5_metadata.json';
  final Map<String, dynamic> metadataV5 =
      jsonDecode(File(jsonFilePath).readAsStringSync());
  final InkAbi inkAbi = InkAbi(metadataV5);

  test('decode constructor', () {
    final String data = '0x9bae9d5e00000c6d51c8f7aa0600000000000000';
    final decoded = inkAbi.decodeConstructor(data);
    expect(decoded.value['total_supply'].toString(),
        BigInt.tryParse('123000000000000000000').toString());
  });

  test('decode event', () {
    final String data =
        '0xda002226d93b2c422b95b780a2493e738716050ccad6ddbd7d58f1943bc6373da69162c917081d15673558e13607b1b2261f2ae7b21ba911c3cd676767251266000064a7b3b6e00d0000000000000000';
    final List<String> topics = [
      '0x1a35e726f5feffda199144f6097b2ba23713e549bfcbe090c0981e3bcdfbcc1d',
      '0xda002226d93b2c422b95b780a2493e738716050ccad6ddbd7d58f1943bc6373d',
      '0xa69162c917081d15673558e13607b1b2261f2ae7b21ba911c3cd676767251266'
    ];
    final decoded = inkAbi.decodeEventFromHex(data, topics);
    expect('0x${encodeHex(decoded['owner'].cast<int>())}',
        '0xda002226d93b2c422b95b780a2493e738716050ccad6ddbd7d58f1943bc6373d');
    expect('0x${encodeHex(decoded['spender'].cast<int>())}',
        '0xa69162c917081d15673558e13607b1b2261f2ae7b21ba911c3cd676767251266');
    expect(decoded['value'].toString(),
        BigInt.tryParse('1000000000000000000').toString());
  });

  test('decode anonymous event', () {
    final String data =
        '0x01da002226d93b2c422b95b780a2493e738716050ccad6ddbd7d58f1943bc6373d01a69162c917081d15673558e13607b1b2261f2ae7b21ba911c3cd67676725126600008a5d784563010000000000000000';
    final List<String> topics = [
      '0xda002226d93b2c422b95b780a2493e738716050ccad6ddbd7d58f1943bc6373d',
      '0xa69162c917081d15673558e13607b1b2261f2ae7b21ba911c3cd676767251266'
    ];
    final decoded = inkAbi.decodeEventFromHex(data, topics);
    expect(('0x${encodeHex(decoded['from'].value.cast<int>())}'),
        '0xda002226d93b2c422b95b780a2493e738716050ccad6ddbd7d58f1943bc6373d');
    expect(('0x${encodeHex(decoded['to'].value.cast<int>())}'),
        '0xa69162c917081d15673558e13607b1b2261f2ae7b21ba911c3cd676767251266');
    expect(decoded['value'].toString(),
        BigInt.tryParse('100000000000000000').toString());
  });

  test('decode message', () {
    final String data =
        '0x84a15da1a69162c917081d15673558e13607b1b2261f2ae7b21ba911c3cd67676725126600008a5d784563010000000000000000';
    final decoded = inkAbi.decodeMessage(data);
    expect(('0x${encodeHex(decoded.value['to'].cast<int>())}'),
        '0xa69162c917081d15673558e13607b1b2261f2ae7b21ba911c3cd676767251266');
    expect(decoded.value['value'].toString(),
        BigInt.tryParse('100000000000000000').toString());
  });
}
