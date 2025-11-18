import 'jni.dart' as jni;

abstract interface class UrlConnection {}

final class UrlConnectionImpl implements UrlConnection {
  final jni.URLConnection api;

  UrlConnectionImpl.jni(this.api);
}

extension JUrlConnectionX on jni.URLConnection {
  UrlConnection get impl => UrlConnectionImpl.jni(this);
}
