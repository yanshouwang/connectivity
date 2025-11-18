import 'jni.dart' as jni;

abstract interface class IpSecManager$UdpEncapsulationSocket {}

final class IpSecManager$UdpEncapsulationSocketImpl
    implements IpSecManager$UdpEncapsulationSocket {
  final jni.IpSecManager$UdpEncapsulationSocket api;

  IpSecManager$UdpEncapsulationSocketImpl.jni(this.api);
}

extension IpSecManager$UdpEncapsulationSocketX
    on IpSecManager$UdpEncapsulationSocket {
  jni.IpSecManager$UdpEncapsulationSocket get api {
    final impl = this;
    if (impl is! IpSecManager$UdpEncapsulationSocketImpl) throw TypeError();
    return impl.api;
  }
}
