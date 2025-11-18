import 'jni.dart' as jni;

abstract interface class InetSocketAddress {}

final class InetSocketAddressImpl implements InetSocketAddress {
  final jni.InetSocketAddress api;

  InetSocketAddressImpl.jni(this.api);
}

extension InetSocketAddressX on InetSocketAddress {
  jni.InetSocketAddress get api {
    final impl = this;
    if (impl is! InetSocketAddressImpl) throw TypeError();
    return impl.api;
  }
}
