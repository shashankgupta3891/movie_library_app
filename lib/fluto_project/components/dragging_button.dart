import 'package:draggable_widget/draggable_widget.dart';
import 'package:movie_playlist/common_import/ui_common_import.dart';
import 'package:movie_playlist/fluto_project/provider/fluto_provider.dart';

class DraggingButton extends StatelessWidget {
  const DraggingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flutoProvider = context.read<FlutoProvider>();
    final isDialogShowing =
        context.select<FlutoProvider, bool>((value) => value.isDialogShowing);
    return DraggableWidget(
      bottomMargin: 80,
      topMargin: 80,
      intialVisibility: !isDialogShowing,
      horizontalSpace: 20,
      shadowBorderRadius: 50,
      initialPosition: AnchoringPosition.bottomRight,
      dragController: flutoProvider.dragController,
      child: ElevatedButton(
        child: const Text("Launch Fluto"),
        onPressed: () {
          flutoProvider.setIsDialogShowing(true);
        },
      ),
    );
  }
}
