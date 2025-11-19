import '../dhcp_info.dart';
import '../jni.dart' as jni;
import 'wifi_configuration.dart';
import 'wifi_info.dart';

enum WifiManager$WifiState {
  disabling, // 0
  disabled, // 1
  enabling, // 2
  enabled, // 3
  unknown, // 4
}

abstract interface class WifiManager$WifiStateChangedListener {
  factory WifiManager$WifiStateChangedListener({
    required void Function() onWifiStateChanged,
  }) => jni.Build$VERSION.SDK_INT >= jni.Build$VERSION_CODES.BAKLAVA
      ? WifiManager$WifiStateChangedListenerImpl36(
          onWifiStateChanged: onWifiStateChanged,
        )
      : WifiManager$WifiStateChangedListenerImpl(
          onWifiStateChanged: onWifiStateChanged,
        );
}

abstract interface class WifiManager {
  factory WifiManager() => WifiManagerImpl();

  List<WifiConfiguration> get configuredNetworks;
  WifiInfo get connectionInfo;
  DhcpInfo get dhcpInfo;
  WifiManager$WifiState get wifiState;
  bool get isWifiEnabled;

  // static int calculateSignalLevel(int rssi, int numLevels) =>
  //     WifiManagerImpl.calculateSignalLevel(rssi, numLevels);

  // static int compareSignalLevel(int rssiA, int rssiB) =>
  //     WifiManagerImpl.compareSignalLevel(rssiA, rssiB);

  // void addLocalOnlyConnectionFailureListener(
  //   WifiManager$LocalOnlyConnectionFailureListener
  //   addLocalOnlyConnectionFailureListener,
  // );

  int addNetwork(WifiConfiguration config);

