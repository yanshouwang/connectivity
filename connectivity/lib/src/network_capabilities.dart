import 'jni.dart' as jni;
import 'network_specifier.dart';
import 'transport_info.dart';

enum NetworkCapabilities$NetCapability {
  mms,
  supl,
  dun,
  fota,
  ims,
  cbs,
  wifiP2p,
  ia,
  rcs,
  xcap,
  eims,
  notMetered,
  internet,
  notRestricted,
  trusted,
  notVpn,
  validated,
  captivePortal,
  notRoaming,
  foreground,
  notCongested,
  notSuspended,
  mcx,
  temporarilyNotMetered,
  enterprise,
  headUnit,
  mmtel,
  prioritizeLatency,
  prioritizeBandwidth,
  localNetwork,
  notBandwidthConstrained,
}

enum NetworkCapabilities$Transport {
  cellular,
  wifi,
  bluetooth,
  ethernet,
  vpn,
  wifiAware,
  lowpan,
  usb,
  thread,
  satellite,
}

abstract interface class NetworkCapabilities {
  List<NetworkCapabilities$NetCapability> get capabilities;
  List<int> get enterpriseIds;
  int get linkDownstreamBandwidthKbps;
  int get linkUpstreamBandwidthKbps;
  NetworkSpecifier? get networkSpecifier;
  int get ownerUid;
  int get signalStrength;
  Set<int> get subscriptionIds;
  TransportInfo? get transportInfo;
  bool hasCapability(NetworkCapabilities$NetCapability capability);
  bool hasEnterpriseId(int enterpriseId);
  bool hasTransport(NetworkCapabilities$Transport transportType);
}

final class NetworkCapabilitiesImpl implements NetworkCapabilities {
  final jni.NetworkCapabilities api;

  NetworkCapabilitiesImpl.jni(this.api);

  @override
  List<NetworkCapabilities$NetCapability> get capabilities => api
      .getCapabilities()
      .map((e) => e.networkCapabilities$NetCapabilityImpl)
      .toList();

  @override
  List<int> get enterpriseIds => api.getEnterpriseIds().toList();

  @override
  int get linkDownstreamBandwidthKbps => api.getLinkDownstreamBandwidthKbps();

  @override
  int get linkUpstreamBandwidthKbps => api.getLinkUpstreamBandwidthKbps();

  @override
  NetworkSpecifier? get networkSpecifier => api.getNetworkSpecifier()?.impl;

  @override
  int get ownerUid => api.getOwnerUid();

  @override
  int get signalStrength => api.getSignalStrength();

  @override
  Set<int> get subscriptionIds =>
      api.getSubscriptionIds().nonNulls.map((e) => e.impl).toSet();

  @override
  TransportInfo? get transportInfo => api.getTransportInfo()?.impl;

  @override
  bool hasCapability(NetworkCapabilities$NetCapability capability) =>
      api.hasCapability(capability.api);

  @override
  bool hasEnterpriseId(int enterpriseId) => api.hasEnterpriseId(enterpriseId);

  @override
  bool hasTransport(NetworkCapabilities$Transport transportType) =>
      api.hasTransport(transportType.api);
}

