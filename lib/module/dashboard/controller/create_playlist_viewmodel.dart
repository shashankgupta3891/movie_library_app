import 'package:movie_playlist/core/base/base_viewmodel.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/module/dashboard/services/dashboard_service.dart';

class CreatePlaylistViewModel extends BaseViewModel {
  final MovieService _movieService = locator.get<MovieService>();

  bool _isPrivate = false;
  bool get isPrivate => _isPrivate;
  void setIsPrivate(bool val) => {_isPrivate = val, notifyListeners()};

  String _playlistName = '';
  String get playlistName => _playlistName;
  void setPlaylistName(String val) => {_playlistName = val, notifyListeners()};

  Future<bool> onSubmit() async {
    return await handleApiCall(
        _createPlayList(name: _playlistName, isPrivate: _isPrivate));
  }

  @override
  Future<void> onRefresh() async {}

  Stream<FirestoreUserModel> getUserDataSnapshot() {
    return _movieService.getUserDataSnapshot();
  }

  Future<void> _createPlayList(
      {required String name, bool isPrivate = false}) async {
    await _movieService.createPlayList(name, isPrivate: isPrivate);
  }
}
