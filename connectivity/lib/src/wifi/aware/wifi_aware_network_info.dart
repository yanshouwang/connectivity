import '../../jni.dart' as jni;
import '../../transport_info.dart';

abstract interface class WifiAwareNetworkInfo implements TransportInfo {}

final class WifiAwareNetworkInfoImpl extends TransportInfoImpl
    implements WifiAwareNetworkInfo {
  @override
  final jni.WifiAwareNetworkInfo api;

  WifiAwareNetworkInfoImpl.jni(this.api);
}

extension JWifiAwareNetworkInfoX on jni.WifiAwareNetworkInfo {
  WifiAwareNetworkInfo get impl => WifiAwareNetworkInfoImpl.jni(this);
}
