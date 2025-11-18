import 'jni.dart' as jni;

abstract interface class MacAddress {}

final class MacAddressImpl implements MacAddress {
  final jni.MacAddress api;

  MacAddressImpl.jni(this.api);
}

extension JMacAddressX on jni.MacAddress {
  MacAddress get impl => MacAddressImpl.jni(this);
}
