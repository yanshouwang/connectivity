import '../jni.dart' as jni;

abstract interface class EthernetManager$Listener {
  factory EthernetManager$Listener({
    required void Function(String iface, bool isAvailable)
    onAvailabilityChanged,
  }) => EthernetManager$ListenerImpl(
    onAvailabilityChanged: onAvailabilityChanged,
  );
}

abstract interface class EthernetManager {
  factory EthernetManager() => EthernetManagerImpl();

  List<String> get availableInterfaces;

  bool isAvailable([String? iface]);
  void addListener(EthernetManager$Listener listener);
  void removeListener(EthernetManager$Listener listener);
}

final class EthernetManager$ListenerImpl implements EthernetManager$Listener {
  final jni.JEthernetManager$JListenerImpl api;

  EthernetManager$ListenerImpl.jni(this.api);

  factory EthernetManager$ListenerImpl({
    required void Function(String iface, bool isAvailable)
    onAvailabilityChanged,
  }) {
    final api = jni.JEthernetManager$JListenerImpl(
      jni.context,
      jni.JEthernetManager$JListener.implement(
        jni.$JEthernetManager$JListener(
          onAvailabilityChanged: (e1, e2) => onAvailabilityChanged(e1.impl, e2),
        ),
      ),
    );
    return EthernetManager$ListenerImpl.jni(api);
  }
}

final class EthernetManagerImpl implements EthernetManager {
  final jni.JEthernetManager api;

  EthernetManagerImpl.jni(this.api);

  factory EthernetManagerImpl() {
    final api = jni.JEthernetManager(jni.context);
    return EthernetManagerImpl.jni(api);
  }

  @override
  List<String> get availableInterfaces =>
      api.getAvailableInterfaces().map((e) => e.impl).toList();

  @override
  bool isAvailable([String? iface]) =>
      iface == null ? api.isAvailable() : api.isAvailable$1(iface.api);

  @override
  void addListener(EthernetManager$Listener listener) =>
      api.addListener(listener.api);

  @override
  void removeListener(EthernetManager$Listener listener) =>
      api.removeListener(listener.api);
}

extension on EthernetManager$Listener {
  jni.JEthernetManager$JListenerImpl get api {
    final impl = this;
    if (impl is! EthernetManager$ListenerImpl) throw TypeError();
    return impl.api;
  }
}
