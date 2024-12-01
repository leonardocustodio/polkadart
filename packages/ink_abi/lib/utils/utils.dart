part of ink_abi;

class Utils {
  static String trimHex(String hexString) {
    return hexString.replaceFirst('0x', '');
  }

  static String bin2hex(String input) {
    return input.codeUnits
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}
