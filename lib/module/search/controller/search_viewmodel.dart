import 'package:movie_playlist/core/base/base_viewmodel.dart';
import 'package:movie_playlist/core/repository/tmdb_api_repository.dart';
import 'package:movie_playlist/core/tools/debouncer.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/model/movie_result.dart';

class SearchViewModel extends BaseViewModel {
  final TMDBApiRepository _tmdbApiRepository = locator.get<TMDBApiRepository>();

  List<MovieResult> _searchMovieList = [];
  List<MovieResult> get searchMovieList => _searchMovieList;

  String _query = '';
  String get query => '';

  final _debouncer = Debouncer(milliseconds: 500);

  void setSearchQuery(String query) {
    _query = query;

    if (_query.isEmpty) {
      _searchMovieList = [];
    }

    _debouncer.run(() {
      onRefresh();
    });
  }

  @override
  Future<void> onRefresh() async {
    super.onInitDataLoad([getSearchedMovieList()]);
  }

  Future<void> getSearchedMovieList() async {
    if (_query.isEmpty) {
      _searchMovieList = [];
    } else {
      final response = await _tmdbApiRepository.getSearchedMovieResult(_query);
      _searchMovieList = response.results ?? [];
    }
  }
}
