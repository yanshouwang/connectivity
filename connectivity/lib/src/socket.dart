import 'jni.dart' as jni;

abstract interface class Socket {}

final class SocketImpl implements Socket {
  final jni.Socket api;

  SocketImpl.jni(this.api);
}

extension SocketX on Socket {
  jni.Socket get api {
    final impl = this;
    if (impl is! SocketImpl) throw TypeError();
    return impl.api;
  }
}
