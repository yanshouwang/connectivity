import 'inet_address.dart';
import 'ip_prefix.dart';
import 'jni.dart' as jni;

enum RouteInfo$RTN { rtnUnicast, rtnUnreachable, rtnThrow }

abstract interface class RouteInfo {
  IpPrefix get destination;
  InetAddress? get gateway;
  String? get interface;
  RouteInfo$RTN get type;
  bool get isDefaultRoute;

  bool hasGateway();
  bool matches(InetAddress destination);
}

final class RouteInfoImpl implements RouteInfo {
  final jni.RouteInfo api;

  RouteInfoImpl.jni(this.api);

  @override
  IpPrefix get destination => api.getDestination().impl;

  @override
  InetAddress? get gateway => api.getGateway()?.impl;

  @override
  String? get interface => api.getInterface()?.impl;

  @override
  RouteInfo$RTN get type => api.getType().routeInfo$RTNImpl;

  @override
  bool get isDefaultRoute => api.isDefaultRoute();

  @override
  bool hasGateway() => api.hasGateway();

  @override
  bool matches(InetAddress destination) => api.matches(destination.api);
}

extension RouteInfo$intX on int {
  RouteInfo$RTN get routeInfo$RTNImpl {
    switch (this) {
      case jni.RouteInfo.RTN_UNICAST:
        return RouteInfo$RTN.rtnUnicast;
      case jni.RouteInfo.RTN_UNREACHABLE:
        return RouteInfo$RTN.rtnUnreachable;
      case jni.RouteInfo.RTN_THROW:
        return RouteInfo$RTN.rtnThrow;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }
}

extension RouteInfoX on RouteInfo {
  jni.RouteInfo get api {
    final impl = this;
    if (impl is! RouteInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension JRouteInfoX on jni.RouteInfo {
  RouteInfo get impl => RouteInfoImpl.jni(this);
}
