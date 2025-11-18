import '../jni.dart' as jni;

abstract interface class ScanResult$InformationElement {}

final class ScanResult$InformationElementImpl
    implements ScanResult$InformationElement {
  final jni.ScanResult$InformationElement api;

  ScanResult$InformationElementImpl.jni(this.api);
}

extension JScanResult$InformationElementX on jni.ScanResult$InformationElement {
  ScanResult$InformationElement get impl =>
      ScanResult$InformationElementImpl.jni(this);
}
