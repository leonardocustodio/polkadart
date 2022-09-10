import 'dart:io';
import 'package:test/test.dart';
import './test_chain/core/chain.dart';

void main() {
  group('Test ', () {
    Directory dir = Directory('./test/chain');
// execute an action on each entry
    var list = dir.listSync(recursive: false).toList();
    list.sort((a, b) => a.path.compareTo(b.path));
    Stopwatch stopwatch = Stopwatch()..start();
    for (var f in list) {
      var dirname = f.path.split('/').last;

      if (!dirname.contains('.gitattributes')) {
        test(dirname, () {
          var chain = Chain(dirname);
          chain.testConstantsScaleEncodingDecoding();
        });
      }
    }
    print('doSomething() executed in ${stopwatch.elapsed}');
  });
}
