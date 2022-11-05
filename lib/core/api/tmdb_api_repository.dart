import 'package:movie_playlist/core/api_constants.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TMDBApiRepository {
  final TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(
      ApiConstants.apikey,
      ApiConstants.readAccessToken,
    ),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Future<List<dynamic>> getTrending() async {
    final response = await tmdbWithCustomLogs.v3.trending.getTrending();
    return response['results'];
  }

  Future<List<dynamic>> getTopRated() async {
    final response = await tmdbWithCustomLogs.v3.movies.getTopRated();
    return response['results'];
  }

  Future<List<dynamic>> getPopular() async {
    final response = await tmdbWithCustomLogs.v3.tv.getPopular();
    return response['results'];
  }
}
