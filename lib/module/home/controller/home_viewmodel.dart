import 'package:movie_playlist/core/api/tmdb_api_repository.dart';
import 'package:movie_playlist/core/base/base_provider.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/model/movie_result.dart';

class HomeViewModel extends BaseProvider {
  final TMDBApiRepository _tmdbApiRepository = locator.get<TMDBApiRepository>();

  List<MovieResult> _trendingmovies = [];
  List<MovieResult> get trendingmovies => _trendingmovies;

  List<MovieResult> _topratedmovies = [];
  List<MovieResult> get topratedmovies => _topratedmovies;

  List<MovieResult> _tv = [];
  List<MovieResult> get tv => _tv;

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

  Future<void> onRefresh() async {
    try {
      startLoading();
      await Future.wait([
        getTrendingMovie(),
        getTopRatedMovie(),
        getPopularMovie(),
      ]);
    } finally {
      stopLoading();
    }
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
}
