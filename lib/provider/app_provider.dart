import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_playlist/core/base/base_provider.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/module/auth/services/auth_services.dart';

//It will be top level controller on App
class AppProvider extends BaseProvider {
  AuthServices get _authServices => locator.get<AuthServices>();

  User? get currentUser => _authServices.currentUser;
  Stream<User?> userChanges() => _authServices.userChanges();

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }

  Future<void> saveUserIntoDB({
    required User user,
  }) async {
    await _authServices.saveUserIntoDB(
        name: user.displayName, email: user.email, uid: user.uid);
  }
}
