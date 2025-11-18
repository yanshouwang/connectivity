import 'jni.dart' as jni;

abstract interface class SocketKeepalive$Callback {}

abstract interface class SocketKeepalive {}

final class SocketKeepalive$CallbackImpl implements SocketKeepalive$Callback {
  jni.SocketKeepalive$Callback api;

  SocketKeepalive$CallbackImpl.jni(this.api);
}

final class SocketKeepaliveImpl implements SocketKeepalive {
  final jni.SocketKeepalive api;

  SocketKeepaliveImpl.jni(this.api);
}

extension SocketKeepalive$CallbackX on SocketKeepalive$Callback {
  jni.SocketKeepalive$Callback get api {
    final impl = this;
    if (impl is! SocketKeepalive$CallbackImpl) throw TypeError();
    return impl.api;
  }
}

extension JSocketKeepaliveX on jni.SocketKeepalive {
  SocketKeepalive get impl => SocketKeepaliveImpl.jni(this);
}
