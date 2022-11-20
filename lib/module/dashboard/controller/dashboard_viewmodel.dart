import 'package:movie_playlist/core/base/base_viewmodel.dart';
import 'package:movie_playlist/core/repository/tmdb_api_repository.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/model/playlist_model.dart';
import 'package:movie_playlist/module/dashboard/services/dashboard_service.dart';

class DashboardViewModel extends BaseViewModel {
  final TMDBApiRepository _tmdbApiRepository = locator.get<TMDBApiRepository>();
  final MovieService _movieService = locator.get<MovieService>();

  List<MovieResult> _trendingmovies = [];
  List<MovieResult> get trendingmovies => _trendingmovies;

  List<MovieResult> _topratedmovies = [];
  List<MovieResult> get topratedmovies => _topratedmovies;

  List<MovieResult> _tv = [];
  List<MovieResult> get tv => _tv;

  @override
  Future<void> onRefresh() async {
    super.onInitDataLoad([
      getTrendingMovie(),
      getTopRatedMovie(),
      getPopularMovie(),
    ]);
  }

  Future<void> getTrendingMovie() async {
    final response = await _tmdbApiRepository.getTrending();
    _trendingmovies = response.results ?? [];
  }

  Future<void> getTopRatedMovie() async {
    final response = await _tmdbApiRepository.getTopRated();
    _topratedmovies = response.results ?? [];
  }

  Future<void> getPopularMovie() async {
    final response = await _tmdbApiRepository.getPopular();
    _tv = response.results ?? [];
  }

  Stream<FirestoreUserModel> getUserDataSnapshot() {
    return _movieService.getUserDataSnapshot();
  }

  Future<void> saveMovie(
      {required MovieResult movieResult, bool isPrivate = false}) async {
    await _movieService.addMovieToList(movieResult, isPrivate: isPrivate);
  }

  Future<void> removeMovie(
      {required MovieResult movieResult, bool isPrivate = false}) async {
    await _movieService.addMovieToList(movieResult, isPrivate: isPrivate);
  }

  Stream<PlayListModel> getPlaylist(String playlistId) {
    return _movieService.getPlayList(playlistId);
  }

  Future<MovieResult> getMovie(String movieId) async {
    final data = await _movieService.getMovie(movieId);

    log(data.toJson());
    return data;
  }
}
