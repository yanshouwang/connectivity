import 'inet_address.dart';
import 'jni.dart' as jni;

abstract interface class Inet4Address implements InetAddress {}

final class Inet4AddressImpl extends InetAddressImpl implements Inet4Address {
  @override
  final jni.Inet4Address api;

  Inet4AddressImpl.jni(this.api);
}

extension Inet4AddressX on Inet4Address {
  jni.Inet4Address get api {
    final impl = this;
    if (impl is! Inet4AddressImpl) throw TypeError();
    return impl.api;
  }
}

extension JInet4AddressX on jni.Inet4Address {
  Inet4Address get impl => Inet4AddressImpl.jni(this);
}