  // WifiManagerAddNetworkResult addNetworkPrivileged(WifiConfiguration config);
  // int addNetworkSuggestions(List<WifiNetworkSuggestion> networkSuggestions);
  // void addOrUpdatePasspointConfiguration(PasspointConfiguration config);
  // void addSuggestionConnectionStatusListener(
  //   WifiManagerSuggestionConnectionStatusListener listener,
  // );
  // void addSuggestionUserApprovalStatusListener(
  //   WifiManagerSuggestionUserApprovalStatusListener listener,
  // );
  void addWifiStateChangedListener(
    WifiManager$WifiStateChangedListener listener,
  );
  // void allowAutojoinGlobal(bool allowAutojoin);
  // int calculateSignalLevel(int rssi);
  // void cancelWps(WifiManagerWpsCallback listener);
  // WifiManagerMulticastLock createMulticastLock(String tag);
  // WifiManagerWifiLock createWifiLock(WifiManagerWifiMode lockType, String tag);
  // WifiManagerWifiLock createWifiLock(String tag);
  bool disableNetwork(int netId);
  // void disallowCurrentSuggestedNetwork(BlockingOption blockingOption);
  bool disconnect();
  bool enableNetwork(int nedId, bool attemptConnect);
  // void flushPasspointAnqpCache();
  // List<WifiAvailableChannel> getAllowedChannels(int band, int mode);
  // List<WifiConfiguration> getCallerConfiguredNetworks();
  // void getChannelData(Consumer<List<Bundle>> resultsCallback);
  // int getMaxNumberOfChannelsPerNetworkSpecifierRequest();
  // int getMaxNumberOfNetworkSuggestionsPerApp();
  // int getMaxSignalLevel();
  // void getMaxSupportedConcurrentTdlsSessions(Consumer<int> resultsCallback);
  // List<WifiNetworkSuggestion> getNetworkSuggestions();
  // void getNumberOfEnabledTdlsSessions(Consumer<int> resultsCallback);
  // List<PasspointConfiguration> getPasspointConfigurations();
  // void getPerSsidRoamingModes(Consumer<Map<String, int>> resultsCallback);
  // List<ScanResult> getScanResults();
  // int getStaConcurrencyForMultiInternetMode();
  // List<WifiAvailableChannel> getUsableChannels(int band, int mode);
  // bool is24GHzBandSupported();
  // bool is5GHzBandSupported();
  // bool is60GHzBandSupported();
  // bool is6GHzBandSupported();
  // bool isAggressiveRoamingModeSupported();
  // bool isAutoWakeupEnabled();
  // bool isBridgedApConcurrencySupported();
  // bool isCarrierNetworkOffloadEnabled();
  // bool isD2dSupportedWhenInfraStaDisabled();
  // bool isDecoratedIdentitySupported();
  // bool isDeviceToApRttSupported();
  // bool isDualBandSimultaneousSupported();
  // bool isEasyConnectDppAkmSupported();
  // bool isEasyConnectEnrolleeResponderModeSupported();
  // bool isEasyConnectSupported();
  // bool isEnhancedOpenSupported();
  // bool isEnhancedPowerReportingSupported();
  // bool isMakeBeforeBreakWifiSwitchingSupported();
  // bool isP2pSupported();
  // bool isPasspointTermsAndConditionsSupported();
  // bool isPreferredNetworkOffloadSupported();
  // bool isScanAlwaysAvailable();
  // bool isScanThrottleEnabled();
  // bool isStaApConcurrencySupported();
  // bool isStaBridgedApConcurrencySupported();
  // bool isStaConcurrencyForLocalOnlyConnectionsSupported();
  // bool isStaConcurrencyForMultiInternetSupported();
  // void isTdlsOperationCurrentlyAvailable(Consumer<bool> resultsCallback);
  // bool isTdlsSupported();
  // bool isTidToLinkMappingNegotiationSupported();
  // bool isTlsMinimumVersionSupported();
  // bool isTlsV13Supported();
  // bool isTrustOnFirstUseSupported();
  // bool isWapiSupported();
  // bool isWepSupporeted();
  // bool isWifiDisplayR2Supporeted();
  // bool isWifiPasspointEnabled();
  // bool isWifiStandardSupported(int standard);
  // bool isWpa3SaeH2eSupported();
  // bool isWpa3SaePublicKeySupported();
  // bool isWpa3SaeSupported();
  // bool isWpa3SuiteBSupported();
  // bool isWpaPersonalSupported();
  // bool pingSupplicant();
  // void queryAutojoinGlobal(Consumer<bool> resultsCallback);
  // void querySendDhcpHostnameRestriction(Consumer<int> resultsCallback);
  bool reassociate();
  bool reconnect();
  // void registerScanResultsCallback(WifiManagerScanResultsCallback callback);
  // void registerSubsystemRestartTrackingCallback(
  //   WifiManagerSubsystemRestartTrackingCallback callback,
  // );
  // void removeLocalOnlyConnectionFailureListener(
  //   WifiManagerLocalOnlyConnectionFailureListener listener,
  // );
  bool removeNetwork(int netId);
  // int removeNetworkSuggestions(List<WifiNetworkSuggestion> networkSuggestions);
  // int removeNetworkSuggestions(
  //   List<wifiNetworkSuggestion> networkSuggestions,
  //   int action,
  // );
  bool removeNonCallerConfiguredNetworks();
  // void removePasspointConfiguration(String fqdn);
  // void removePerSsidRoamingMode(WifiSsid ssid);
  // void removeSuggestionConnectionStatusListener(
  //   WifiManagerSuggestionConnectionStatusListener listener,
  // );
  // void removeSuggestionUserApprovalStatusListener(
  //   WifiManagerSuggestionUserApprovalStatusListener listener,
  // );
  void removeWifiStateChangedListener(
    WifiManager$WifiStateChangedListener listener,
  );
  // void reportCreateInterfaceImpact(
  //   int interfaceType,
  //   Consumer<(bool, Set<WifiManagerInterfaceCreationImpact>)> resultCallback,
  // );
  bool saveConfiguration();
  // void setPerSsidRoamingMode(WifiSsid ssid, int roamingMode);
  // void setSendDhcpHostnameRestriction(int restriction);
  // void setTdlsEnabled(InetAddress remoteIPAddress, bool enable);
  // void setTdlsEnabled(
  //   InetAddress remoteIPAddress,
  //   bool enable,
  //   Consumer<bool> resultsCallback,
  // );
  // void setTdlsEnabledWithMacAddress(String remoteMacAddress, bool enable);
  // void setTdlsEnabledWithMacAddress(
  //   String remoteMacAddress,
  //   bool enable,
  //   Consumer<bool> resultsCallback,
  // );
  bool setWifiEnabled(bool enabled);
  // void startLocalOnlyHotspot(WifiManagerLocalOnlyHotspotCallback callback);
  // void startLocalOnlyHotspotWithConfiguration(
  //   SoftApConfiguration config,
  //   WifiManagerLocalHotspotCallback callback,
  // );
  // bool startScan();
  // void startWps(WpsInfo config, WifiManagerWpsCallback listener);
  // void unregisterSubsystemRestartTrackingCallback(
  //   WifiManagerSubsystemRestartTrackingCallback callback,
  // );
  int updateNetwork(WifiConfiguration config);
  // bool validateSoftApConfiguration(SoftApConfiguration config);
}

final class WifiManager$WifiStateChangedListenerImpl36
    implements WifiManager$WifiStateChangedListener {
  final jni.WifiManager$WifiStateChangedListener api;

  WifiManager$WifiStateChangedListenerImpl36.jni(this.api);

  factory WifiManager$WifiStateChangedListenerImpl36({
    required void Function() onWifiStateChanged,
  }) {
    final api = jni.WifiManager$WifiStateChangedListener.implement(
      jni.$WifiManager$WifiStateChangedListener(
        onWifiStateChanged: onWifiStateChanged,
      ),
    );
    return WifiManager$WifiStateChangedListenerImpl36.jni(api);
  }
}

