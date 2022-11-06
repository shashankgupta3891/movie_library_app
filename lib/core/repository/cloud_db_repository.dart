import 'package:cloud_firestore/cloud_firestore.dart';

class CloudDBRepository {
  Future<void> saveUser(String uid, String? name, String? email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name});
  }
}
