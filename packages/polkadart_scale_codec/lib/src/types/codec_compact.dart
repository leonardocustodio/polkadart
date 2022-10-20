part of '../core/core.dart';

/// [ScaleCodecType] class to encode and decode `signed 8-bit` integers.
///
/// A "compact" or general integer encoding is sufficient for encoding
/// large integers (up to 2**536) and is more efficient at encoding most
/// values than the fixed-width version. (Though for single-byte values,
/// the fixed-width integer is never worse.)
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecCompact<T extends Object> implements ScaleCodecType<T> {
  /// Default constructor used to limit [T] types.
  /// Only `int` and `BigInt` are supported.
  CodecCompact() {
    if ((T != int && T != BigInt)) {
      throw UnexpectedTypeException(
          expectedType: 'int or BigInt', receivedType: T.toString());
    }
  }

  /// Returns an encoded hex-decimal `string` from `int` or `BigInt`[value]
  /// using [HexEncoder] methods.
  ///
  /// Compact/general integers are encoded with the two least significant bits
  /// denoting the mode:
  /// - 0b00: single-byte mode; upper six bits are the LE encoding of the value
  ///  (valid only for values of `0-63`).
  /// - 0b01: two-byte mode: upper six bits and the following byte is the LE
  ///   encoding of the value (valid only for values `64-(2**14-1)`).
  /// - 0b10: four-byte mode: upper six bits and the following three bytes are
  ///   the LE encoding of the value (valid only for values `(2**14)-(2**30-1)`).
  /// - 0b11: Big-integer mode: The upper six bits are the number of bytes following,
  ///   plus four. The value is contained, LE encoded, in the bytes following.
  ///   The final (most significant) byte must be non-zero. Valid only for values
  ///   `(2**30)-(2**536-1)`.
  ///
  /// Example:
  /// ```
  /// final intEncoded = CodecCompact<int>().encodeToHex(65535); //"0xfeff0300"
  /// final bigIntEncoded = CodecCompact<BigInt>().encodeToHex(18446744073709551615.toBigInt);
  /// //0x13ffffffffffffffff
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();

    var convertedValue = value is int ? value : (value as BigInt).toInt();

    if (convertedValue < 0) {
      throw IncompatibleCompactException("Value can't be less than 0.");
    }

    if (convertedValue < 64) {
      sink.write(convertedValue * 4);
    } else if (convertedValue < pow(2, 14).toInt()) {
      sink.write((convertedValue & 63) * 4 + 1);
      sink.write(convertedValue >>> 6);
    } else if (convertedValue < pow(2, 30).toInt()) {
      sink.write((convertedValue & 63) * 4 + 2);
      sink.write((convertedValue >>> 6) & 0xff);
      sink._uncheckedU16(convertedValue >>> 14);
    } else if (convertedValue < calculateBigIntPow(2, 536).toInt()) {
      final bigIntValue = BigInt.from(convertedValue);
      sink.write(unsignedIntByteLength(bigIntValue) * 4 - 13);
      while (convertedValue > 0) {
        sink.write(convertedValue & '0xff'.toBigInt.toInt());
        convertedValue = convertedValue >> 8.toBigInt.toInt();
      }
    } else {
      throw IncompatibleCompactException('$value is too large for a compact');
    }
    return sink.toHex();
  }

  /// Returns an `int`|`BigInt` value which the hex-decimal `string`
  /// [encodedData] represents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final intDecoded = CodecCompact<int>().decodeFromHex("0xfeff0300"); //65535
  /// final bigIntDecoded = CodecCompact<BigInt>().decodeFromHex("0x13ffffffffffffffff");
  /// //18446744073709551615
  /// ```
  @override
  T decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    var result = source.decodeCompact();
    source.assertEOF();

    if (T == int) {
      result = result is int ? result : (result as BigInt).toInt();
    } else {
      result = result is BigInt ? result : BigInt.from(result);
    }

    return result;
  }
}
