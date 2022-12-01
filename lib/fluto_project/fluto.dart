import 'package:movie_playlist/common_import/ui_common_import.dart';

import 'provider/fluto_provider.dart';

class Fluto extends StatefulWidget {
  const Fluto({
    Key? key,
    required this.child,
    required this.navigatorKey,
  }) : super(key: key);
  final Widget child;

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<Fluto> createState() => _FlutoState();
}

class _FlutoState extends State<Fluto> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlutoProvider(),
      builder: (context, child) {
        final showDialog = context
            .select<FlutoProvider, bool>((value) => value.isDialogShowing);
        if (showDialog) {
          showFlutoBottomSheet();
        }

        return child ?? Container();
      },
      child: widget.child,
    );
  }

  Future<void> showFlutoBottomSheet() async {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: widget.navigatorKey.currentContext!,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          context.read<FlutoProvider>().setIsDialogShowing(false);
          return await Future.value(true);
        },
        child: Column(
          children: [
            ListTile(
              title: const Text("Fluto Project"),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(widget.navigatorKey.currentContext!).pop();
                  context.read<FlutoProvider>().setIsDialogShowing(false);
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
