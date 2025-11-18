import 'jni.dart' as jni;

abstract interface class SocketFactory {}

final class SocketFactoryImpl implements SocketFactory {
  final jni.SocketFactory api;

  SocketFactoryImpl.jni(this.api);
}

extension JSocketFactoryX on jni.SocketFactory {
  SocketFactory get impl => SocketFactoryImpl.jni(this);
}
