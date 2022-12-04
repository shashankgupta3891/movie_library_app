import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/fluto_project/core/plugin_manager.dart';
import 'package:movie_playlist/fluto_project/plugin/fluto_network_inspector/fluto_network_inseptor.dart';
import 'package:movie_playlist/fluto_project/provider/fluto_provider.dart';

Future<void> showFlutoBottomSheet(BuildContext context) async {
  final pluginList = PlutoPluginManager.plugins;

  showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    context: context,
    builder: (context) {
      context
          .read<FlutoProvider>()
          .setSheetState(PluginSheetState.clickedAndOpened);
      return WillPopScope(
        onWillPop: () async {
          context.read<FlutoProvider>().setSheetState(PluginSheetState.closed);
          return await Future.value(true);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text("Fluto Project"),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context
                      .read<FlutoProvider>()
                      .setSheetState(PluginSheetState.closed);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Plugins"),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: pluginList.length,
                itemBuilder: (context, index) {
                  final plugin = pluginList[index];
                  return IconButton(
                    icon: Icon(plugin.iconData),
                    onPressed: () {
                      plugin.onTrigger();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PluginScreen(
                            pluggable: plugin,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
