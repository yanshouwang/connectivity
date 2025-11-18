import 'dart:typed_data';

import 'inet4_address.dart';
import 'inet6_address.dart';
import 'jni.dart' as jni;
import 'network_interface.dart';

abstract interface class InetAddress {
  static List<InetAddress> getAll(String? host) =>
      InetAddressImpl.getAllByName(host);

  factory InetAddress.byName(String? host) => InetAddressImpl.getByName(host);

  factory InetAddress.byAddress(Uint8List addr) =>
      InetAddressImpl.getByAddress(addr);

  factory InetAddress.byNameAddress(String? host, Uint8List addr) =>
      InetAddressImpl.getByNameAddress(host, addr);

  factory InetAddress.local() => InetAddressImpl.getLocalHost();

  factory InetAddress.loopback() => InetAddressImpl.getLoopbackAddress();

  Uint8List get address;
  String get canonicalHostName;
  String? get hostAddress;
  String get hostName;
  bool get isAnyLocalAddress;
  bool get isLinkLocalAddress;
  bool get isLoopbackAddress;
  bool get isMCGlobal;
  bool get isMCLinkLocal;
  bool get isMCNodeLocal;
  bool get isMCOrgLocal;
  bool get isMCSiteLocal;
  bool get isMulticastAddress;
  bool get isSiteLocalAddress;

  bool isReachable(int timeout);
  bool isReachableWithNetwork(NetworkInterface? netif, int ttl, int timetout);
}

abstract base class InetAddressImpl implements InetAddress {
  static List<InetAddress> getAllByName(String? host) =>
      jni.InetAddress.getAllByName(
        host?.api,
      )!.nonNulls.map((e) => e.impl).toList();

  static InetAddress getByAddress(Uint8List addr) =>
      jni.InetAddress.getByAddress(addr.api)!.impl;

  static InetAddress getByNameAddress(String? host, Uint8List addr) =>
      jni.InetAddress.getByAddress$1(host?.api, addr.api)!.impl;

  static InetAddress getByName(String? host) =>
      jni.InetAddress.getByName(host?.api)!.impl;

  static InetAddress getLocalHost() => jni.InetAddress.getLocalHost()!.impl;

  static InetAddress getLoopbackAddress() =>
      jni.InetAddress.getLoopbackAddress()!.impl;

  jni.InetAddress get api;

  @override
  Uint8List get address => api.getAddress()!.impl;

  @override
  String get canonicalHostName => api.getCanonicalHostName()!.impl;

  @override
  String? get hostAddress => api.getHostAddress()?.impl;

  @override
  String get hostName => api.getHostName()!.impl;

  @override
  bool get isAnyLocalAddress => api.isAnyLocalAddress();

  @override
  bool get isLinkLocalAddress => api.isLinkLocalAddress();

  @override
  bool get isLoopbackAddress => api.isLoopbackAddress();

  @override
  bool get isMCGlobal => api.isMCGlobal();

  @override
  bool get isMCLinkLocal => api.isMCLinkLocal();

  @override
  bool get isMCNodeLocal => api.isMCNodeLocal();

  @override
  bool get isMCOrgLocal => api.isMCOrgLocal();

  @override
  bool get isMCSiteLocal => api.isMCSiteLocal();

  @override
  bool get isMulticastAddress => api.isMulticastAddress();

  @override
  bool get isSiteLocalAddress => api.isSiteLocalAddress();

  @override
  bool isReachable(int timeout) => api.isReachable(timeout);

  @override
  bool isReachableWithNetwork(NetworkInterface? netif, int ttl, int timetout) =>
      api.isReachable$1(netif?.api, ttl, timetout);
}

extension InetAddressX on InetAddress {
  jni.InetAddress get api {
    final impl = this;
    if (impl is! InetAddressImpl) throw TypeError();
    return impl.api;
  }
}

extension JInetAddressX on jni.InetAddress {
  InetAddress get impl {
    final api = this;
    final isV4 = api.isInstanceOf(jni.Inet4Address.type.jClass);
    if (isV4) {
      return api.as(jni.Inet4Address.type).impl;
    }
    final isV6 = api.isInstanceOf(jni.Inet6Address.type.jClass);
    if (isV6) {
      return api.as(jni.Inet6Address.type).impl;
    }
    throw TypeError();
  }
}
