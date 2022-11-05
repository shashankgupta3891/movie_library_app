import 'package:get_it/get_it.dart';
import 'package:movie_playlist/core/api/tmdb_api_repository.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<TMDBApiRepository>(TMDBApiRepository());
}
