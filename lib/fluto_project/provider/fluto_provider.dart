import 'package:draggable_widget/draggable_widget.dart';
import 'package:movie_playlist/common_import/ui_common_import.dart';

class FlutoProvider extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey;
  BuildContext? get context => navigatorKey.currentContext;
  PluginSheetState _sheetState = PluginSheetState.closed;

  FlutoProvider(this.navigatorKey);
  PluginSheetState get sheetState => _sheetState;

  bool get showDraggingButton => _sheetState == PluginSheetState.closed;
  bool get showButtonSheet => _sheetState == PluginSheetState.clicked;

  setSheetState(PluginSheetState value) {
    _sheetState = value;
    if (_sheetState != PluginSheetState.clickedAndOpened) {
      notifyListeners();
    }
  }

  final DragController dragController = DragController();
}

enum PluginSheetState { clicked, clickedAndOpened, closed }
