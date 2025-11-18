import 'jni.dart' as jni;

abstract interface class ProxyInfo {}

final class ProxyInfoImpl implements ProxyInfo {
  final jni.ProxyInfo api;

  ProxyInfoImpl.jni(this.api);
}

extension ProxyInfoX on ProxyInfo {
  jni.ProxyInfo get api {
    final impl = this;
    if (impl is! ProxyInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension JProxyInfoX on jni.ProxyInfo {
  ProxyInfo get impl => ProxyInfoImpl.jni(this);
}
