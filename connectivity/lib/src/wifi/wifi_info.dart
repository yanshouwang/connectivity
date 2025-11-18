import '../jni.dart' as jni;
import '../mac_address.dart';
import '../network_info.dart';
import '../transport_info.dart';
import 'mlo_link.dart';
import 'scan_result.dart';
import 'supplicant_state.dart';

enum WifiInfo$SecurityType {
  unknown, // -1
  open, // 0
  wep, // 1
  psk, // 2
  eap, // 3
  sae, // 4
  eapWpa3Enterprise192Bit, //
  owe, // 6
  wapiPsk, // 7
  wapiCert, // 8
  eapWpa3Enterprise, // 9
  osen, // 10
  passpointR1R2, // 11
  passpointR3, // 12
  dpp, // 13
}

abstract interface class WifiInfo implements TransportInfo {
  static NetworkInfo$DetailedState getDetailedStateOf(
    SupplicantState suppState,
  ) => WifiInfoImpl.getDetailedStateOf(suppState);

  List<MloLink> get affiliatedMloLinks;
  MacAddress? get apMldMacAddress;
  int get apMloLinkId;
  int get applicableRedactions;
  List<MloLink> get associatedMloLinks;
  String get bssid;
  WifiInfo$SecurityType get currentSecurityType;
  int get frequency;
  bool get hiddenSSID;
  List<ScanResult$InformationElement>? get informationElements;
  int get ipAddress;
  int get linkSpeed;
  String get macAddress;
  int get maxSupportedRxLinkSpeedMbps;
  int get maxSupportedTxLinkSpeedMbps;
  int get networkId;
  String? get passpointFqdn;
  String? get passpointProviderFriendlyName;
  String? get passpointUniqueId;
  int get rssi;
  int get rxLinkSpeedMbps;
  String get ssid;
  int get subscriptionId;
  SupplicantState get supplicantState;
  int get txLinkSpeedMbps;
  int get wifiStandard;
  bool get isRestricted;
  WifiInfo makeCopy(int redactions);
}

final class WifiInfoImpl extends TransportInfoImpl implements WifiInfo {
  static NetworkInfo$DetailedState getDetailedStateOf(
    SupplicantState suppState,
  ) => jni.WifiInfo.getDetailedStateOf(suppState.api)!.impl;

  @override
  final jni.WifiInfo api;

  WifiInfoImpl.jni(this.api);

  @override
  List<MloLink> get affiliatedMloLinks =>
      api.getAffiliatedMloLinks().nonNulls.map((e) => e.impl).toList();

  @override
  MacAddress? get apMldMacAddress => api.getApMldMacAddress()?.impl;

  @override
  int get apMloLinkId => api.getApMloLinkId();

  @override
  int get applicableRedactions => api.getApplicableRedactions();

  @override
  List<MloLink> get associatedMloLinks =>
      api.getAssociatedMloLinks().nonNulls.map((e) => e.impl).toList();

  @override
  String get bssid => api.getBSSID()!.impl;

  @override
  WifiInfo$SecurityType get currentSecurityType =>
      api.getCurrentSecurityType().wifiInfoSecurityTypeImpl;

  @override
  int get frequency => api.getFrequency();

  @override
  bool get hiddenSSID => api.getHiddenSSID();

  @override
  List<ScanResult$InformationElement>? get informationElements =>
      api.getInformationElements()?.nonNulls.map((e) => e.impl).toList();

  @override
  int get ipAddress => api.getIpAddress();

  @override
  bool get isRestricted => api.isRestricted();

  @override
  int get linkSpeed => api.getLinkSpeed();

  @override
  String get macAddress => api.getMacAddress()!.impl;

  @override
  WifiInfo makeCopy(int redactions) => api.makeCopy(redactions).impl;

  @override
  int get maxSupportedRxLinkSpeedMbps => api.getMaxSupportedRxLinkSpeedMbps();

  @override
  int get maxSupportedTxLinkSpeedMbps => api.getMaxSupportedTxLinkSpeedMbps();

  @override
  int get networkId => api.getNetworkId();

  @override
  String? get passpointFqdn => api.getPasspointFqdn()?.impl;

  @override
  String? get passpointProviderFriendlyName =>
      api.getPasspointProviderFriendlyName()?.impl;

  @override
  String? get passpointUniqueId => api.getPasspointUniqueId()?.impl;

  @override
  int get rssi => api.getRssi();

  @override
  int get rxLinkSpeedMbps => api.getRxLinkSpeedMbps();

  @override
  String get ssid => api.getSSID()!.impl;

  @override
  int get subscriptionId => api.getSubscriptionId();

  @override
  SupplicantState get supplicantState => api.getSupplicantState()!.impl;

  @override
  int get txLinkSpeedMbps => api.getTxLinkSpeedMbps();

  @override
  int get wifiStandard => api.getWifiStandard();
}

extension WifiInfo$intX on int {
  WifiInfo$SecurityType get wifiInfoSecurityTypeImpl {
    switch (this) {
      case jni.WifiInfo.SECURITY_TYPE_UNKNOWN:
        return WifiInfo$SecurityType.unknown;
      case jni.WifiInfo.SECURITY_TYPE_OPEN:
        return WifiInfo$SecurityType.open;
      case jni.WifiInfo.SECURITY_TYPE_WEP:
        return WifiInfo$SecurityType.wep;
      case jni.WifiInfo.SECURITY_TYPE_PSK:
        return WifiInfo$SecurityType.psk;
      case jni.WifiInfo.SECURITY_TYPE_EAP:
        return WifiInfo$SecurityType.eap;
      case jni.WifiInfo.SECURITY_TYPE_SAE:
        return WifiInfo$SecurityType.sae;
      case jni.WifiInfo.SECURITY_TYPE_EAP_WPA3_ENTERPRISE_192_BIT:
        return WifiInfo$SecurityType.eapWpa3Enterprise192Bit;
      case jni.WifiInfo.SECURITY_TYPE_OWE:
        return WifiInfo$SecurityType.owe;
      case jni.WifiInfo.SECURITY_TYPE_WAPI_PSK:
        return WifiInfo$SecurityType.wapiPsk;
      case jni.WifiInfo.SECURITY_TYPE_WAPI_CERT:
        return WifiInfo$SecurityType.wapiCert;
      case jni.WifiInfo.SECURITY_TYPE_EAP_WPA3_ENTERPRISE:
        return WifiInfo$SecurityType.eapWpa3Enterprise;
      case jni.WifiInfo.SECURITY_TYPE_OSEN:
        return WifiInfo$SecurityType.osen;
      case jni.WifiInfo.SECURITY_TYPE_PASSPOINT_R1_R2:
        return WifiInfo$SecurityType.passpointR1R2;
      case jni.WifiInfo.SECURITY_TYPE_PASSPOINT_R3:
        return WifiInfo$SecurityType.passpointR3;
      case jni.WifiInfo.SECURITY_TYPE_DPP:
        return WifiInfo$SecurityType.dpp;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }
}

extension JWifiInfoX on jni.WifiInfo {
  WifiInfo get impl => WifiInfoImpl.jni(this);
}
