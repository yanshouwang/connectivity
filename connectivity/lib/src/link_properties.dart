import 'inet4_address.dart';
import 'inet_address.dart';
import 'ip_prefix.dart';
import 'jni.dart' as jni;
import 'link_address.dart';
import 'proxy_info.dart';
import 'route_info.dart';

abstract interface class LinkProperties {
  Inet4Address? get dhcpServerAddress;
  set dhcpServerAddress(Inet4Address? serverAddress);
  List<InetAddress> get dnsServers;
  set dnsServers(List<InetAddress> dnsServers);
  String? get domains;
  set domains(String? domains);
  ProxyInfo? get httpProxy;
  set httpProxy(ProxyInfo? proxy);
  String? get interfaceName;
  set interfaceName(String? iface);
  List<LinkAddress> get linkAddresses;
  set linkAddresses(List<LinkAddress> addresses);
  int get mtu;
  set mtu(int mtu);
  IpPrefix? get nat64Prefix;
  set nat64Prefix(IpPrefix? prefix);
  String? get privateDnsServerName;
  List<RouteInfo> get routes;
  bool get isPrivateDnsActive;
  bool get isWakeOnLanSupported;

  bool addRoute(RouteInfo route);
  void clear();
}

final class LinkPropertiesImpl implements LinkProperties {
  final jni.LinkProperties api;

  LinkPropertiesImpl.jni(this.api);

  @override
  Inet4Address? get dhcpServerAddress => api.getDhcpServerAddress()?.impl;
  @override
  set dhcpServerAddress(Inet4Address? serverAddress) =>
      api.setDhcpServerAddress(serverAddress?.api);

  @override
  List<InetAddress> get dnsServers =>
      api.getDnsServers().nonNulls.map((e) => e.impl).toList();
  @override
  set dnsServers(List<InetAddress> dnsServers) => api.setDnsServers(
    dnsServers
        .map((e) => e.api)
        .toJList(jni.InetAddress.type)
        .as(jni.Collection.type(jni.InetAddress.type)),
  );

  @override
  String? get domains => api.getDomains()?.impl;
  @override
  set domains(String? domains) => api.setDomains(domains?.api);

  @override
  ProxyInfo? get httpProxy => api.getHttpProxy()?.impl;
  @override
  set httpProxy(ProxyInfo? proxy) => api.setHttpProxy(proxy?.api);

  @override
  String? get interfaceName => api.getInterfaceName()?.impl;
  @override
  set interfaceName(String? iface) => api.setInterfaceName(iface?.api);

  @override
  List<LinkAddress> get linkAddresses =>
      api.getLinkAddresses().nonNulls.map((e) => e.impl).toList();
  @override
  set linkAddresses(List<LinkAddress> addresses) => api.setLinkAddresses(
    addresses
        .map((e) => e.api)
        .toJList(jni.LinkAddress.type)
        .as(jni.Collection.type(jni.LinkAddress.type)),
  );

  @override
  int get mtu => api.getMtu();
  @override
  set mtu(int mtu) => api.setMtu(mtu);

  @override
  IpPrefix? get nat64Prefix => api.getNat64Prefix()?.impl;
  @override
  set nat64Prefix(IpPrefix? prefix) => api.setNat64Prefix(prefix?.api);

  @override
  String? get privateDnsServerName => api.getPrivateDnsServerName()?.impl;

  @override
  List<RouteInfo> get routes =>
      api.getRoutes().nonNulls.map((e) => e.impl).toList();

  @override
  bool get isPrivateDnsActive => api.isPrivateDnsActive();

  @override
  bool get isWakeOnLanSupported => api.isWakeOnLanSupported();

  @override
  bool addRoute(RouteInfo route) => api.addRoute(route.api);

  @override
  void clear() => api.clear();
}

extension JLinkPropertiesX on jni.LinkProperties {
  LinkProperties get impl => LinkPropertiesImpl.jni(this);
}
