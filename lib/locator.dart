import 'package:get_it/get_it.dart';
import 'package:movie_playlist/core/repository/cloud_db_repository.dart';
import 'package:movie_playlist/core/repository/firebase_repository.dart';
import 'package:movie_playlist/core/repository/tmdb_api_repository.dart';
import 'package:movie_playlist/module/auth/services/auth_services.dart';

import 'module/dashboard/services/dashboard_service.dart';

final locator = GetIt.instance;

void setupDependencies() {
  setupRepository();
  setupService();
}

void setupRepository() {
  locator.registerSingleton<TMDBApiRepository>(TMDBApiRepository());
  locator.registerSingleton<FirebaseRepository>(FirebaseRepository());
  locator.registerSingleton<CloudDBRepository>(CloudDBRepository());
}

void setupService() {
  locator.registerSingleton<AuthServices>(AuthServices());
  locator.registerSingleton<MovieService>(MovieService());
}
