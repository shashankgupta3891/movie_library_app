import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_playlist/model/firebase_user_model.dart';
import 'package:movie_playlist/model/movie_result.dart';

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

  Future<void> setPublicMovieList(
      String uid, List<MovieResult> movieResultList) async {
    await _firebaseFirestore.collection(CollectionType.users.name).doc(uid).set(
      {'public_movie_list': FieldValue.arrayUnion(movieResultList)},
      SetOptions(merge: true),
    );
  }
}

enum CollectionType { users }
