import '../jni.dart' as jni;

abstract interface class MloLink {}

final class MloLinkImpl implements MloLink {
  final jni.MloLink api;

  MloLinkImpl.jni(this.api);
}

extension JMloLinkX on jni.MloLink {
  MloLink get impl => MloLinkImpl.jni(this);
}
