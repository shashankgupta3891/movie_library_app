import 'package:movie_playlist/core/api_constants.dart';
import 'package:movie_playlist/model/tmdb_response_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TMDBApiRepository {
  final TMDB _tmdbWithCustomLogs = TMDB(
    ApiKeys(
      ApiConstants.apikey,
      ApiConstants.readAccessToken,
    ),
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

  TMDBResponseModel _parseTMDBReponseModelJson(Map response) {
    final convertedResponse =
        response.map((key, value) => MapEntry(key.toString(), value));
    final parsedResponse = TMDBResponseModel.fromJson(convertedResponse);
    return parsedResponse;
  }
}
