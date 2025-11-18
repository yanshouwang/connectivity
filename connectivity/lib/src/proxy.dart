import 'jni.dart' as jni;

abstract interface class Proxy {}

final class ProxyImpl implements Proxy {
  final jni.Proxy api;

  ProxyImpl.jni(this.api);
}

extension ProxyX on Proxy {
  jni.Proxy get api {
    final impl = this;
    if (impl is! ProxyImpl) throw TypeError();
    return impl.api;
  }
}
