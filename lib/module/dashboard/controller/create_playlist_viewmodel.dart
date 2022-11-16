import 'package:movie_playlist/core/base/base_viewmodel.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/module/dashboard/services/dashboard_service.dart';

class SaveMovieToPlaylistViewModel extends BaseViewModel {
  final MovieService _movieService = locator.get<MovieService>();

  SaveMovieToPlaylistViewModel(this.movieToSave);

  final MovieResult movieToSave;

  @override
  Future<void> onRefresh() async {}

  Stream<FirestoreUserModel> getUserDataSnapshot() {
    return _movieService.getUserDataSnapshot();
  }

  Future<void> createPlayList(
      {required String name, bool isPrivate = false}) async {
    await _movieService.createPlayList(name, isPrivate: isPrivate);
  }
}
