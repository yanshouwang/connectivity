import 'dart:typed_data';

import 'inet_address.dart';
import 'inet_socket_address.dart';
import 'ip_sec_manager.dart';
import 'jni.dart' as jni;
import 'link_properties.dart';
import 'network.dart';
import 'network_capabilities.dart';
import 'network_info.dart';
import 'network_request.dart';
import 'proxy_info.dart';
import 'socket_keepalive.dart';

enum ConnectivityManager$Type {
  mobile,
  wifi,
  mobileMms,
  mobileSupl,
  mobileDun,
  mobileHipri,
  wimax,
  bluetooth,
  dummy,
  ethernet,
  vpn,
}

enum ConnectivityManager$RestrictBackgroundStatus {
  disabled,
  whitelisted,
  enabled,
}

abstract interface class ConnectivityManager$NetworkCallback {
  factory ConnectivityManager$NetworkCallback({
    bool includeLocationInfo = false,
    void Function(Network network)? onAvailable,
    void Function(Network network, bool blocked)? onBlockedStatusChanged,
    void Function(Network network, NetworkCapabilities networkCapabilities)?
    onCapabilitiesChanged,
    void Function(Network network, LinkProperties linkProperties)?
    onLinkPropertiesChanged,
    void Function(Network network, int maxMsToLive)? onLosing,
    void Function(Network network)? onLost,
    void Function(NetworkCapabilities networkCapabilities)? onReserved,
    void Function()? onUnavailable,
  }) => ConnectivityManager$NetworkCallbackImpl(
    includeLocationInfo: includeLocationInfo,
    onAvailable: onAvailable,
    onBlockedStatusChanged: onBlockedStatusChanged,
    onCapabilitiesChanged: onCapabilitiesChanged,
    onLinkPropertiesChanged: onLinkPropertiesChanged,
    onLosing: onLosing,
    onLost: onLost,
    onReserved: onReserved,
    onUnavailable: onUnavailable,
  );
}

abstract interface class ConnectivityManager$OnNetworkActiveListener {
  factory ConnectivityManager$OnNetworkActiveListener({
    required void Function() onNetworkActive,
  }) => ConnectivityManager$OnNetworkActiveListenerImpl(
    onNetworkActive: onNetworkActive,
  );
}

abstract interface class ConnectivityManager {
  static Network? getProcessDefaultNetwork() =>
      ConnectivityManagerImpl.getProcessDefaultNetwork();
  static bool isNetworkTypeValid(ConnectivityManager$Type networkType) =>
      ConnectivityManagerImpl.isNetworkTypeValid(networkType);
  static bool setProcessDefaultNetwork(Network network) =>
      ConnectivityManagerImpl.setProcessDefaultNetwork(network);

  factory ConnectivityManager() => ConnectivityManagerImpl();

  Network? get activeNetwork;
  NetworkInfo? get activeNetworkInfo;
  List<NetworkInfo> get allNetworkInfo;
  List<Network> get allNetworks;
  bool get backgroundDataSetting;
  Network? get boundNetworkForProcess;
  ProxyInfo? get defaultProxy;
  int get networkPreference;
  set networkPreference(int preference);
  Uint8List? get networkWatchlistConfigHash;
  ConnectivityManager$RestrictBackgroundStatus get restrictBackgroundStatus;
  bool get isActiveNetworkMetered;
  bool get isDefaultNetworkActive;

  void addDefaultNetworkActiveListener(
    ConnectivityManager$OnNetworkActiveListener listener,
  );
  void removeDefaultNetworkActiveListener(
    ConnectivityManager$OnNetworkActiveListener listener,
  );

  void registerBestMatchingNetworkCallback(
    NetworkRequest request,
    ConnectivityManager$NetworkCallback networkCallback,
  );
  void registerDefaultNetworkCallback(
    ConnectivityManager$NetworkCallback networkCallback,
  );
  void registerNetworkCallback(
    NetworkRequest request,
    ConnectivityManager$NetworkCallback networkCallback,
  );
  void unregisterNetworkCallback(
    ConnectivityManager$NetworkCallback networkCallback,
  );

