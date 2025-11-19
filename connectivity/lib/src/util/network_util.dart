import '../inet4_address.dart';
import '../jni.dart' as jni;

abstract final class NetworkUtil {
  static Inet4Address intToInetAddress(int hostAddress) =>
      jni.JNetworkUtil.INSTANCE.intToInetAddress(hostAddress).impl;

  static int inetAddressToInt(Inet4Address inetAddr) =>
      jni.JNetworkUtil.INSTANCE.inetAddressToInt(inetAddr.api);

  static int prefixLengthToNetmaskInt(int prefixLength) =>
      jni.JNetworkUtil.INSTANCE.prefixLengthToNetmaskInt(prefixLength);

  static int netmaskIntToPrefixLength(int netmask) =>
      jni.JNetworkUtil.INSTANCE.netmaskIntToPrefixLength(netmask);

  static int netmaskToPrefixLength(Inet4Address netmask) =>
      jni.JNetworkUtil.INSTANCE.netmaskToPrefixLength(netmask.api);
}
