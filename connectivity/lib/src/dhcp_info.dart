import 'jni.dart' as jni;

abstract interface class DhcpInfo {
  factory DhcpInfo() => DhcpInfoImpl();

  int get dns1;
  int get dns2;
  int get gateway;
  int get ipAddress;
  int get leaseDuration;
  int get netmask;
  int get serverAddress;
}

final class DhcpInfoImpl implements DhcpInfo {
  final jni.DhcpInfo api;

  DhcpInfoImpl.jni(this.api);

  factory DhcpInfoImpl() {
    final api = jni.DhcpInfo();
    return DhcpInfoImpl.jni(api);
  }

  @override
  int get dns1 => api.dns1;

  @override
  int get dns2 => api.dns2;

  @override
  int get gateway => api.gateway;

  @override
  int get ipAddress => api.ipAddress;

  @override
  int get leaseDuration => api.leaseDuration;

  @override
  int get netmask => api.netmask;

  @override
  int get serverAddress => api.serverAddress;
}

extension JDhcpInfoX on jni.DhcpInfo {
  DhcpInfo get impl => DhcpInfoImpl.jni(this);
}
