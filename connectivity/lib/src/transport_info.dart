import 'jni.dart' as jni;
import 'wifi.dart';

abstract interface class TransportInfo {}

abstract base class TransportInfoImpl implements TransportInfo {
  // jni.TransportInfo get api;
  jni.JObject get api;
}

extension JTransportInfoX on jni.TransportInfo {
  TransportInfo get impl {
    final api = this;
    final isWifi = api.isInstanceOf(jni.WifiInfo.type.jClass);
    if (isWifi) {
      return api.as(jni.WifiInfo.type).impl;
    }
    final isWifiAwareNetwork = api.isInstanceOf(
      jni.WifiAwareNetworkInfo.type.jClass,
    );
    if (isWifiAwareNetwork) {
      return api.as(jni.WifiAwareNetworkInfo.type).impl;
    }
    throw TypeError();
  }
}