final class WifiManager$WifiStateChangedListenerImpl
    implements WifiManager$WifiStateChangedListener {
  final jni.BroadcastReceiver api;

  WifiManager$WifiStateChangedListenerImpl.jni(this.api);

  factory WifiManager$WifiStateChangedListenerImpl({
    required void Function() onWifiStateChanged,
  }) {
    final api = jni.JBroadcastReceiverImpl(
      jni.JBroadcastReceiver.implement(
        jni.$JBroadcastReceiver(
          onReceive: (context, intent) {
            final action = intent.getAction();
            if (action != jni.WifiManager.WIFI_STATE_CHANGED_ACTION) return;
            onWifiStateChanged();
          },
        ),
      ),
    );
    return WifiManager$WifiStateChangedListenerImpl.jni(api);
  }
}

final class WifiManagerImpl implements WifiManager {
  final jni.WifiManager api;

  WifiManagerImpl.jni(this.api);

  factory WifiManagerImpl() {
    final apiOrNull = jni.ContextCompat.getSystemService(
      jni.context,
      jni.WifiManager.type.jClass,
      T: jni.WifiManager.type,
    );
    final api = ArgumentError.checkNotNull(apiOrNull);
    return WifiManagerImpl.jni(api);
  }

  @override
  List<WifiConfiguration> get configuredNetworks =>
      api.getConfiguredNetworks()!.nonNulls.map((e) => e.impl).toList();

  @override
  WifiInfo get connectionInfo => api.getConnectionInfo()!.impl;

  @override
  DhcpInfo get dhcpInfo => api.getDhcpInfo()!.impl;

  @override
  bool get isWifiEnabled => api.isWifiEnabled();

  @override
  WifiManager$WifiState get wifiState =>
      api.getWifiState().wifiManager$WifiStateImpl;

  @override
  int addNetwork(WifiConfiguration config) => api.addNetwork(config.api);

  @override
  void addWifiStateChangedListener(
    WifiManager$WifiStateChangedListener listener,
  ) => jni.Build$VERSION.SDK_INT >= jni.Build$VERSION_CODES.BAKLAVA
      ? api.addWifiStateChangedListener(
          jni.context.mainExecutor,
          listener.api36,
        )
      : jni.ContextCompat.registerReceiver(
          jni.context,
          listener.api,
          jni.IntentFilter.new$2(jni.WifiManager.WIFI_STATE_CHANGED_ACTION),
          jni.ContextCompat.RECEIVER_NOT_EXPORTED,
        );

  @override
  bool disableNetwork(int netId) => api.disableNetwork(netId);

  @override
  bool disconnect() => api.disconnect();

  @override
  bool enableNetwork(int nedId, bool attemptConnect) =>
      api.enableNetwork(nedId, attemptConnect);

  @override
  bool reassociate() => api.reassociate();

  @override
  bool reconnect() => api.reconnect();

  @override
  bool removeNetwork(int netId) => api.removeNetwork(netId);

  @override
  bool removeNonCallerConfiguredNetworks() =>
      api.removeNonCallerConfiguredNetworks();

  @override
  void removeWifiStateChangedListener(
    WifiManager$WifiStateChangedListener listener,
  ) => jni.Build$VERSION.SDK_INT >= jni.Build$VERSION_CODES.BAKLAVA
      ? api.removeWifiStateChangedListener(listener.api36)
      : jni.context.unregisterReceiver(listener.api);

  @override
  bool saveConfiguration() => api.saveConfiguration();

  @override
  bool setWifiEnabled(bool enabled) => api.setWifiEnabled(enabled);

  @override
  int updateNetwork(WifiConfiguration config) => api.updateNetwork(config.api);
}

extension WifiManager$intX on int {
  WifiManager$WifiState get wifiManager$WifiStateImpl {
    switch (this) {
      case jni.WifiManager.WIFI_STATE_DISABLING:
        return WifiManager$WifiState.disabling;
      case jni.WifiManager.WIFI_STATE_DISABLED:
        return WifiManager$WifiState.disabled;
      case jni.WifiManager.WIFI_STATE_ENABLING:
        return WifiManager$WifiState.enabling;
      case jni.WifiManager.WIFI_STATE_ENABLED:
        return WifiManager$WifiState.enabled;
      case jni.WifiManager.WIFI_STATE_UNKNOWN:
        return WifiManager$WifiState.unknown;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }
}

extension WifiManager$WifiStateChangedListenerX
    on WifiManager$WifiStateChangedListener {
  jni.WifiManager$WifiStateChangedListener get api36 {
    final impl = this;
    if (impl is! WifiManager$WifiStateChangedListenerImpl36) throw TypeError();
    return impl.api;
  }

  jni.BroadcastReceiver get api {
    final impl = this;
    if (impl is! WifiManager$WifiStateChangedListenerImpl) throw TypeError();
    return impl.api;
  }
}
