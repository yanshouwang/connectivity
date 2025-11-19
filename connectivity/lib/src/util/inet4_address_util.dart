import '../inet4_address.dart';
import '../jni.dart' as jni;

abstract final class Inet4AddressUtil {
  static Inet4Address intToInet4AddressHTL(int hostAddress) =>
      jni.JInet4AddressUtil.INSTANCE.intToInet4AddressHTL(hostAddress).impl;

  static Inet4Address intToInet4AddressHTH(int hostAddress) =>
      jni.JInet4AddressUtil.INSTANCE.intToInet4AddressHTH(hostAddress).impl;

  static int inet4AddressToIntHTH(Inet4Address inetAddr) =>
      jni.JInet4AddressUtil.INSTANCE.inet4AddressToIntHTH(inetAddr.api);

  static int inet4AddressToIntHTL(Inet4Address inetAddr) =>
      jni.JInet4AddressUtil.INSTANCE.inet4AddressToIntHTL(inetAddr.api);

  static int prefixLengthToV4NetmaskIntHTH(int prefixLength) => jni
      .JInet4AddressUtil
      .INSTANCE
      .prefixLengthToV4NetmaskIntHTH(prefixLength);

  static int prefixLengthToV4NetmaskIntHTL(int prefixLength) => jni
      .JInet4AddressUtil
      .INSTANCE
      .prefixLengthToV4NetmaskIntHTL(prefixLength);

  static int netmaskToPrefixLength(Inet4Address netmask) =>
      jni.JInet4AddressUtil.INSTANCE.netmaskToPrefixLength(netmask.api);

  static int getImplicitNetmask(Inet4Address address) =>
      jni.JInet4AddressUtil.INSTANCE.getImplicitNetmask(address.api);

  static Inet4Address getBroadcastAddress(
    Inet4Address addr,
    int prefixLength,
  ) => jni.JInet4AddressUtil.INSTANCE
      .getBroadcastAddress(addr.api, prefixLength)
      .impl;

  static Inet4Address getPrefixMaskAsInet4Address(int prefixLength) => jni
      .JInet4AddressUtil
      .INSTANCE
      .getPrefixMaskAsInet4Address(prefixLength)
      .impl;

  static String? trimAddressZeros(String? addr) =>
      jni.JInet4AddressUtil.INSTANCE.trimAddressZeros(addr?.api)?.impl;
}
