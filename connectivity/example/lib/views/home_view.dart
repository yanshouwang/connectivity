import 'package:clover/clover.dart';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity_example/models.dart';
import 'package:connectivity_example/view_models.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<HomeViewModel>(context);
    final ssid = viewModel.ssid;
    final wifiModels = viewModel.wifiModels;
    final ethernetModels = viewModel.ethernetModels;
    final wifiState = viewModel.wifiState;
    return Scaffold(
      appBar: AppBar(title: Text('Connectivity Manager')),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, i) {
                  final model = wifiModels.values.elementAt(i);
                  return _buildNetworkModel(context, model, wifiState, ssid);
                },
                separatorBuilder: (context, i) => Divider(),
                itemCount: wifiModels.length,
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, i) {
                  final model = ethernetModels.values.elementAt(i);
                  return _buildNetworkModel(context, model);
                },
                separatorBuilder: (context, i) => Divider(),
                itemCount: ethernetModels.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkModel(
    BuildContext context,
    NetworkModel model, [
    WifiManager$WifiState? wifiState,
    String? ssid,
  ]) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (wifiState != null) Text('WifiState: ${wifiState.name}'),
        Text(model.iface, style: theme.textTheme.titleMedium),
        if (ssid != null) Text('SSID: $ssid'),
        Text('ipAddress: ${model.ipAddress}'),
        Text('netmask: ${model.netmask}'),
        Text('gateway: ${model.gateway}'),
        Text('dnsServers: ${model.dnsServers.join(', ')}'),
      ],
    );
  }
}
