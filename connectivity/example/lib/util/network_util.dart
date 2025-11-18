abstract base class NetworkUtil {
  static String intToInet4Address(int value) {
    final i1 = 0xff & value >> 24;
    final i2 = 0xff & value >> 16;
    final i3 = 0xff & value >> 8;
    final i4 = 0xff & value;
    return '$i1.$i2.$i3.$i4';
  }

  static int prefixLengthToV4NetmaskInt(int prefixLength) {
    assert(
      !(prefixLength < 0 || prefixLength > 32),
      'Invalid prefix length (0 <= prefix <= 32)',
    );
    return (0xffffffff << (32 - prefixLength)) & 0xffffffff;
  }

  static String getPrefixMask(int prefixLength) {
    final value = prefixLengthToV4NetmaskInt(prefixLength);
    return intToInet4Address(value);
  }
}
