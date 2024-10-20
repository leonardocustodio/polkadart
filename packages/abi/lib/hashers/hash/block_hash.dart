/* // Copyright (c) 2023, Sudipto Chandra
// All rights reserved. Check LICENSE file for details.
// This code is part of hashlib 1.12.0
// https://pub.dev/packages/hashlib

part of hashers_base;

// Maximum length of message allowed (considering both the JS and Dart VM)
const int _maxMessageLength = 0x3FFFFFFFFFFFF; // (1 << 50) - 1

abstract class BlockHashBase extends HashBase {
  const BlockHashBase();

  @override
  BlockHashSink createSink();
}

abstract class BlockHashSink implements HashDigestSink {
  /// The flag tracking if the [digest] is called once.
  bool _closed = false;

  /// The message digest (available after the [digest] call)
  HashDigest? _digest;

  /// The current position of data in the [buffer]
  int pos = 0;

  /// The message length in bytes
  int messageLength = 0;

  /// The internal block length of the algorithm in bytes
  final int blockLength;

  /// The main buffer
  late final Uint8List buffer;

  /// The [buffer] as Uint32List
  late final Uint32List sbuffer;

  /// The [buffer] as ByteData
  late final ByteData bdata;

  /// Initialize a new sink for the block hash
  ///
  /// Parameters:
  /// - [blockLength] is the length of each block in each [$update] call.
  /// - [bufferLength] is the buffer length where blocks are stored temporarily
  BlockHashSink(this.blockLength, {int? bufferLength}) : super() {
    buffer = Uint8List(bufferLength ?? blockLength);
    sbuffer = buffer.buffer.asUint32List();
    bdata = buffer.buffer.asByteData();
  }

  @override
  bool get closed => _closed;

  /// Get the message length in bits
  int get messageLengthInBits => messageLength << 3;

  /// Internal method to update the message-digest with a single [block].
  ///
  /// The method starts reading the block from [offset] index
  void $update(List<int> block, [int offset = 0, bool last = false]);

  /// Finalizes the message digest with the remaining message block,
  /// and returns the output as byte array.
  Uint8List $finalize();

  @override
  void reset() {
    pos = 0;
    messageLength = 0;
    _digest = null;
    _closed = false;
  }

  @override
  void add(List<int> data, [int start = 0, int? end]) {
    if (_closed) {
      throw StateError('The message-digest is already closed');
    }

    end ??= data.length;
    if (messageLength - start > _maxMessageLength - end) {
      throw StateError('Exceeds the maximum message size limit');
    }

    $process(data, start, end);
  }

  /// Processes a chunk of input data
  void $process(List<int> chunk, int start, int end) {
    int t = start;
    if (pos > 0) {
      for (; t < end && pos < blockLength; pos++, t++) {
        buffer[pos] = chunk[t];
      }
      messageLength += t - start;
      if (pos < blockLength) return;

      $update(buffer);
      pos = 0;
    }

    while ((end - t) >= blockLength) {
      messageLength += blockLength;
      $update(chunk, t);
      t += blockLength;
    }

    messageLength += end - t;
    for (; t < end; pos++, t++) {
      buffer[pos] = chunk[t];
    }
  }

  @override
  @pragma('vm:prefer-inline')
  void close() => digest();

  @override
  HashDigest digest() {
    if (_closed) return _digest!;
    _closed = true;
    _digest = HashDigest($finalize());
    return _digest!;
  }
}
 */
