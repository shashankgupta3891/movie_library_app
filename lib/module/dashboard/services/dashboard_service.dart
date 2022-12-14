import 'package:movie_playlist/core/repository/cloud_db_repository.dart';
import 'package:movie_playlist/core/repository/firebase_repository.dart';
import 'package:movie_playlist/locator.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/model/playlist_model.dart';

class MovieService {
  FirebaseRepository get _firebaseRepository => locator<FirebaseRepository>();
  CloudDBRepository get _cloudDBRepositoy => locator<CloudDBRepository>();

  Future<void> addMovieToList(MovieResult movieResult,
      {bool isPrivate = false}) async {
    final user = _firebaseRepository.currentUser;
    if (user != null) {
      if (isPrivate) {
        await _cloudDBRepositoy.addPrivateMovieList(user.uid, movieResult);
      } else {
        await _cloudDBRepositoy.addPublicMovieList(user.uid, movieResult);
      }
    }
  }

  Future<void> setMovieToList(List<MovieResult> movieResultList,
      {bool isPrivate = false}) async {
    final user = _firebaseRepository.currentUser;
    if (user != null) {
      if (isPrivate) {
        await _cloudDBRepositoy.setPrivateMovieList(user.uid, movieResultList);
      } else {
        await _cloudDBRepositoy.setPublicMovieList(user.uid, movieResultList);
      }
    }
  }

  Stream<FirestoreUserModel> getUserDataSnapshot() {
    return _cloudDBRepositoy
        .getUserDataSnapshot(_firebaseRepository.currentUser!.uid);
  }

  Stream<PlayListModel> getPlayList(String playListId) {
    return _cloudDBRepositoy.getPlaylist(playListId);
  }

  Future<MovieResult> getMovie(String playListId) {
    return _cloudDBRepositoy.getMovie(playListId);
  }

  Future<void> createPlayList(String name, {bool isPrivate = false}) async {
    final user = _firebaseRepository.currentUser;
    if (user != null) {
      await _cloudDBRepositoy.createPlaylist(user.uid, name, isPrivate);
    }
  }

  Future<void> addMovieToPlaylist(
    List<String> idList,
    MovieResult movieResult,
  ) async {
    final user = _firebaseRepository.currentUser;
    if (user != null) {
      await _cloudDBRepositoy.addMovieToPlaylist(user.uid, idList, movieResult);
      print("_addMovieToPlayList End");
    }
  }
}
