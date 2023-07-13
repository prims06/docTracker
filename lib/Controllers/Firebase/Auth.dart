import 'package:doc_tracker/Controllers/Firebase/Firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> get user async {
    final user = auth.currentUser;
    return user;
  }

  static Future<bool> signIn(String email, String pass) async {
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

  static Future<bool> signUpEmailAndPassword(
      email, password, firstName, lastName, phone) async {
    print('$email $password $firstName $lastName $phone');
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Firebase.sendDataToID('users',credential.user!.uid, {
        'firstName': firstName,
        'lastName': lastName,
        'createDate': (DateTime.now().millisecondsSinceEpoch / 1000).round(),
        'phoneNumber': phone
      });
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> SignInWithEmailAndPassword(email, password) async {
    print('$email $password');
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future signOut() async {
    try {
      return auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
