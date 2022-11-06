import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_playlist/core/repository/cloud_db_repository.dart';
import 'package:movie_playlist/core/repository/firebase_repository.dart';
import 'package:movie_playlist/locator.dart';

class AuthServices {
  FirebaseRepository get _firebaseRepository => locator<FirebaseRepository>();
  CloudDBRepository get _cloudDBRepositoy => locator<CloudDBRepository>();

  User? get currentUser => _firebaseRepository.currentUser;
  Stream<User?> userChanges() => _firebaseRepository.userChanges();

  Future<void> signupUser(String email, String password, String name) async {
    UserCredential userCredential = await _firebaseRepository
        .createUserWithEmailAndPassword(email: email, password: password);

    await _firebaseRepository.updateDisplayName(name);
    await _firebaseRepository.updateEmail(email);
    await _cloudDBRepositoy.saveUser(name, email, userCredential.user?.uid);
  }

  Future<void> signinUser(String email, String password) async {
    await _firebaseRepository.signInWithEmailAndPassword(email, password);
  }

  Future<void> saveUserIntoDB({
    required String uid,
    String? name,
    String? email,
  }) async {
    await _cloudDBRepositoy.saveUser(
      uid,
      name,
      email,
    );
  }
}
