import 'inet_address.dart';
import 'jni.dart' as jni;

abstract interface class LinkAddress {
  InetAddress get address;
  int get flags;
  int get prefixLength;
  int get scope;
}

final class LinkAddressImpl implements LinkAddress {
  final jni.LinkAddress api;

  LinkAddressImpl.jni(this.api);

  @override
  InetAddress get address => api.getAddress()!.impl;

  @override
  int get flags => api.getFlags();

  @override
  int get prefixLength => api.getPrefixLength();

  @override
  int get scope => api.getScope();
}

extension LinkAddressX on LinkAddress {
  jni.LinkAddress get api {
    final impl = this;
    if (impl is! LinkAddressImpl) throw TypeError();
    return impl.api;
  }
}

extension JLinkAddressX on jni.LinkAddress {
  LinkAddress get impl => LinkAddressImpl.jni(this);
}
