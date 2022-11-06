import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  final instance = FirebaseAuth.instance;

  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    return await instance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> updateDisplayName(String name) async {
    await instance.currentUser?.updateDisplayName(name);
  }

  Future<void> updateEmail(String email) async {
    await instance.currentUser?.updateEmail(email);
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await instance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  User? get currentUser => instance.currentUser;

  Stream<User?> userChanges() => instance.userChanges();
}
