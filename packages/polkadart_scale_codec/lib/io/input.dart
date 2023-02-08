part of io;

/// Trait that allows reading of data into a slice.
mixin Input {
  /// Should return the remaining length of the input data. If no information about the input
  /// length is available, `None` should be returned.
  ///
  /// The length is used to constrain the preallocation while decoding. Returning a garbage
  /// length can open the doors for a denial of service attack to your application.
  /// Otherwise, returning `None` can decrease the performance of your application.
  int remainingLen();

  /// Read the exact number of bytes required to fill the given buffer.
  ///
  /// Note that this function is similar to `std::io::Read::read_exact` and not
  /// `std::io::Read::read`.
  int read();

  /// Read the exact number of bytes required to fill the given buffer.
  ///
  /// Note that this function is similar to `std::io::Read::read_exact` and not
  /// `std::io::Read::read`.
  UnmodifiableUint8ListView readBytes(int len);
}
