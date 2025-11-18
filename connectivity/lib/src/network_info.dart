import 'jni.dart' as jni;

abstract interface class NetworkInfo$DetailedState {}

abstract interface class NetworkInfo {}

final class NetworkInfo$DetailedStateImpl implements NetworkInfo$DetailedState {
  final jni.NetworkInfo$DetailedState api;

  NetworkInfo$DetailedStateImpl.jni(this.api);
}

final class NetworkInfoImpl implements NetworkInfo {
  final jni.NetworkInfo api;

  NetworkInfoImpl.jni(this.api);
}

extension JNetworkInfo$DetailedStateX on jni.NetworkInfo$DetailedState {
  NetworkInfo$DetailedState get impl => NetworkInfo$DetailedStateImpl.jni(this);
}

extension JNetworkInfoX on jni.NetworkInfo {
  NetworkInfo get impl => NetworkInfoImpl.jni(this);
}
