import '../jni.dart' as jni;

abstract interface class EthernetManager$Listener {
  void onAvailabilityChanged(String iface, bool isAvailable);
}

abstract interface class EthernetManager {
  List<String> get availableInterfaces;

  bool isAvailable([String? iface]);
  void addListener(EthernetManager$Listener listener);
  void removeListener(EthernetManager$Listener listener);
}

// final class EthernetManager$ListenerImpl implements EthernetManager$Listener {
//   final jni.JEthernetManager$Listener api;

//   EthernetManager$ListenerImpl.jni(this.api);

//   factory EthernetManager$ListenerImpl({
//     required void Function(String iface,bool isAvailable) onAvailabilityChanged,
//   }) {
//     final api = jni.JEthernetManager$Listener
//   }
// }

// final class EthernetManagerImpl implements EthernetManager {
//   final jni.EthernetManager api;

//   EthernetManagerImpl.jni(this.api);

//   factory EthernetManagerImpl() {
//     final api = jni.EthernetManager.fromContext(jni.context);
//     return EthernetManagerImpl.jni(api);
//   }

//   @override
//   List<String> get availableInterfaces =>
//       api.getAvailableInterfaces()!.nonNulls.map((e) => e.impl).toList();

//   @override
//   bool isAvailable([String? iface]) => api.isAvailable(iface?.api);

//   @override
//   void addListener(EthernetManager$Listener listener) {
//     api.addListener(EthernetManager$ListenerImpl.jni(listener));
//   }

//   @override
//   void removeListener(EthernetManager$Listener listener) {
//     api.removeListener(EthernetManager$ListenerImpl.jni(listener));
//   }
// }
