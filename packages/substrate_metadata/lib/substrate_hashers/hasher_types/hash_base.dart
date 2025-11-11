// Copyright (c) 2023, Sudipto Chandra
// All rights reserved. Check LICENSE file for details.
// This code is part of hashlib 1.12.0
// https://pub.dev/packages/hashlib

part of substrate_hashers;

/// This sink allows adding arbitrary length byte arrays
/// and produces a [HashDigest] on [close].
abstract class HashDigestSink implements Sink<List<int>> {
  const HashDigestSink();

  /// Returns true if the sink is closed, false otherwise
  bool get closed;

  /// The length of generated hash in bytes
  int get hashLength;

  /// Adds [data] to the message-digest.
  ///
  /// Throws [StateError], if it is called after closing the digest.
  @override
  void add(List<int> data, [int start = 0, int? end]);

  /// Finalizes the message-digest. It calls [digest] method internally.
  @override
  @pragma('vm:prefer-inline')
  void close() => digest();

  /// Finalizes the message-digest and returns a [HashDigest]
  HashDigest digest();

  /// Resets the current state to start from fresh state
  void reset();
}

/// The base class used by the hash algorithm implementations. It implements
/// the [StreamTransformer] and exposes few convenient methods to handle any
/// types of data source.
abstract class HashBase implements StreamTransformer<List<int>, HashDigest> {
  const HashBase();

  /// The name of this algorithm
  String get name;

  /// Create a [HashDigestSink] for generating message-digests
  @pragma('vm:prefer-inline')
  HashDigestSink createSink();

  /// Transforms the byte array input stream to generate a new stream
  /// which contains a single [HashDigest]
  ///
  /// The expected behavior of this method is described below:
  ///
  /// - When the returned stream has a subscriber (calling [Stream.listen]),
  ///   the message-digest generation begins from the input [stream].
  /// - If the returned stream is paused, the processing of the input [stream]
  ///   is also paused, and on resume, it continue processing from where it was
  ///   left off.
  /// - If the returned stream is cancelled, the subscription to the input
  ///   [stream] is also cancelled.
  /// - When the input [stream] is closed, the returned stream also gets closed
  ///   with a [HashDigest] data. The returned stream may produce only one
  ///   such data event in its life-time.
  /// - On error reading the input [stream], or while processing the message
  ///   digest, the subscription to input [stream] cancels immediately and the
  ///   returned stream closes with an error event.
  @override
  Stream<HashDigest> bind(Stream<List<int>> stream) {
    bool paused = false;
    bool cancelled = false;
    StreamSubscription<List<int>>? subscription;
    final controller = StreamController<HashDigest>(sync: false);
    controller.onCancel = () async {
      cancelled = true;
      await subscription?.cancel();
    };
    controller.onPause = () {
      paused = true;
      subscription?.pause();
    };
    controller.onResume = () {
      paused = false;
      subscription?.resume();
    };
    controller.onListen = () {
      if (cancelled) return;
      bool hasError = false;
      final sink = createSink();
      subscription = stream.listen(
        (List<int> event) {
          try {
            sink.add(event);
          } catch (err, stack) {
            hasError = true;
            subscription?.cancel();
            controller.addError(err, stack);
          }
        },
        cancelOnError: true,
        onError: (Object err, [StackTrace? stack]) {
          hasError = true;
          controller.addError(err, stack);
        },
        onDone: () {
          try {
            if (!hasError) {
              controller.add(sink.digest());
            }
          } catch (err, stack) {
            controller.addError(err, stack);
          } finally {
            controller.close();
          }
        },
      );
      if (paused) {
        subscription?.pause();
      }
    };
    return controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() =>
      StreamTransformer.castFrom<List<int>, HashDigest, RS, RT>(this);

  /// Process the byte array [input] and returns a [HashDigest].
  @pragma('vm:prefer-inline')
  HashDigest convert(List<int> input) {
    final sink = createSink();
    sink.add(input);
    return sink.digest();
  }

  /// Process the [input] string and returns a [HashDigest].
  ///
  /// If the [encoding] is not specified, `codeUnits` are used as input bytes.
  HashDigest string(String input, [Encoding? encoding]) {
    final sink = createSink();
    if (encoding != null) {
      final data = encoding.encode(input);
      sink.add(data);
    } else {
      sink.add(input.codeUnits);
    }
    return sink.digest();
  }

  /// Consumes the entire [stream] of byte array and generates a [HashDigest].
  @pragma('vm:prefer-inline')
  Future<HashDigest> consume(Stream<List<int>> stream) {
    return bind(stream).first;
  }

  /// Consumes the entire [stream] of string and generates a [HashDigest].
  ///
  /// Default [encoding] scheme to get the input bytes is [latin1].
  @pragma('vm:prefer-inline')
  Future<HashDigest> consumeAs(
    Stream<String> stream, [
    Encoding encoding = latin1,
  ]) {
    return bind(stream.transform(encoding.encoder)).first;
  }

  /// Converts the [input] file and returns a [HashDigest] asynchronously.
  ///
  /// If [start] is present, the file will be read from byte-offset [start].
}
