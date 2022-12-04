import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/fluto_project/components/fluto_plugin_sheet.dart';

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
      create: (context) => FlutoProvider(widget.navigatorKey),
      builder: (context, child) {
        final showDialog = context
            .select<FlutoProvider, bool>((value) => value.showButtonSheet);
        if (showDialog) {
          showFlutoBottomSheet(widget.navigatorKey.currentContext!);
        }

        return child ?? Container();
      },
      child: widget.child,
    );
  }
}
