part of primitives;

class U8Codec with Codec<int> {
  const U8Codec._();

  static final U8Codec codec = U8Codec._();

  @override
  void encodeTo(int value, Output output) {
    assertion(value >= 0 && value <= 0xFF);
    return output.pushByte(value.toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read();
  }

  @override
  int sizeHint(int value) {
    return 1;
  }
}

// class I8SequenceCodec with Codec<Int8List> {
//   const I8SequenceCodec._();

//   static const I8SequenceCodec codec = I8SequenceCodec._();

//   @override
//   Int8List decode(Input input) {
//     final length = CompactCodec.codec.decode(input).toInt();
//     final list = Int8List(length);
//     for (var i = 0; i < length; i++) {
//       list[i] = I8Codec.codec.decode(input);
//     }
//     return list;
//   }

//   @override
//   void encodeTo(Int8List list, Output output) {
//     CompactCodec.codec.encodeTo(list.length, output);
//     for (int value in list) {
//       I8Codec.codec.encodeTo(value, output);
//     }
//   }

//   @override
//   int sizeHint(Int8List list) {
//     return CompactCodec.codec.sizeHint(list.length) + list.lengthInBytes;
//   }
// }

// class I8ArrayCodec with Codec<Int8List> {
//   final int length;
//   const I8ArrayCodec(this.length);

//   @override
//   Int8List decode(Input input) {
//     final list = Int8List(length);
//     for (var i = 0; i < length; i++) {
//       list[i] = I8Codec.codec.decode(input);
//     }
//     return list;
//   }

//   @override
//   void encodeTo(Int8List list, Output output) {
//     if (list.length != length) {
//       throw Exception("I8ArrayCodec: invalid length, expect $length found ${list.length}");
//     }
//     for (var i = 0; i < length; i++) {
//       I8Codec.codec.encodeTo(list[i], output);
//     }
//   }

//   @override
//   int sizeHint(Int8List list) {
//     return length;
//   }
// }
