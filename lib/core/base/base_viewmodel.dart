import 'dart:ui';

import 'package:movie_playlist/core/base/base_provider.dart';

abstract class BaseViewModel extends BaseProvider {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ErrorHandler? _error;
  ErrorHandler? get error => _error;

  void handleError(ErrorCallback callback) {
    try {
      if (_error != null) {
        log(_error);

        final isHandled = callback.call(_error!.error, _error!.stackTrace!);
        if (isHandled) {
          _error = null;
        }
      }
    } catch (e) {}
  }

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
    await handleApiCall(Future.wait(parallelApiCallList));
  }

  Future<bool> handleApiCall(Future<dynamic> apiCall) async {
    bool isSuccess = false;
    try {
      startLoading();
      await apiCall;
      isSuccess = true;
    } catch (e, s) {
      _error = ErrorHandler(e, s);
      isSuccess = false;
    } finally {
      stopLoading();
    }
    return isSuccess;
  }

  Future<void> onRefresh();
}

class ErrorHandler {
  final Object error;
  final StackTrace? stackTrace;

  ErrorHandler(this.error, this.stackTrace);

  @override
  String toString() => 'ErrorHandler(error: $error, stackTrace: $stackTrace)';
}
