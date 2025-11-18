import 'dart:io';

import 'package:jnigen/jnigen.dart';
import 'package:logging/logging.dart';

void main() async {
  final root = Platform.script.resolve('../');
  final config = Config(
    outputConfig: OutputConfig(
      dartConfig: DartCodeOutputConfig(
        path: root.resolve('lib/src/jni/'),
        structure: OutputStructure.packageStructure,
      ),
    ),
    classes: [
      'android.app.Activity',
      'android.app.PendingIntent',
      'android.content.Context',
      'android.net.ConnectivityManager',
      'android.net.InetAddresses',
      'android.net.IpPrefix',
      'android.net.IpSecManager',
      'android.net.LinkAddress',
      'android.net.LinkProperties',
      'android.net.MacAddress',
      'android.net.Network',
      'android.net.NetworkInfo',
      'android.net.NetworkRequest',
      'android.net.NetworkCapabilities',
      'android.net.NetworkSpecifier',
      'android.net.ProxyInfo',
      'android.net.RouteInfo',
      'android.net.SocketKeepalive',
      'android.net.TransportInfo',
      'android.net.wifi.MloLink',
      'android.net.wifi.ScanResult',
      'android.net.wifi.SupplicantState',
      'android.net.wifi.WifiInfo',
      'android.net.wifi.aware.WifiAwareNetworkInfo',
      'android.os.Handler',
      'android.os.Looper',
      'androidx.core.content.ContextCompat',
      'java.io.FileDescriptor',
      'java.net.DatagramSocket',
      'java.net.InetAddress',
      'java.net.Inet4Address',
      'java.net.Inet6Address',
      'java.net.InetSocketAddress',
      'java.net.NetworkInterface',
      'java.net.Proxy',
      'java.net.Socket',
      'java.net.URL',
      'java.net.URLConnection',
      'java.util.Collection',
      'java.util.concurrent.Executor',
      'javax.net.SocketFactory',
      'dev.zeekr.connectivity.JConnectivityManager',
    ],
    sourcePath: [root.resolve('android/src/main/kotlin/')],
    androidSdkConfig: AndroidSdkConfig(
      addGradleDeps: true,
      androidExample: 'example/',
    ),
    nonNullAnnotations: ['android.annotation.NonNull'],
    nullableAnnotations: ['android.annotation.Nullable'],
    logLevel: Level.ALL,
  );
  await generateJniBindings(config);
}
