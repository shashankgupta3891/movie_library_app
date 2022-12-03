import 'package:flutter/material.dart';
import 'package:movie_playlist/fluto_project/core/pluggable.dart';

class FlutoNetworkInspenctor extends Pluggable {
  FlutoNetworkInspenctor(this.uniqueId);

  final String uniqueId;

  @override
  String get id => uniqueId;

  @override
  PluginType get pluginType => PluginType.screen;

  @override
  Widget get buildWidget => const NetworkInspectorPlugin();

  @override
  String get displayName => "Network Inspector";

  @override
  String get name => "network_inspector";

  @override
  void onTrigger() {}

  @override
  IconData get iconData => Icons.network_check;
}

class PluginScreen extends StatelessWidget {
  const PluginScreen({super.key, required this.pluggable});

  final Pluggable pluggable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pluggable.displayName),
      ),
      body: pluggable.buildWidget,
    );
  }
}

class NetworkInspectorPlugin extends StatelessWidget {
  const NetworkInspectorPlugin({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return const ListTile(
          title: Text("Network Request"),
          subtitle: Text("https://www.google.com"),
          trailing: Icon(Icons.network_check),
        );
      },
    );
  }
}
