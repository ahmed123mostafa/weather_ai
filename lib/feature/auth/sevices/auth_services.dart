import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      String firstName, String lastName, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName('$firstName $lastName');
      await userCredential.user?.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('An account already exists for that email.');
      } else {
        throw Exception(e.message ?? 'An error occurred.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('Network error');
      } else if (e.code == 'invalid-credential') {
        throw Exception('invalid credential');
      } else {
        throw Exception('Authentication failed. Please try again.');
      }
    } catch (e) {
      throw Exception('An unknown error occurred: ${e.toString()}');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<Map<String, String?>> getUserProfile() async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception('No user is currently signed in.');

    await user.reload();
    return {
      'name': user.displayName,
      'email': user.email,
    };
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      await user?.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
            'Please sign in again before attempting to delete your account.');
      } else {
        throw Exception(
            e.message ?? 'An error occurred while deleting your account.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
