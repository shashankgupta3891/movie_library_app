import 'package:dio/dio.dart';
import 'package:movie_playlist/core/api_constants.dart';
import 'package:movie_playlist/main.dart';
import 'package:movie_playlist/model/tmdb_response_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TMDBApiRepository {
  // Interceptors getListInterceptors() {
  //   Interceptors interceptors = Interceptors();
  //   interceptors.add(flutoNetwork.getDioInterceptor());
  //   return interceptors;
  // }

  final TMDB _tmdbWithCustomLogs = TMDB(
    ApiKeys(
      ApiConstants.apikey,
      ApiConstants.readAccessToken,
    ),
    interceptors: Interceptors()..add(flutoNetwork.getDioInterceptor()),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Future<TMDBResponseModel> getTrending() async {
    final response = await _tmdbWithCustomLogs.v3.trending.getTrending();
    return _parseTMDBReponseModelJson(response);
  }

  Future<TMDBResponseModel> getTopRated() async {
    final response = await _tmdbWithCustomLogs.v3.movies.getTopRated();
    return _parseTMDBReponseModelJson(response);
  }

  Future<TMDBResponseModel> getPopular() async {
    final response = await _tmdbWithCustomLogs.v3.tv.getPopular();
    return _parseTMDBReponseModelJson(response);
  }

  Future<TMDBResponseModel> getSearchedMovieResult(String query) async {
    final response = await _tmdbWithCustomLogs.v3.search.queryMovies(query);
    return _parseTMDBReponseModelJson(response);
  }

  TMDBResponseModel _parseTMDBReponseModelJson(Map response) {
    final convertedResponse =
        response.map((key, value) => MapEntry(key.toString(), value));
    final parsedResponse = TMDBResponseModel.fromJson(convertedResponse);
    return parsedResponse;
  }
}
