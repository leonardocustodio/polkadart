part of io;

/// Default writing of data.
class SizeTracker with Output {
  int size = 0;

  @override
  void write(List<int> bytes) {
    size += bytes.length;
  }

  @override
  void pushByte(int byte) {
    size++;
  }
}
