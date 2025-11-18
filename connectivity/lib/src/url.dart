import 'jni.dart' as jni;

abstract interface class Url {}

final class UrlImpl implements Url {
  final jni.URL api;

  UrlImpl.jni(this.api);
}

extension UrlX on Url {
  jni.URL get api {
    final impl = this;
    if (impl is! UrlImpl) throw TypeError();
    return impl.api;
  }
}
