import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> get user async {
    final user = auth.currentUser;
    return user;
  }

  Future<bool> signIn(String email, String pass) async {
    try {
      final result =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (result.user != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<User?> signInAnonymously() async {
    UserCredential user = await auth.signInAnonymously();
    return user.user;
  }

  Future signOut() async {
    try {
      return auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
