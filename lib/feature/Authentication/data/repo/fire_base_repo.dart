import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_weather_ai/feature/Authentication/domain/entities/app_user.dart';
import 'package:flutter_weather_ai/feature/Authentication/domain/repo/app_user_repo.dart';

class FireBaseAppUserRepo extends AppUserRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  // ignore: body_might_complete_normally_nullable
  Future<AppUser?> login(String email, String password) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return AppUser(email: email, uid: userCredential.user!.uid, name: "");
    } catch (e) {
      throw Exception('Login Failed: $e');
    }
  }

  @override
  Future<AppUser?> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return AppUser(email: email, uid: userCredential.user!.uid, name: name);
    } catch (e) {
      throw Exception('Failed to create account: $e');
    }
  }

  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }
    return AppUser(
        email: firebaseUser.email!, uid: firebaseUser.uid!, name: "");
  }
}