  bool bindProcessToNetwork(Network network);
  SocketKeepalive createSocketKeepalive(
    Network network,
    IpSecManager$UdpEncapsulationSocket socket,
    InetAddress source,
    InetAddress destination,
    SocketKeepalive$Callback callback,
  );
  int getConnectionOwnerUid(
    int protocol,
    InetSocketAddress local,
    InetSocketAddress remote,
  );
  LinkProperties? getLinkProperties(Network network);
  int getMultipathPreference(Network network);
  NetworkCapabilities? getNetworkCapabilities(Network network);
  NetworkInfo? getNetworkInfoOfType(ConnectivityManager$Type networkType);
  NetworkInfo? getNetworkInfoOfNetwork(Network network);
  void reportBadNetwork(Network network);
  void reportNetworkConnectivity(Network network, bool hasConnectivity);
  bool requestBandwidthUpdate(Network network);
  void requestNetwork(
    NetworkRequest request,
    ConnectivityManager$NetworkCallback networkCallback, [
    int? timeoutMs,
  ]);
  void reserveNetwork(
    NetworkRequest request,
    ConnectivityManager$NetworkCallback networkCallback,
  );
}

final class ConnectivityManager$NetworkCallbackImpl
    implements ConnectivityManager$NetworkCallback {
  final jni.ConnectivityManager$NetworkCallback api;

  ConnectivityManager$NetworkCallbackImpl.jni(this.api);

  factory ConnectivityManager$NetworkCallbackImpl({
    bool includeLocationInfo = false,
    void Function(Network network)? onAvailable,
    void Function(Network network, bool blocked)? onBlockedStatusChanged,
    void Function(Network network, NetworkCapabilities networkCapabilities)?
    onCapabilitiesChanged,
    void Function(Network network, LinkProperties linkProperties)?
    onLinkPropertiesChanged,
    void Function(Network network, int maxMsToLive)? onLosing,
    void Function(Network network)? onLost,
    void Function(NetworkCapabilities networkCapabilities)? onReserved,
    void Function()? onUnavailable,
  }) {
    final callback = jni.JConnectivityManager$JNetworkCallback.implement(
      jni.$JConnectivityManager$JNetworkCallback(
        onAvailable: (e) => onAvailable?.call(e.impl),
        onBlockedStatusChanged: (e1, e2) =>
            onBlockedStatusChanged?.call(e1.impl, e2),
        onCapabilitiesChanged: (e1, e2) =>
            onCapabilitiesChanged?.call(e1.impl, e2.impl),
        onLinkPropertiesChanged: (e1, e2) =>
            onLinkPropertiesChanged?.call(e1.impl, e2.impl),
        onLosing: (e1, e2) => onLosing?.call(e1.impl, e2),
        onLost: (e) => onLost?.call(e.impl),
        onReserved: (e) => onReserved?.call(e.impl),
        onUnavailable: () => onUnavailable?.call(),
      ),
    );
    final api = includeLocationInfo
        ? jni.JConnectivityManager$JNetworkCallbackImpl.new$3(
            callback,
            jni.ConnectivityManager$NetworkCallback.FLAG_INCLUDE_LOCATION_INFO,
          )
        : jni.JConnectivityManager$JNetworkCallbackImpl.new$2(callback);
    return ConnectivityManager$NetworkCallbackImpl.jni(api);
  }
}

final class ConnectivityManager$OnNetworkActiveListenerImpl
    implements ConnectivityManager$OnNetworkActiveListener {
  final jni.ConnectivityManager$OnNetworkActiveListener api;

  ConnectivityManager$OnNetworkActiveListenerImpl.jni(this.api);

  factory ConnectivityManager$OnNetworkActiveListenerImpl({
    required void Function() onNetworkActive,
  }) {
    final api = jni.ConnectivityManager$OnNetworkActiveListener.implement(
      jni.$ConnectivityManager$OnNetworkActiveListener(
        onNetworkActive: onNetworkActive,
      ),
    );
    return ConnectivityManager$OnNetworkActiveListenerImpl.jni(api);
  }
}

final class ConnectivityManagerImpl implements ConnectivityManager {
  static Network? getProcessDefaultNetwork() =>
      jni.ConnectivityManager.getProcessDefaultNetwork()?.impl;

