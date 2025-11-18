import 'datagram_socket.dart';
import 'file_descriptor.dart';
import 'inet_address.dart';
import 'jni.dart' as jni;
import 'proxy.dart';
import 'socket.dart';
import 'socket_factory.dart';
import 'url.dart';
import 'url_connection.dart';

abstract interface class Network {
  factory Network.fromNetworkHandle(int networkHandle) =>
      NetworkImpl.fromNetworkHandle(networkHandle);

  int get networkHandle;
  SocketFactory get socketFactory;

  void bindSocket(Socket socket);
  void bindDatagramSocket(DatagramSocket socket);
  void bindFileDescriptor(FileDescriptor fd);
  List<InetAddress> getAllByName(String host);
  InetAddress getByName(String host);
  UrlConnection openConnection(Url url, [Proxy? proxy]);
}

final class NetworkImpl implements Network {
  static Network fromNetworkHandle(int networkHandle) =>
      jni.Network.fromNetworkHandle(networkHandle)!.impl;

  final jni.Network api;

  NetworkImpl.jni(this.api);

  @override
  int get networkHandle => api.getNetworkHandle();

  @override
  SocketFactory get socketFactory => api.getSocketFactory()!.impl;

  @override
  void bindSocket(Socket socket) => api.bindSocket$2(socket.api);

  @override
  void bindDatagramSocket(DatagramSocket socket) =>
      api.bindSocket$1(socket.api);

  @override
  void bindFileDescriptor(FileDescriptor fd) => api.bindSocket(fd.api);

  @override
  List<InetAddress> getAllByName(String host) =>
      api.getAllByName(host.api)!.nonNulls.map((e) => e.impl).toList();

  @override
  InetAddress getByName(String host) => api.getByName(host.api)!.impl;

  @override
  UrlConnection openConnection(Url url, [Proxy? proxy]) => proxy == null
      ? api.openConnection(url.api)!.impl
      : api.openConnection$1(url.api, proxy.api)!.impl;
}

extension NetworkX on Network {
  jni.Network get api {
    final impl = this;
    if (impl is! NetworkImpl) throw TypeError();
    return impl.api;
  }
}

extension JNetworkX on jni.Network {
  Network get impl => NetworkImpl.jni(this);
}
