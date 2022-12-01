import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/fluto_project/components/dragging_button.dart';

class FlutoScreenWrapper extends StatelessWidget {
  const FlutoScreenWrapper({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    /// A drag controller to show/hide or move the widget around the screen

    return Scaffold(
      floatingActionButton: FloatingActionButton.small(onPressed: () => {}),
      body: Stack(
        children: [
          child,
          const DraggingButton(),
        ],
      ),
    );
  }
}
