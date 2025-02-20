part of ink_abi;

class Utils {
  static String trimHex(final String hexString) {
    return hexString.replaceFirst('0x', '');
  }

  static String bin2hex(final String input) {
    return input.codeUnits
        .map((final byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}
