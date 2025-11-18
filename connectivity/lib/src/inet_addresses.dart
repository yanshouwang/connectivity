import 'inet_address.dart';
import 'jni.dart' as jni;

abstract interface class InetAddresses {
  static bool isNumericAddress(String address) =>
      InetAddressesImpl.isNumericAddress(address);
  static InetAddress parseNumericAddress(String address) =>
      InetAddressesImpl.parseNumericAddress(address);
}

final class InetAddressesImpl implements InetAddresses {
  static bool isNumericAddress(String address) =>
      jni.InetAddresses.isNumericAddress(address.api);

  static InetAddress parseNumericAddress(String address) =>
      jni.InetAddresses.parseNumericAddress(address.api).impl;

  final jni.InetAddresses api;

  InetAddressesImpl.jni(this.api);
}
