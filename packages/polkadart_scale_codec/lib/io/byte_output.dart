part of io;

/// Default writing of data.
class ByteOutput with Output {
  late BytesBuilder buffer;

  ByteOutput() {
    buffer = BytesBuilder();
  }

  @override
  void write(List<int> bytes) {
    buffer.add(bytes);
  }

  @override
  void pushByte(int byte) {
    buffer.addByte(byte);
  }

  int get length => buffer.length;

  @override
  List<int> get bytes => buffer.toBytes();
}
