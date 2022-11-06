import 'package:movie_playlist/core/base/base_provider.dart';

abstract class BaseViewModel extends BaseProvider {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> onInitDataLoad(
      Iterable<Future<dynamic>> parallelApiCallList) async {
    try {
      startLoading();
      await Future.wait(parallelApiCallList);
    } finally {
      stopLoading();
    }
  }

  Future<void> onRefresh();
}
