import 'jni.dart' as jni;
import 'network_capabilities.dart';
import 'network_specifier.dart';

abstract interface class NetworkRequest {
  factory NetworkRequest({
    List<NetworkCapabilities$NetCapability>? capabilities,
    List<NetworkCapabilities$Transport>? transportTypes,
    bool? includeOtherUidNetworks,
    NetworkSpecifier? networkSpecifier,
    Set<int>? subIds,
  }) => NetworkRequestImpl(
    capabilities: capabilities,
    transportTypes: transportTypes,
    includeOtherUidNetworks: includeOtherUidNetworks,
    networkSpecifier: networkSpecifier,
    subIds: subIds,
  );

  List<NetworkCapabilities$NetCapability> get capabilities;
  NetworkSpecifier? get networkSpecifier;
  Set<int> get subscriptionIds;
  List<NetworkCapabilities$Transport> get transportTypes;

  bool canBeSatisfiedBy(NetworkCapabilities nc);
  bool hasCapability(NetworkCapabilities$NetCapability capability);
  bool hasTransport(NetworkCapabilities$Transport transportType);
}

final class NetworkRequestImpl implements NetworkRequest {
  final jni.NetworkRequest api;

  NetworkRequestImpl.jni(this.api);

  factory NetworkRequestImpl({
    List<NetworkCapabilities$NetCapability>? capabilities,
    List<NetworkCapabilities$Transport>? transportTypes,
    bool? includeOtherUidNetworks,
    NetworkSpecifier? networkSpecifier,
    Set<int>? subIds,
  }) {
    final builder = jni.NetworkRequest$Builder();
    if (capabilities != null) {
      for (var capability in capabilities) {
        builder.addCapability(capability.api);
      }
    }
    if (transportTypes != null) {
      for (var transportType in transportTypes) {
        builder.addTransportType(transportType.api);
      }
    }
    if (includeOtherUidNetworks != null) {
      builder.setIncludeOtherUidNetworks(includeOtherUidNetworks);
    }
    if (networkSpecifier != null) {
      builder.setNetworkSpecifier(networkSpecifier.api);
    }
    if (subIds != null) {
      builder.setSubscriptionIds(
        subIds.map((e) => e.api).toJSet(jni.JInteger.type),
      );
    }
    final api = builder.build()!;
    return NetworkRequestImpl.jni(api);
  }

  @override
  List<NetworkCapabilities$NetCapability> get capabilities => api
      .getCapabilities()
      .map((e) => e.networkCapabilitiesNetCapabilityImpl)
      .toList();
  @override
  NetworkSpecifier? get networkSpecifier => api.getNetworkSpecifier()?.impl;
  @override
  Set<int> get subscriptionIds =>
      api.getSubscriptionIds().nonNulls.map((e) => e.impl).toSet();
  @override
  List<NetworkCapabilities$Transport> get transportTypes => api
      .getTransportTypes()
      .map((e) => e.networkCapabilitiesTransportImpl)
      .toList();

  @override
  bool canBeSatisfiedBy(NetworkCapabilities nc) => api.canBeSatisfiedBy(nc.api);

  @override
  bool hasCapability(NetworkCapabilities$NetCapability capability) =>
      api.hasCapability(capability.api);

  @override
  bool hasTransport(NetworkCapabilities$Transport transportType) =>
      api.hasTransport(transportType.api);
}

extension NetworkRequestX on NetworkRequest {
  jni.NetworkRequest get api {
    final impl = this;
    if (impl is! NetworkRequestImpl) throw TypeError();
    return impl.api;
  }
}
