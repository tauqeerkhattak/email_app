import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_client/exceptions/app_exception.dart';
import 'package:email_client/models/access_token.dart';
import 'package:email_client/services/base_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class FirebaseService extends BaseService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    UserModel user = UserModel(
      email: email,
      name: name,
      uid: '',
    );
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credentials.user != null) {
      final uid = credentials.user!.uid;
      final updatedUser = user.copyWith(uid: uid);
      await _db.collection('users').doc(uid).set(updatedUser.toJson());
    } else {
      throw AppException(message: 'Cannot register, please try again!');
    }
  }

  Future<void> saveToken(AccessToken token) async {
    await safeFunction(() async {
      await _db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('tokens')
          .add(token.toJson());
    });
  }

  Future<AccessToken?> getAccessToken() async {
    return await safeActionWithValue(() async {
      final query = await _db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('tokens')
          .get();
      if (query.docs.isNotEmpty) {
        return AccessToken.fromJson(query.docs.first.data());
      } else {
        return null;
      }
    });
  }
}