extension NetworkCapabilities$intX on int {
  NetworkCapabilities$NetCapability get networkCapabilities$NetCapabilityImpl {
    switch (this) {
      case jni.NetworkCapabilities.NET_CAPABILITY_MMS:
        return NetworkCapabilities$NetCapability.mms;
      case jni.NetworkCapabilities.NET_CAPABILITY_SUPL:
        return NetworkCapabilities$NetCapability.supl;
      case jni.NetworkCapabilities.NET_CAPABILITY_DUN:
        return NetworkCapabilities$NetCapability.dun;
      case jni.NetworkCapabilities.NET_CAPABILITY_FOTA:
        return NetworkCapabilities$NetCapability.fota;
      case jni.NetworkCapabilities.NET_CAPABILITY_IMS:
        return NetworkCapabilities$NetCapability.ims;
      case jni.NetworkCapabilities.NET_CAPABILITY_CBS:
        return NetworkCapabilities$NetCapability.cbs;
      case jni.NetworkCapabilities.NET_CAPABILITY_WIFI_P2P:
        return NetworkCapabilities$NetCapability.wifiP2p;
      case jni.NetworkCapabilities.NET_CAPABILITY_IA:
        return NetworkCapabilities$NetCapability.ia;
      case jni.NetworkCapabilities.NET_CAPABILITY_RCS:
        return NetworkCapabilities$NetCapability.rcs;
      case jni.NetworkCapabilities.NET_CAPABILITY_XCAP:
        return NetworkCapabilities$NetCapability.xcap;
      case jni.NetworkCapabilities.NET_CAPABILITY_EIMS:
        return NetworkCapabilities$NetCapability.eims;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_METERED:
        return NetworkCapabilities$NetCapability.notMetered;
      case jni.NetworkCapabilities.NET_CAPABILITY_INTERNET:
        return NetworkCapabilities$NetCapability.internet;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED:
        return NetworkCapabilities$NetCapability.notRestricted;
      case jni.NetworkCapabilities.NET_CAPABILITY_TRUSTED:
        return NetworkCapabilities$NetCapability.trusted;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_VPN:
        return NetworkCapabilities$NetCapability.notVpn;
      case jni.NetworkCapabilities.NET_CAPABILITY_VALIDATED:
        return NetworkCapabilities$NetCapability.validated;
      case jni.NetworkCapabilities.NET_CAPABILITY_CAPTIVE_PORTAL:
        return NetworkCapabilities$NetCapability.captivePortal;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_ROAMING:
        return NetworkCapabilities$NetCapability.notRoaming;
      case jni.NetworkCapabilities.NET_CAPABILITY_FOREGROUND:
        return NetworkCapabilities$NetCapability.foreground;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_CONGESTED:
        return NetworkCapabilities$NetCapability.notCongested;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_SUSPENDED:
        return NetworkCapabilities$NetCapability.notSuspended;
      case jni.NetworkCapabilities.NET_CAPABILITY_MCX:
        return NetworkCapabilities$NetCapability.mcx;
      case jni.NetworkCapabilities.NET_CAPABILITY_TEMPORARILY_NOT_METERED:
        return NetworkCapabilities$NetCapability.temporarilyNotMetered;
      case jni.NetworkCapabilities.NET_CAPABILITY_ENTERPRISE:
        return NetworkCapabilities$NetCapability.enterprise;
      case jni.NetworkCapabilities.NET_CAPABILITY_HEAD_UNIT:
        return NetworkCapabilities$NetCapability.headUnit;
      case jni.NetworkCapabilities.NET_CAPABILITY_MMTEL:
        return NetworkCapabilities$NetCapability.mmtel;
      case jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_LATENCY:
        return NetworkCapabilities$NetCapability.prioritizeLatency;
      case jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_BANDWIDTH:
        return NetworkCapabilities$NetCapability.prioritizeBandwidth;
      case jni.NetworkCapabilities.NET_CAPABILITY_LOCAL_NETWORK:
        return NetworkCapabilities$NetCapability.localNetwork;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_BANDWIDTH_CONSTRAINED:
        return NetworkCapabilities$NetCapability.notBandwidthConstrained;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }

  NetworkCapabilities$Transport get networkCapabilities$TransportImpl {
    switch (this) {
      case jni.NetworkCapabilities.TRANSPORT_CELLULAR:
        return NetworkCapabilities$Transport.cellular;
      case jni.NetworkCapabilities.TRANSPORT_WIFI:
        return NetworkCapabilities$Transport.wifi;
      case jni.NetworkCapabilities.TRANSPORT_BLUETOOTH:
        return NetworkCapabilities$Transport.bluetooth;
      case jni.NetworkCapabilities.TRANSPORT_ETHERNET:
        return NetworkCapabilities$Transport.ethernet;
      case jni.NetworkCapabilities.TRANSPORT_VPN:
        return NetworkCapabilities$Transport.vpn;
      case jni.NetworkCapabilities.TRANSPORT_WIFI_AWARE:
        return NetworkCapabilities$Transport.wifiAware;
      case jni.NetworkCapabilities.TRANSPORT_LOWPAN:
        return NetworkCapabilities$Transport.lowpan;
      case jni.NetworkCapabilities.TRANSPORT_USB:
        return NetworkCapabilities$Transport.usb;
      case jni.NetworkCapabilities.TRANSPORT_THREAD:
        return NetworkCapabilities$Transport.thread;
      case jni.NetworkCapabilities.TRANSPORT_SATELLITE:
        return NetworkCapabilities$Transport.satellite;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }
}

extension NetworkCapabilities$NetCapabilityX
    on NetworkCapabilities$NetCapability {
  int get api {
    switch (this) {
      case NetworkCapabilities$NetCapability.mms:
        return jni.NetworkCapabilities.NET_CAPABILITY_MMS;
      case NetworkCapabilities$NetCapability.supl:
        return jni.NetworkCapabilities.NET_CAPABILITY_SUPL;
      case NetworkCapabilities$NetCapability.dun:
        return jni.NetworkCapabilities.NET_CAPABILITY_DUN;
      case NetworkCapabilities$NetCapability.fota:
        return jni.NetworkCapabilities.NET_CAPABILITY_FOTA;
      case NetworkCapabilities$NetCapability.ims:
        return jni.NetworkCapabilities.NET_CAPABILITY_IMS;
      case NetworkCapabilities$NetCapability.cbs:
        return jni.NetworkCapabilities.NET_CAPABILITY_CBS;
      case NetworkCapabilities$NetCapability.wifiP2p:
        return jni.NetworkCapabilities.NET_CAPABILITY_WIFI_P2P;
      case NetworkCapabilities$NetCapability.ia:
        return jni.NetworkCapabilities.NET_CAPABILITY_IA;
      case NetworkCapabilities$NetCapability.rcs:
        return jni.NetworkCapabilities.NET_CAPABILITY_RCS;
      case NetworkCapabilities$NetCapability.xcap:
        return jni.NetworkCapabilities.NET_CAPABILITY_XCAP;
      case NetworkCapabilities$NetCapability.eims:
        return jni.NetworkCapabilities.NET_CAPABILITY_EIMS;
      case NetworkCapabilities$NetCapability.notMetered:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_METERED;
      case NetworkCapabilities$NetCapability.internet:
        return jni.NetworkCapabilities.NET_CAPABILITY_INTERNET;
      case NetworkCapabilities$NetCapability.notRestricted:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED;
      case NetworkCapabilities$NetCapability.trusted:
        return jni.NetworkCapabilities.NET_CAPABILITY_TRUSTED;
      case NetworkCapabilities$NetCapability.notVpn:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_VPN;
      case NetworkCapabilities$NetCapability.validated:
        return jni.NetworkCapabilities.NET_CAPABILITY_VALIDATED;
      case NetworkCapabilities$NetCapability.captivePortal:
        return jni.NetworkCapabilities.NET_CAPABILITY_CAPTIVE_PORTAL;
      case NetworkCapabilities$NetCapability.notRoaming:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_ROAMING;
      case NetworkCapabilities$NetCapability.foreground:
        return jni.NetworkCapabilities.NET_CAPABILITY_FOREGROUND;
      case NetworkCapabilities$NetCapability.notCongested:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_CONGESTED;
      case NetworkCapabilities$NetCapability.notSuspended:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_SUSPENDED;
      case NetworkCapabilities$NetCapability.mcx:
        return jni.NetworkCapabilities.NET_CAPABILITY_MCX;
      case NetworkCapabilities$NetCapability.temporarilyNotMetered:
        return jni.NetworkCapabilities.NET_CAPABILITY_TEMPORARILY_NOT_METERED;
      case NetworkCapabilities$NetCapability.enterprise:
        return jni.NetworkCapabilities.NET_CAPABILITY_ENTERPRISE;
      case NetworkCapabilities$NetCapability.headUnit:
        return jni.NetworkCapabilities.NET_CAPABILITY_HEAD_UNIT;
      case NetworkCapabilities$NetCapability.mmtel:
        return jni.NetworkCapabilities.NET_CAPABILITY_MMTEL;
      case NetworkCapabilities$NetCapability.prioritizeLatency:
        return jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_LATENCY;
      case NetworkCapabilities$NetCapability.prioritizeBandwidth:
        return jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_BANDWIDTH;
      case NetworkCapabilities$NetCapability.localNetwork:
        return jni.NetworkCapabilities.NET_CAPABILITY_LOCAL_NETWORK;
      case NetworkCapabilities$NetCapability.notBandwidthConstrained:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_BANDWIDTH_CONSTRAINED;
    }
  }
}

extension NetworkCapabilities$TransportX on NetworkCapabilities$Transport {
  int get api {
    switch (this) {
      case NetworkCapabilities$Transport.cellular:
        return jni.NetworkCapabilities.TRANSPORT_CELLULAR;
      case NetworkCapabilities$Transport.wifi:
        return jni.NetworkCapabilities.TRANSPORT_WIFI;
      case NetworkCapabilities$Transport.bluetooth:
        return jni.NetworkCapabilities.TRANSPORT_BLUETOOTH;
      case NetworkCapabilities$Transport.ethernet:
        return jni.NetworkCapabilities.TRANSPORT_ETHERNET;
      case NetworkCapabilities$Transport.vpn:
        return jni.NetworkCapabilities.TRANSPORT_VPN;
      case NetworkCapabilities$Transport.wifiAware:
        return jni.NetworkCapabilities.TRANSPORT_WIFI_AWARE;
      case NetworkCapabilities$Transport.lowpan:
        return jni.NetworkCapabilities.TRANSPORT_LOWPAN;
      case NetworkCapabilities$Transport.usb:
        return jni.NetworkCapabilities.TRANSPORT_USB;
      case NetworkCapabilities$Transport.thread:
        return jni.NetworkCapabilities.TRANSPORT_THREAD;
      case NetworkCapabilities$Transport.satellite:
        return jni.NetworkCapabilities.TRANSPORT_SATELLITE;
    }
  }
}

extension NetworkCapabilitiesX on NetworkCapabilities {
  jni.NetworkCapabilities get api {
    final impl = this;
    if (impl is! NetworkCapabilitiesImpl) throw TypeError();
    return impl.api;
  }
}

extension JNetworkCapabilitiesX on jni.NetworkCapabilities {
  NetworkCapabilities get impl => NetworkCapabilitiesImpl.jni(this);
}