  static bool isNetworkTypeValid(ConnectivityManager$Type networkType) =>
      jni.ConnectivityManager.isNetworkTypeValid(networkType.api);

  static bool setProcessDefaultNetwork(Network network) =>
      jni.ConnectivityManager.setProcessDefaultNetwork(network.api);

  final jni.ConnectivityManager api;

  ConnectivityManagerImpl.jni(this.api);

  factory ConnectivityManagerImpl() {
    final apiOrNull = jni.ContextCompat.getSystemService(
      jni.context,
      jni.ConnectivityManager.type.jClass,
      T: jni.ConnectivityManager.type,
    );
    final api = ArgumentError.checkNotNull(apiOrNull, 'api');
    return ConnectivityManagerImpl.jni(api);
  }

  @override
  Network? get activeNetwork => api.getActiveNetwork()?.impl;

  @override
  NetworkInfo? get activeNetworkInfo => api.getActiveNetworkInfo()?.impl;

  @override
  List<NetworkInfo> get allNetworkInfo =>
      api.getAllNetworkInfo().nonNulls.map((e) => e.impl).toList();

  @override
  List<Network> get allNetworks =>
      api.getAllNetworks().nonNulls.map((e) => e.impl).toList();

  @override
  bool get backgroundDataSetting => api.getBackgroundDataSetting();

  @override
  Network? get boundNetworkForProcess => api.getBoundNetworkForProcess()?.impl;

  @override
  ProxyInfo? get defaultProxy => api.getDefaultProxy()?.impl;

  @override
  int get networkPreference => api.getNetworkPreference();

  @override
  set networkPreference(int preference) => api.setNetworkPreference(preference);

  @override
  Uint8List? get networkWatchlistConfigHash =>
      api.getNetworkWatchlistConfigHash()?.impl;

  @override
  ConnectivityManager$RestrictBackgroundStatus get restrictBackgroundStatus =>
      api
          .getRestrictBackgroundStatus()
          .connectivityManagerRestrictBackgroundStatusImpl;

  @override
  bool get isActiveNetworkMetered => api.isActiveNetworkMetered();

  @override
  bool get isDefaultNetworkActive => api.isDefaultNetworkActive();

  @override
  void addDefaultNetworkActiveListener(
    ConnectivityManager$OnNetworkActiveListener listener,
  ) => api.addDefaultNetworkActiveListener(listener.api);

  @override
  bool bindProcessToNetwork(Network network) =>
      api.bindProcessToNetwork(network.api);

  @override
  SocketKeepalive createSocketKeepalive(
    Network network,
    IpSecManager$UdpEncapsulationSocket socket,
    InetAddress source,
    InetAddress destination,
    SocketKeepalive$Callback callback,
  ) => api
      .createSocketKeepalive(
        network.api,
        socket.api,
        source.api,
        destination.api,
        jni.context.mainExecutor,
        callback.api,
      )
      .impl;

  @override
  int getConnectionOwnerUid(
    int protocol,
    InetSocketAddress local,
    InetSocketAddress remote,
  ) => api.getConnectionOwnerUid(protocol, local.api, remote.api);

  @override
  LinkProperties? getLinkProperties(Network network) =>
      api.getLinkProperties(network.api)?.impl;

  @override
  int getMultipathPreference(Network network) =>
      api.getMultipathPreference(network.api);

  @override
  NetworkCapabilities? getNetworkCapabilities(Network network) =>
      api.getNetworkCapabilities(network.api)?.impl;

  @override
  NetworkInfo? getNetworkInfoOfType(ConnectivityManager$Type networkType) =>
      api.getNetworkInfo$1(networkType.api)?.impl;

  @override
  NetworkInfo? getNetworkInfoOfNetwork(Network network) =>
      api.getNetworkInfo(network.api)?.impl;

  @override
  void registerBestMatchingNetworkCallback(
    NetworkRequest request,
    ConnectivityManager$NetworkCallback networkCallback,
  ) => api.registerBestMatchingNetworkCallback(
    request.api,
    networkCallback.api,
    jni.context.mainHandler,
  );

  @override
  void registerDefaultNetworkCallback(
    ConnectivityManager$NetworkCallback networkCallback,
  ) => api.registerDefaultNetworkCallback(networkCallback.api);

