import '../jni.dart' as jni;

enum WifiConfiguration$Status {
  current, // 0
  disabled, // 1
  enabled, // 2
}

abstract interface class WifiConfiguration {
  factory WifiConfiguration() => WifiConfigurationImpl();

  // ProxyInfo getHttpProxy();
  // String getKey();
  // int getMacRandomizationSetting();
  // MacAddress getRandomizedMacAddress();
  // bool isDppConfigurator();
  // bool isPasspoint();
  // void setHttpProxy(PorxyInfo httpProxy);
  // void setIpConfiguration(IpConfiguration ipConfiguration);
  // void setMacRandomizationSetting(int macRandomizationSetting);
  // void setSecurityParams(int securityType);

  String get bssid;
  String get fqdn;
  String get ssid;
  // BitSet get allowedAuthAlgorithms;
  // BitSet get allowedGroupCiphers;
  // BitSet get allowedGroupManagementCiphers;
  // BitSet get allowedKeyManagement;
  // BitSet get allowedPairwiseCiphers;
  // BitSet get allowedProtocols;
  // BitSet get allowedSuiteBCiphers;
  // WifiEnterpriseConfig get enterpriseConfig;
  bool get hiddenSSID;
  // bool get isHomeProviderNetwork;
  int get networkId;
  // String get preSharedKey;
  // int get priority;
  // String get providerFriendlyName;
  // List<int> get roamingConsortiumIds;
  WifiConfiguration$Status get status;
  // List<String> get wepKeys;
  // int get wepTxKeyIndex;
}

class WifiConfigurationImpl implements WifiConfiguration {
  final jni.WifiConfiguration api;

  WifiConfigurationImpl.jni(this.api);

  factory WifiConfigurationImpl() {
    final api = jni.WifiConfiguration();
    return WifiConfigurationImpl.jni(api);
  }

  @override
  String get bssid => api.BSSID!.impl;

  @override
  String get fqdn => api.FQDN!.impl;

  @override
  bool get hiddenSSID => api.hiddenSSID;

  @override
  int get networkId => api.networkId;

  @override
  String get ssid => api.SSID!.impl;

  @override
  WifiConfiguration$Status get status =>
      api.status.wifiConfiguration$StatusImpl;
}

extension WifiConfiguration$intX on int {
  WifiConfiguration$Status get wifiConfiguration$StatusImpl {
    switch (this) {
      case jni.WifiConfiguration$Status.CURRENT:
        return WifiConfiguration$Status.current;
      case jni.WifiConfiguration$Status.DISABLED:
        return WifiConfiguration$Status.disabled;
      case jni.WifiConfiguration$Status.ENABLED:
        return WifiConfiguration$Status.enabled;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }
}

extension WifiConfigurationX on WifiConfiguration {
  jni.WifiConfiguration get api {
    final impl = this;
    if (impl is! WifiConfigurationImpl) throw TypeError();
    return impl.api;
  }
}

extension JWifiConfigurationX on jni.WifiConfiguration {
  WifiConfiguration get impl => WifiConfigurationImpl.jni(this);
}
