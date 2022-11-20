import 'package:movie_playlist/core/base/base_viewmodel.dart';
import 'package:movie_playlist/core/repository/tmdb_api_repository.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/model/playlist_model.dart';
import 'package:movie_playlist/module/dashboard/services/dashboard_service.dart';

class SaveMovieToPlaylistViewModel extends BaseViewModel {
  final TMDBApiRepository _tmdbApiRepository = locator.get<TMDBApiRepository>();
  final MovieService _movieService = locator.get<MovieService>();

  SaveMovieToPlaylistViewModel(this.movieToSave);

  final MovieResult movieToSave;

  Map<String, bool> _playlistSelectionMap = {};
  bool getSelectStatus(String id) => _playlistSelectionMap[id] ?? false;
  void setSelectStatus(String id, bool value) {
    _playlistSelectionMap = {
      ..._playlistSelectionMap,
      ...{id: value}
    };
    notifyListeners();
  }

  @override
  Future<void> onRefresh() async {}

  Future<bool> onSubmit() async {
    log("_addMovieToPlayList Started");
    final idList = <String>[];
    for (var element in _playlistSelectionMap.entries) {
      if (element.value) {
        idList.add(element.key);
      }
    }
    log("_addMovieToPlayList Started");
    return await handleApiCall(_addMovieToPlayList(idList));
  }

  Future<void> _addMovieToPlayList(List<String> idList) {
    return _movieService.addMovieToPlaylist(idList, movieToSave);
  }

  Stream<FirestoreUserModel> getUserDataSnapshot() {
    return _movieService.getUserDataSnapshot();
  }

  Stream<PlayListModel> getPlaylist(String playlistId) {
    return _movieService.getPlayList(playlistId);
  }

  Future<void> saveMovie(
      {required MovieResult movieResult, bool isPrivate = false}) async {
    await _movieService.addMovieToList(movieResult, isPrivate: isPrivate);
  }

  Future<void> removeMovie(
      {required MovieResult movieResult, bool isPrivate = false}) async {
    await _movieService.addMovieToList(movieResult, isPrivate: isPrivate);
  }
}