  @override
  void registerNetworkCallback(
    NetworkRequest request,
    ConnectivityManager$NetworkCallback networkCallback,
  ) => api.registerNetworkCallback$1(request.api, networkCallback.api);

  @override
  void removeDefaultNetworkActiveListener(
    ConnectivityManager$OnNetworkActiveListener listener,
  ) => api.removeDefaultNetworkActiveListener(listener.api);

  @override
  void reportBadNetwork(Network network) => api.reportBadNetwork(network.api);

  @override
  void reportNetworkConnectivity(Network network, bool hasConnectivity) =>
      api.reportNetworkConnectivity(network.api, hasConnectivity);

  @override
  bool requestBandwidthUpdate(Network network) =>
      api.requestBandwidthUpdate(network.api);

  @override
  void requestNetwork(
    NetworkRequest request,
    ConnectivityManager$NetworkCallback networkCallback, [
    int? timeoutMs,
  ]) => timeoutMs == null
      ? api.requestNetwork$1(request.api, networkCallback.api)
      : api.requestNetwork$4(request.api, networkCallback.api, timeoutMs);

  @override
  void reserveNetwork(
    NetworkRequest request,
    ConnectivityManager$NetworkCallback networkCallback,
  ) => api.reserveNetwork(
    request.api,
    jni.context.mainHandler,
    networkCallback.api,
  );

  @override
  void unregisterNetworkCallback(
    ConnectivityManager$NetworkCallback networkCallback,
  ) => api.unregisterNetworkCallback$1(networkCallback.api);
}

extension ConnectivityManager$intX on int {
  ConnectivityManager$RestrictBackgroundStatus
  get connectivityManagerRestrictBackgroundStatusImpl {
    switch (this) {
      case jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_DISABLED:
        return ConnectivityManager$RestrictBackgroundStatus.disabled;
      case jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_WHITELISTED:
        return ConnectivityManager$RestrictBackgroundStatus.whitelisted;
      case jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_ENABLED:
        return ConnectivityManager$RestrictBackgroundStatus.enabled;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }
}

extension ConnectivityManagerTypeX on ConnectivityManager$Type {
  int get api {
    switch (this) {
      case ConnectivityManager$Type.mobile:
        return jni.ConnectivityManager.TYPE_MOBILE;
      case ConnectivityManager$Type.wifi:
        return jni.ConnectivityManager.TYPE_WIFI;
      case ConnectivityManager$Type.mobileMms:
        return jni.ConnectivityManager.TYPE_MOBILE_MMS;
      case ConnectivityManager$Type.mobileSupl:
        return jni.ConnectivityManager.TYPE_MOBILE_SUPL;
      case ConnectivityManager$Type.mobileDun:
        return jni.ConnectivityManager.TYPE_MOBILE_DUN;
      case ConnectivityManager$Type.mobileHipri:
        return jni.ConnectivityManager.TYPE_MOBILE_HIPRI;
      case ConnectivityManager$Type.wimax:
        return jni.ConnectivityManager.TYPE_WIMAX;
      case ConnectivityManager$Type.bluetooth:
        return jni.ConnectivityManager.TYPE_BLUETOOTH;
      case ConnectivityManager$Type.dummy:
        return jni.ConnectivityManager.TYPE_DUMMY;
      case ConnectivityManager$Type.ethernet:
        return jni.ConnectivityManager.TYPE_ETHERNET;
      case ConnectivityManager$Type.vpn:
        return jni.ConnectivityManager.TYPE_VPN;
    }
  }
}

extension ConnectivityManager$NetworkCallbackX
    on ConnectivityManager$NetworkCallback {
  jni.ConnectivityManager$NetworkCallback get api {
    final impl = this;
    if (impl is! ConnectivityManager$NetworkCallbackImpl) throw TypeError();
    return impl.api;
  }
}

extension ConnectivityManager$OnNetworkActiveListenerX
    on ConnectivityManager$OnNetworkActiveListener {
  jni.ConnectivityManager$OnNetworkActiveListener get api {
    final impl = this;
    if (impl is! ConnectivityManager$OnNetworkActiveListenerImpl) {
      throw TypeError();
    }
    return impl.api;
  }
}
