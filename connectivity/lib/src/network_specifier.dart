import 'jni.dart' as jni;

abstract interface class NetworkSpecifier {}

final class NetworkSpecifierImpl implements NetworkSpecifier {
  final jni.NetworkSpecifier api;

  NetworkSpecifierImpl.jni(this.api);
}

extension NetworkSpecifierX on NetworkSpecifier {
  jni.NetworkSpecifier get api {
    final impl = this;
    if (impl is! NetworkSpecifierImpl) throw TypeError();
    return impl.api;
  }
}

extension JNetworkSpecifierX on jni.NetworkSpecifier {
  NetworkSpecifier get impl => NetworkSpecifierImpl.jni(this);
}
