class NetworkModel {
  final String iface;
  final String? ipAddress;
  final String? subnetMask;
  final String? gateway;
  final List<String> dnsServers;

  const NetworkModel({
    required this.iface,
    required this.ipAddress,
    required this.subnetMask,
    required this.gateway,
    required this.dnsServers,
  });
}
