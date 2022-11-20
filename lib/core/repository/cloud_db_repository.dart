import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';
import 'package:movie_playlist/model/playlist_model.dart';

class CloudDBRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> saveUser(String uid, String? name, String? email) async {
    await _firebaseFirestore
        .collection(CollectionType.users.name)
        .doc(uid)
        .set({'email': email, 'name': name});
  }

  Future<void> addPrivateMovieList(String uid, MovieResult movieResult) async {
    await _firebaseFirestore.collection(CollectionType.users.name).doc(uid).set(
      {
        'private_movie_list': FieldValue.arrayUnion([movieResult.toJson()])
      },
      SetOptions(merge: true),
    );
  }

  Stream<FirestoreUserModel> getUserDataSnapshot(String uid) {
    return _firebaseFirestore
        .collection(CollectionType.users.name)
        .doc(uid)
        .snapshots()
        .map((event) {
      return FirestoreUserModel.fromJson(event.data() ?? {});
    });
  }

  Stream<PlayListModel> getPlaylist(String playlistId) {
    return _firebaseFirestore
        .collection(CollectionType.playlist.name)
        .doc(playlistId)
        .snapshots()
        .map((event) {
      return PlayListModel.fromMap(event.data() ?? {});
    });
  }

  Future<MovieResult> getMovie(String movieId) async {
    final movie = await _firebaseFirestore
        .collection(CollectionType.movie.name)
        .doc(movieId)
        .get();

    return MovieResult.fromJson(movie.data() ?? {});
  }

  // Future<List<PlayListModel>> getPlayList(String uid) async {
  //   final userData = _firebaseFirestore
  //       .collection(CollectionType.users.name)
  //       .doc(uid)
  //       .snapshots()
  //       .map((event) {
  //     return FirestoreUserModel.fromJson(event.data() ?? {});
  //   });

  //   if

  // }

  Future<void> setPrivateMovieList(
      String uid, List<MovieResult> movieResultList) async {
    await _firebaseFirestore.collection(CollectionType.users.name).doc(uid).set(
      {
        'private_movie_list': FieldValue.arrayUnion(movieResultList),
      },
      SetOptions(merge: false),
    );
  }

  Future<void> addPublicMovieList(String uid, MovieResult movieResult) async {
    await _firebaseFirestore.collection(CollectionType.users.name).doc(uid).set(
      {
        'public_movie_list': FieldValue.arrayUnion([movieResult.toJson()])
      },
      SetOptions(merge: true),
    );
  }

  Future<void> createPlaylist(String uid, String name, bool isPrivate) async {
    final newPlaylist = PlayListModel(
        name: name, isPrivate: isPrivate, description: "", url: "", movies: []);

    final savedPlaylist = await _firebaseFirestore
        .collection(CollectionType.playlist.name)
        .add(newPlaylist.toMap());

    await _firebaseFirestore.collection(CollectionType.users.name).doc(uid).set(
      {
        FirestoreUserModel.playListKey:
            FieldValue.arrayUnion([savedPlaylist.id]),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> addMovieToPlaylist(
      String uid, List<String> playListIdList, MovieResult movieResult) async {
    final movieAdded = await _firebaseFirestore
        .collection(CollectionType.movie.name)
        .add(movieResult.toJson());

    for (var element in playListIdList) {
      await _firebaseFirestore
          .collection(CollectionType.playlist.name)
          .doc(element)
          .set(
        {
          PlayListModel.movieListKey: FieldValue.arrayUnion([movieAdded.id])
        },
        SetOptions(merge: true),
      );
    }

    // final userData = await _firebaseFirestore
    //     .collection(CollectionType.users.name)
    //     .doc(uid)
    //     .get();

    // final playlist = (userData.data()?['playlist'] as List?)
    //     ?.map((e) => PlayListModel.fromJson(e))
    //     .toList();

    // final newPlaylist = playlist?.map((e) {
    //   if (idList.contains(e.id)) {
    //     e.movies.add(movieResult);
    //   }
    //   return e;
    // }).toList();

    // await _firebaseFirestore
    //     .collection(CollectionType.users.name)
    //     .doc(uid)
    //     .set({
    //   'playlist': newPlaylist?.map((e) => e.toJson()).toList(),
    // }, SetOptions(merge: false));
  }

  Future<void> setPublicMovieList(
      String uid, List<MovieResult> movieResultList) async {
    await _firebaseFirestore.collection(CollectionType.users.name).doc(uid).set(
      {'public_movie_list': FieldValue.arrayUnion(movieResultList)},
      SetOptions(merge: true),
    );
  }
}

enum CollectionType { users, playlist, movie }
