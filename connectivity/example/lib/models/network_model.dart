class NetworkModel {
  final String iface;
  final String? ipAddress;
  final String? netmask;
  final String? gateway;
  final List<String> dnsServers;

  const NetworkModel({
    required this.iface,
    required this.ipAddress,
    required this.netmask,
    required this.gateway,
    required this.dnsServers,
  });
}
