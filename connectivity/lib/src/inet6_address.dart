import 'dart:typed_data';

import 'inet_address.dart';
import 'jni.dart' as jni;
import 'network_interface.dart';

abstract interface class Inet6Address implements InetAddress {
  factory Inet6Address.byNameAddressNetwork(
    String host,
    Uint8List addr,
    NetworkInterface nif,
  ) => Inet6AddressImpl.getByNameAddressNetwork(host, addr, nif);

  factory Inet6Address.byNameAddressScopeId(
    String host,
    Uint8List addr,
    int scopeId,
  ) => Inet6AddressImpl.getByNameAddressScopeId(host, addr, scopeId);

  bool get isIPv4CompatibleAddress;
}

final class Inet6AddressImpl extends InetAddressImpl implements Inet6Address {
  static Inet6Address getByNameAddressNetwork(
    String host,
    Uint8List addr,
    NetworkInterface nif,
  ) => jni.Inet6Address.getByAddress$3(host.api, addr.api, nif.api)!.impl;

  static Inet6Address getByNameAddressScopeId(
    String host,
    Uint8List addr,
    int scopeId,
  ) => jni.Inet6Address.getByAddress$2(host.api, addr.api, scopeId)!.impl;

  @override
  final jni.Inet6Address api;

  Inet6AddressImpl.jni(this.api);

  @override
  bool get isIPv4CompatibleAddress => api.isIPv4CompatibleAddress();
}

extension JInet6AddressX on jni.Inet6Address {
  Inet6Address get impl => Inet6AddressImpl.jni(this);
}
