import 'jni.dart' as jni;

abstract interface class DatagramSocket {}

final class DatagramSocketImpl implements DatagramSocket {
  final jni.DatagramSocket api;

  DatagramSocketImpl.jni(this.api);
}

extension DatagramSocketX on DatagramSocket {
  jni.DatagramSocket get api {
    final impl = this;
    if (impl is! DatagramSocketImpl) throw TypeError();
    return impl.api;
  }
}
