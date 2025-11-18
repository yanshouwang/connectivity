import 'jni.dart' as jni;

abstract interface class NetworkInterface {}

final class NetworkInterfaceImpl implements NetworkInterface {
  final jni.NetworkInterface api;

  NetworkInterfaceImpl.jni(this.api);
}

extension NetworkInterfaceX on NetworkInterface {
  jni.NetworkInterface get api {
    final impl = this;
    if (impl is! NetworkInterfaceImpl) throw TypeError();
    return impl.api;
  }
}
