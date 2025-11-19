import 'package:clover/clover.dart';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity_example/models.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeViewModel extends ViewModel {
  final ConnectivityManager _connectivityManager;
  final WifiManager _wifiManager;
  final EthernetManager _ethernetManager;
  String? _ssid;
  final Map<String, NetworkModel> _wifiModels;
  final Map<String, NetworkModel> _ethernetModels;
  WifiManager$WifiState _wifiState;

  late final ConnectivityManager$NetworkCallback _wifiCallback;
  late final ConnectivityManager$NetworkCallback _ethernetCallback;
  late final WifiManager$WifiStateChangedListener _wifiStateChangedListener;
  late final EthernetManager$Listener _ethernetListener;

  Logger get logger => Logger('HomeViewModel');

  String? get ssid => _ssid;
  Map<String, NetworkModel> get wifiModels => _wifiModels;
  Map<String, NetworkModel> get ethernetModels => _ethernetModels;
  WifiManager$WifiState get wifiState => _wifiState;

  HomeViewModel()
    : _connectivityManager = ConnectivityManager(),
      _wifiManager = WifiManager(),
      _ethernetManager = EthernetManager(),
      _ssid = null,
      _wifiModels = {},
      _ethernetModels = {},
      _wifiState = WifiManager$WifiState.unknown {
    _initialize();
  }

  @override
  void dispose() {
    _connectivityManager.unregisterNetworkCallback(_wifiCallback);
    _connectivityManager.unregisterNetworkCallback(_ethernetCallback);
    _wifiManager.removeWifiStateChangedListener(_wifiStateChangedListener);
    _ethernetManager.removeListener(_ethernetListener);
    super.dispose();
  }

  void _initialize() async {
    final isGranted = await Permission.locationWhenInUse.isGranted;
    if (!isGranted) {
      final status = await Permission.locationWhenInUse.request();
      logger.info('location when use status: $status');
    }
    _wifiState = _wifiManager.wifiState;
    final wifiInfo = _wifiManager.connectionInfo;
    logger.info('wifi info: ${wifiInfo.ssid}');
    notifyListeners();
    final wr = NetworkRequest(
      transportTypes: [NetworkCapabilities$Transport.wifi],
    );
    final er = NetworkRequest(
      transportTypes: [NetworkCapabilities$Transport.ethernet],
    );
    _wifiCallback = ConnectivityManager$NetworkCallback(
      includeLocationInfo: true,
      onAvailable: (network) {
        logger.info('wifi onAvailable');
      },
      onCapabilitiesChanged: (network, networkCapabilities) {
        logger.info('wifi onCapabilitiesChanged');
        final info = networkCapabilities.transportInfo;
        if (info is WifiInfo) {
          _ssid = info.ssid;
          notifyListeners();
        } else {
          logger.warning('info is $info');
        }
      },
      onLinkPropertiesChanged: (network, linkProperties) {
        logger.info('wifi onLinkPropertiesChanged');
        final wifiModel = linkProperties.getNetworkModel();
        if (wifiModel == null) {
          logger.warning('wifi model is null');
          return;
        }
        _wifiModels[wifiModel.iface] = wifiModel;
        notifyListeners();
      },
      onLosing: (network, maxMsToLive) {
        logger.info('wifi onLosing');
      },
      onLost: (network) {
        logger.info('wifi onLost');
        _ssid = null;
        _wifiModels.clear();
        notifyListeners();
      },
    );
    _ethernetCallback = ConnectivityManager$NetworkCallback(
      onAvailable: (network) {
        logger.info('ethernet onAvailable');
      },
      onCapabilitiesChanged: (network, networkCapabilities) {
        logger.info('ethernet onCapabilitiesChanged');
      },
      onLinkPropertiesChanged: (network, linkProperties) {
        logger.info('ethernet onLinkPropertiesChanged');
        final model = linkProperties.getNetworkModel();
        if (model == null) {
          logger.warning('ethernet model is null');
          return;
        }
        _ethernetModels[model.iface] = model;
        notifyListeners();
      },
      onLosing: (network, maxMsToLive) {
        logger.info('ethernet onLosing');
      },
      onLost: (network) async {
        logger.info('ethernet onLost');
        _ethernetModels.clear();
        notifyListeners();
      },
    );
    _connectivityManager.registerNetworkCallback(wr, _wifiCallback);
    _connectivityManager.registerNetworkCallback(er, _ethernetCallback);
    _wifiStateChangedListener = WifiManager$WifiStateChangedListener(
      onWifiStateChanged: () {
        logger.info('wifi state changed');
        _wifiState = _wifiManager.wifiState;
        notifyListeners();
      },
    );
    _wifiManager.addWifiStateChangedListener(_wifiStateChangedListener);
    _ethernetListener = EthernetManager$Listener(
      onAvailabilityChanged: (iface, isAvailable) {
        logger.info('ethernet $iface availability changed: $isAvailable');
      },
    );
    _ethernetManager.addListener(_ethernetListener);
  }
}

extension on LinkProperties {
  NetworkModel? getNetworkModel() {
    final iface = interfaceName;
    if (iface == null) return null;
    final inetAddresses = getAddressModels();
    final inetAddress = inetAddresses.firstOrNull;
    final gateway = getGatewayModel();
    final dnsServers = getDnsServerModels();
    return NetworkModel(
      iface: iface,
      ipAddress: inetAddress?.$1,
      netmask: inetAddress?.$2,
      gateway: gateway,
      dnsServers: dnsServers,
    );
  }

  List<(String, String)> getAddressModels() {
    return linkAddresses
        .map((e) {
          final inetAddress = e.address;
          if (inetAddress is! Inet4Address) return null;
          final ipAddress = inetAddress.hostAddress;
          if (ipAddress == null) return null;
          final prefixLength = e.prefixLength;
          final netmaskInt = NetworkUtil.prefixLengthToNetmaskInt(prefixLength);
          final netmask = NetworkUtil.intToInetAddress(netmaskInt).hostAddress;
          return (ipAddress, netmask);
        })
        .whereType<(String, String)>()
        .toList();
  }

  String? getGatewayModel() {
    return routes
        .map((e) {
          final isDefault = e.isDefaultRoute;
          if (isDefault) {
            final inetGateway = e.gateway;
            if (inetGateway is! Inet4Address) return null;
            final gateway = inetGateway.hostAddress;
            return gateway;
          } else {
            return null;
          }
        })
        .whereType<String>()
        .toList()
        .firstOrNull;
  }

  List<String> getDnsServerModels() {
    return dnsServers
        .map((e) => e is Inet4Address ? e.hostAddress : null)
        .whereType<String>()
        .toList();
  }
}
