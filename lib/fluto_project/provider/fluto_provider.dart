import 'package:draggable_widget/draggable_widget.dart';
import 'package:movie_playlist/common_import/ui_common_import.dart';

class FlutoProvider extends ChangeNotifier {
  bool _isDialogShowing = false;
  bool get isDialogShowing => _isDialogShowing;
  setIsDialogShowing(bool value) {
    _isDialogShowing = value;
    notifyListeners();
  }

  final DragController dragController = DragController();
}

enum PluginSheetState { open, canOpen, closed }
