import 'dart:typed_data';

import 'inet_address.dart';
import 'jni.dart' as jni;

abstract interface class IpPrefix {
  InetAddress get address;
  int get prefixLength;
  Uint8List get rawAddress;

  bool contains(InetAddress address);
}

final class IpPrefixImpl implements IpPrefix {
  final jni.IpPrefix api;

  IpPrefixImpl.jni(this.api);

  @override
  InetAddress get address => api.getAddress().impl;

  @override
  int get prefixLength => api.getPrefixLength();

  @override
  Uint8List get rawAddress => api.getRawAddress().impl;

  @override
  bool contains(InetAddress address) => api.contains(address.api);
}

extension IpPrefixX on IpPrefix {
  jni.IpPrefix get api {
    final impl = this;
    if (impl is! IpPrefixImpl) throw TypeError();
    return impl.api;
  }
}

extension JIpPrefixX on jni.IpPrefix {
  IpPrefix get impl => IpPrefixImpl.jni(this);
}
